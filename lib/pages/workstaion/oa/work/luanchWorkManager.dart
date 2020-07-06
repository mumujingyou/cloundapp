import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/workModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class LaunchWorkManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LaunchWorkManagerState();
  }

}

class LaunchWorkManagerState extends State<LaunchWorkManager> {

  bool isEmpty = false;
  List<WorkModel> lists = [];

  String status = "";

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  LaunchWorkManagerState() {
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
        type: "1",status: status);
    setState(() {
      lists.addAll(workListModel.data);
      totalSize = workListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch() async {
    setState(() {
      lists.clear();
      isEmpty=false;
    });
    currentPage = -1;
    this.currentPage++;
    int start = currentPage * pageSize;

    WorkListModel workListModel = await OAAPI.workList(
        start: start, length: pageSize,
        status: status);
    setState(() {
      lists.clear();
      lists.addAll(workListModel.data);
      totalSize = workListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });

  }

  init(){
    status = "";
    statusStr=applyStatusStr[0];
    currentPage = -1;
    lists.clear();
  }
  @override
  void initState() {
    init();
    loadMoreData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "我发起的", automaticallyImplyLeading: true,actions: <Widget>[
        InkWell(
          onTap: (){
            Application.router.navigateTo(context, "${Routes.addLaunchWork}",
                transition: TransitionType.fadeIn);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.add,size: 35,),
          ),
        ),
      ],),
      body: Data.isNetUse==true?  Column(
        children: <Widget>[
          showFrontInformation("选择分类"),
          downArrowContainer(isImportant: true,
              name: "分类", content: statusStr, function: () {
                PickHelper.openSimpleDataPicker(
                    context, list: applyStatusStr,
                    value: statusStr,
                    onConfirm: (picker, List value) {
                      setState(() {
                        statusStr=picker.getSelectedValues()[0];
                        status=applyStatusInt[value[0]];
                        getListBySearch();
                      });
                    });
              }),
          showFrontInformation("申请列表"),

          Expanded(
            flex: 1,
            child:lists.length == 0? Center(
              child: isEmpty?Text(Data.emptyListStr):CircularProgressIndicator(),
            ): RefreshIndicator(
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

  Widget createItem(WorkModel workModel) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          color: Style.contentColor,
          child: InkWell(
            onTap: (){
              Application.router.navigateTo(context, "${Routes.launchWorkDetail}?id=${workModel.id}&type=${workModel.applyType}",
                  transition: TransitionType.fadeIn);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(workModel?.applyTime??"",
                      style: Style.style,),
                    Text(getApplyTypeStr(workModel.applyType),
                      style: Style.style,),
                  ],
                ),
                Text(getApplyStatusStr(workModel.status),
                  style:  Style.style,),
              ],),
          ),
        ),
        Divider(height: 1,color: Colors.grey,)
      ],
    );
  }


  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      status = applyStatusInt[0];
      _pullToRefresh();

    }
    super.deactivate();
  }


}