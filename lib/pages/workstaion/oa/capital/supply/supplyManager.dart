import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/supplyModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';

class SupplyManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SupplyManagerState();
  }

}

class SupplyManagerState extends State<SupplyManager> {

  bool isEmpty = false;
  List<SuppliesApply> lists = [];


  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  SupplyManagerState() {
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
        loadMoreData(beginDate: startDateTime==null?null:DateFormat('yyyy-MM-dd').format(
            startDateTime));
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
  Future loadMoreData({String beginDate}) async {
    this.currentPage++;
    int start = currentPage * pageSize;
    SupplyListModel supplyListModel = await OAAPI.suppliesList(
        start: start, length: pageSize, beginDate: beginDate);
    setState(() {
      lists.addAll(supplyListModel.data);
      totalSize = supplyListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({String beginDate,}) async {

    setState(() {
      lists.clear();
      isEmpty=false;
    });

    currentPage = -1;
    this.currentPage++;
    int start = currentPage * pageSize;

    SupplyListModel supplyListModel = await OAAPI.suppliesList(
        start: start, length: pageSize, beginDate: beginDate);
    setState(() {
      lists.clear();
      lists.addAll(supplyListModel.data);
      totalSize = supplyListModel.total;
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
    currentPage = -1;
    lists.clear();
  }
  DateTime startDateTime;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "用品领用", automaticallyImplyLeading: true, actions: <Widget>[
        InkWell(
          onTap: () {
            Application.router.navigateTo(context, "${Routes.addSupply}",
                transition: TransitionType.fadeIn);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.add, size: 35,),
          ),
        ),
      ],),
      body:Data.isNetUse==true?
        Column(
        children: <Widget>[
          showFrontInformation("选择时间"),
          downArrowContainer(isImportant: false,
              name: "开始时间",
              content: startDateTime == null ? "" : DateFormat('yyyy-MM-dd')
                  .format(startDateTime),
              function: () {
                PickHelper.openDateTimePicker(
                    context, type: PickerDateTimeType.kYMD,
                    value: startDateTime,
                    title: "选择时间",
                    onConfirm: (Picker picker, List value) {
                      setState(() {
                        startDateTime =
                            (picker.adapter as DateTimePickerAdapter).value;
                        getListBySearch(
                            beginDate: DateFormat('yyyy-MM-dd').format(
                                startDateTime));
                      });
                    },
                    onCancel: () {
                      setState(() {
                        startDateTime =null;
                        getListBySearch();
                      });
                    }
                );
              }),
          showFrontInformation("用品领用列表"),

          Expanded(
            flex: 1,
            child: lists.length == 0 ? Center(
              child: isEmpty
                  ? Text(Data.emptyListStr)
                  : CircularProgressIndicator(),
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

  Widget createItem(SuppliesApply supplyModel) {
    String title = supplyModel.title;
    List<String> result = title.split("-");
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          color: Style.contentColor,
          child: InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, "${Routes.supplyDetail}?id=${supplyModel.id}",
                  transition: TransitionType.fadeIn);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:230,
                      child: Text("${result[0]}-${supplyModel.createName}",
                        softWrap: true,overflow: TextOverflow.ellipsis,
                        style: Style.infoStyle,),
                    ),
                    Text(result[2],
                      style: Style.style,),
                  ],
                ),
                Text(supplyModel.beginDate,
                  style: Style.style,),
              ],),
          ),
        ),
        Divider(height: 1, color: Colors.grey,)
      ],
    );
  }


  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      _pullToRefresh();
    }
    super.deactivate();
  }


}