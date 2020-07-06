import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/hr/ApplyModel.dart';
import 'package:cloundapp/model/oa/workModel.dart';
import 'package:cloundapp/pages/workstaion/hr/check/selectUtil/select_group.dart';
import 'package:cloundapp/pages/workstaion/hr/check/selectUtil/select_item.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class CheckWorkManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckWorkManagerState();
  }

}

class CheckWorkManagerState extends State<CheckWorkManager> {

  bool isEmpty = false;
  List<WorkModel> lists = [];

  String status = "0,1";

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  CheckWorkManagerState() {
    //固定写法，初始化滚动监听器，加载更多使用
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && lists.length < totalSize) {
        setState(() {
          loadMoreText = "正在加载中...";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
        });
        loadMoreData();
      } else {
        setState(() {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
        });
      }
    });
  }


  /*
   * 下拉刷新,必须异步async不然会报错
   */
  Future _pullToRefresh() async {
    currentPage = -1;
    lists.clear();
    loadMoreData();
    return null;
  }

  /*
   * 加载更多进度条
   */
  Widget _buildProgressMoreIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new Text(loadMoreText, style: loadMoreTextStyle),
      ),
    );
  }

  //下拉加载列表数据
  Future loadMoreData() async {
    this.currentPage++;
    int start = currentPage * pageSize;

    WorkListModel workListModel = await OAAPI.workList(
        start: start, length: pageSize,
        status: status,type: checkType);
    setState(() {
      lists.addAll(workListModel.data);
      totalSize = workListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({var status, var type}) async {
    setState(() {
      lists.clear();
      isEmpty=false;
    });
    currentPage = -1;
    this.currentPage++;
    int start = currentPage * pageSize;
    WorkListModel workListModel = await OAAPI.workList(
        start: start, length: pageSize,
        status: status,type: type);
    setState(() {

      lists.addAll(workListModel.data);
      totalSize = workListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }


  @override
  void initState() {
    init();
    loadMoreData();
    super.initState();
  }

  init(){
    status = "0,1";
    checkTypeStr =checkTypeStrs[0];
    currentPage = -1;
    lists.clear();
  }

  String checkType = checkTypeInts[0]; //审批类型
  double width = 0;
  double fontSize = 20;

  @override
  Widget build(BuildContext context) {
    if(width==0){
      width = MediaQuery
          .of(context)
          .size
          .width;
    }
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            PickHelper.openSimpleDataPicker(context, list: checkTypeStrs,
                value: checkTypeStr,
                onConfirm: (picker, List value) {

                  setState(() {
                    checkTypeStr = picker.getSelectedValues()[0];
                    checkType = checkTypeInts[value[0]];
                  });
                  getListBySearch(type: checkType,status: status);
                });
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  checkTypeStr,
                  style: TextStyle(fontSize: 25),
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),

        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.add, size: 35, color: Colors.transparent,),
          ),
        ],
      ),
      body:Data.isNetUse==true? Column(
        children: <Widget>[

          getTypeShape(),
          SizedBox(height: 10,),
          Expanded(
            flex: 1,
            child: lists.length == 0 ? Center(
              child: isEmpty ? Text(Data.emptyListStr) : CircularProgressIndicator(),
            ) : RefreshIndicator(
              child: ListView.builder(
                itemCount: lists.length + 1,
                itemBuilder: (context, index) {
                  if (index == lists.length) {
                    return _buildProgressMoreIndicator();
                  } else {
                    return createItem(lists[index]);
                  }
                },
                controller: _controller, //指明控制器加载更多使用
              ), onRefresh: _pullToRefresh,
            ),
          ),

        ],
      ):Center(child: NetError(onPressed: () async {
        setState(() {
          init();
        });
        loadMoreData();
      }),),

    );
  }

  GlobalKey<SelectGroupState> key = GlobalKey();

  Widget getTypeShape() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectGroup<String>(
            key: key,
            fontSize: fontSize,
            padding: EdgeInsets.symmetric(horizontal: getWidth(), vertical: 15),
            style: SelectStyle.rectangle,
            selectColor: Style.themeColor,
            borderColor: Style.themeColor,
            index: 0,
            items: <SelectItem<String>>[
              SelectItem(label: '已处理', value: "0,1"),
              SelectItem(label: '待处理', value: "2"),

            ],
            onSingleSelect: (String value) {
              status=value;
              getListBySearch(status: status, type: checkType);
            },
          ),

        ],
      ),
    );
  }


  double getWidth() {
    return ((width - fontSize * 6) / 4) - 1.5;
  }

  Widget createItem(WorkModel workModel) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (){
            Application.router.navigateTo(
                context, "${Routes.checkWorkDetail}?id=${workModel.id}&checkType=${checkType}&type=${workModel.applyType}",
                transition: TransitionType.fadeIn);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            color: Style.contentColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:250,
                      child: Text("${workModel.userName} 申请 ${workModel.applyTypeStr}",
                        softWrap: true,overflow: TextOverflow.ellipsis,
                        style: Style.infoStyle,),
                    ),
                    SizedBox(height: 10,),
                    Text("提交时间： ${workModel?.applyTime??""}",
                      style: Style.style,),

                  ],
                ),
                Text(getApplyStatusStr(workModel.status),
                  style: Style.greenStyle,),
              ],),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
     // status = applyStatusInt[0];
      _pullToRefresh();
    }
    super.deactivate();
  }


}