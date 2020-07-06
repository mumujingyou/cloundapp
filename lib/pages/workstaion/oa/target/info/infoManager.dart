import 'dart:ui';

import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/infoModel.dart';
import 'package:cloundapp/model/oa/planModel.dart';
import 'package:cloundapp/model/oa/taskModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return InfoManagerState();
  }
}

String loadMoreText = "没有更多数据";
TextStyle loadMoreTextStyle =
new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);


class InfoManagerState extends State<InfoManager> {
  List<WorkInfo> lists = [];

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  InfoManagerState() {
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
    WorkInfoListModel workInfoListModel = await OAAPI.workInfoList(
        start: start, length: pageSize, title: title);
    setState(() {
      lists.addAll(workInfoListModel.data);
      totalSize = workInfoListModel.total;
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
    WorkInfoListModel workInfoListModel = await OAAPI.workInfoList(
        start: start, length: pageSize, title: title);

    setState(() {
      lists.clear();
      lists.addAll(workInfoListModel.data);
      totalSize = workInfoListModel.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: createAppBar("我的工作报告",automaticallyImplyLeading: true, actions: <Widget>[
        InkWell(
          onTap: () {
            Application.router.navigateTo(context, "${Routes.addInfo}",
                transition: TransitionType.fadeIn);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.add, size: 35,),
          ),
        ),

      ],),

      body:Data.isNetUse==true? Column(children: <Widget>[
        SearchBarDemoPage(hint: "输入名字", function: (value) {
          getListBySearch(title: value);
        },),
        Expanded(flex: 1, child:
        lists.length == 0
            ? new Center(
            child: isEmpty
            ? new Text(Data.emptyListStr)
            : new CircularProgressIndicator()):
        new RefreshIndicator(
          color: Style.themeColor,

          child: SlideListView(
            needLoadMore: true,
            //是否要加载更多

            controller: _controller,
            //指明控制器加载更多使用
            itemBuilder: (bc, index) {
              if (index == lists.length) {
                return LoadMore();
              } else {
                if(lists[index].status=="1"){//创建时
                  return GestureDetector(
                    child: Container(
                      child: createItem(
                        workInfo: lists[index],),
                    ),
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                  );
                }else{
                  return UnSlideContentWidget(lists[index]);

                }
              }
            },
            actionWidgetDelegate:
            ActionWidgetDelegate(1, (actionIndex, listIndex) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.delete, color: Colors.white,),
                  Text('删除', style: TextStyle(color: Colors.white),)
                ],
              );
            }, (int indexInList, int index, BaseSlideItem item) async {
              Map result = await OAAPI.removeWorkInfo(
                  id: lists[indexInList].id);
              if (result["data"]) {
                item.remove();
                Fluttertoast.showToast(msg: result["msg"]);
              } else {
                Fluttertoast.showToast(msg: result["msg"]);
              }
            }, [Colors.redAccent]),
            dataList: lists,
          ),
          onRefresh: _pullToRefresh,
        ),)
      ],):Center(child: NetError(onPressed: () async {
        setState(() {
          init();
        });
        loadMoreData();
      }),),

    );
  }

  Widget createItem({WorkInfo workInfo}) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "${Routes.infoDetail}?id=${workInfo.id}&status=${workInfo.status}",
            transition: TransitionType.fadeIn);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),

            height: 65,
            color: Data.isLight?Style.contentColor:Colors.black87,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(workInfo.title,
                  style: Style.style,),
                Text(getInfoStatusStr(workInfo.status),
                  style: Style.style,),
              ],),
          ),
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



//加载更多    必须继承UnSlidableWrapper  否则会出现左滑的情况
class LoadMore extends UnSlidableWrapper {
  @override
  Widget build(BuildContext context) {
    return _buildProgressMoreIndicator();
  }

  Widget _buildProgressMoreIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new Text(loadMoreText, style: loadMoreTextStyle,),
      ),
    );
  }
}


//状态为不是创建时使用   创建时是可以左滑删除的
class UnSlideContentWidget extends UnSlidableWrapper {

  final WorkInfo workInfo;

  UnSlideContentWidget(this.workInfo);


  Widget createItem({WorkInfo workInfo, BuildContext buildContext}) {
    return InkWell(
      onTap: () {
        if(workInfo.status=="3"){
          Application.router.navigateTo(
              buildContext, "${Routes.infoDetail}?id=${workInfo.id}&status=${workInfo.status}",
              transition: TransitionType.fadeIn);
        }else{
          Application.router.navigateTo(
              buildContext, "${Routes.infoDetail}?id=${workInfo.id}&status=${workInfo.status}",
              transition: TransitionType.fadeIn);
        }

      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 70,
            color:Style.contentColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(workInfo.title,
                  style: Style.style,),
                Text(getInfoStatusStr(workInfo.status),
                  style: Style.style,),
              ],),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return createItem(workInfo: workInfo,buildContext: context);
  }
}



