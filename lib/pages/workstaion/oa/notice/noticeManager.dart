import 'dart:ui';

import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/noticeModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

//线索管理
class NoticeManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return NoticeManagerState();
  }
}

String loadMoreText = "没有更多数据";
TextStyle loadMoreTextStyle =
new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);


class NoticeManagerState extends State<NoticeManager> {
  List<NoticeModel> lists = [];

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  NoticeManagerState() {
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


  bool isEmpty = false;

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

  /**
   * 下拉刷新,必须异步async不然会报错
   */
  Future _pullToRefresh() async {
    currentPage = -1;

    lists.clear();
    loadMoreData();
    return null;
  }

  /**
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
  Future loadMoreData({String title}) async {
    this.currentPage++;
    int start = currentPage * pageSize;
    NoticeListModel noticeListModel = await OAAPI.selectNoticePageList(
      start: start, length: pageSize, title: title,);
    setState(() {
      lists.addAll(noticeListModel.data);
      totalSize = noticeListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({String title}) async {
    setState(() {
      lists.clear();
      isEmpty=false;
    });
    currentPage = -1;
    this.currentPage++;
    int start = currentPage * pageSize;
    NoticeListModel noticeListModel = await OAAPI.selectNoticePageList(
        start: start, length: pageSize, title: title);

    setState(() {
      lists.clear();
      lists.addAll(noticeListModel.data);
      totalSize = noticeListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("信息公告", automaticallyImplyLeading: true,),

      body:Data.isNetUse==true? Column(children: <Widget>[
        SearchBarDemoPage(hint: "输入名字", function: (value) {
          getListBySearch(title: value);
        },),
        Expanded(flex: 1, child:
        lists.length == 0
            ? new Center(
            child: isEmpty
                ? new Text(Data.emptyListStr)
                : new CircularProgressIndicator()) :
        new RefreshIndicator(
          color: Style.themeColor,

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
          ),
          onRefresh: _pullToRefresh,
        ),)
      ],)
          :Center(child: NetError(onPressed: () async {
        setState(() {
          init();
        });
        loadMoreData();
      }),),

    );
  }

  Widget createItem(NoticeModel noticeModel) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "${Routes.noticeDetail}?id=${noticeModel.id}",
            transition: TransitionType.fadeIn);
      },
      child: Column(

        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 65,
            color: Style.contentColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(noticeModel.title,
                  style: Style.infoStyle,),
                Text(noticeModel.createTime,
                  style: Style.style,),
              ],),
          ),
          Divider(height: 1, color: Colors.grey,)
        ],
      ),
    );
  }


  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      lists.clear();
      _pullToRefresh();
    }
    super.deactivate();
  }

}






