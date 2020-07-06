import 'dart:ui';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/controller/listViewController.dart';
import 'package:cloundapp/controller/threadManagerController.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

//线索管理
class ThreadManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return ThreadManagerState();
  }
}


class ThreadManagerState extends State<ThreadManager> {

  ThreadManagerController controller;

  static ThreadManagerState threadManagerState;

  ThreadManagerState() {
    threadManagerState = this;
    controller =
    new ThreadManagerController(state: threadManagerState);
  }

  @override
  void initState() {
    controller.init();
    controller.loadMoreData();
    //testTokenError();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            PickHelper.openSimpleDataPicker(context, list: typeList,
                value: typeList[controller.typeIndex],
                onConfirm: (picker, List value) {
                  controller.onConfirm(picker, value);
                });
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.appBarName,
                  style: TextStyle(fontSize: 25),
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),

        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Application.router.navigateTo(context, "${Routes.addThread}",
                  transition: TransitionType.fadeIn);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add, size: 35,),
            ),
          ),
        ],
      ),

      body: Data.isNetUse == true ? Column(children: <Widget>[
        SearchBarDemoPage(key: controller.searchKey,
          hint: "输入姓名或者状态",
          function: (value) {
           controller.search(value);
          },),
        Expanded(flex: 1, child:
        controller.lists.length == 0
            ? new Center(
            child: controller.isEmpty
                ? new Text(Data.emptyListStr)
                : new CircularProgressIndicator()) :
        new RefreshIndicator(
          color: Style.themeColor,

          child: SlideListView(
            needLoadMore: true,
            //是否要加载更多
            controller: controller.controller,
            //指明控制器加载更多使用
            itemBuilder: (bc, index) {
              if (index == controller.lists.length) {
                return LoadMore();
              } else {
                return GestureDetector(
                  child: createThreadItem(controller.lists[index]),
                  onTap: () {

                  },
                  // behavior: HitTestBehavior.translucent,
                );
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
              Map result = await CRMAPI.deleteThread(
                  ids: controller.lists[indexInList].id);
              if (result["data"]) {
                item.remove();
                Fluttertoast.showToast(msg: result["msg"]);
              } else {
                Fluttertoast.showToast(msg: result["msg"]);
              }
            }, [Colors.redAccent]),
            dataList: controller.lists,
          ),
          onRefresh: controller.pullToRefresh,
        ),)
      ],) : Center(child: NetError(onPressed: () async {
        setState(() {
          controller.init();
        });
        controller.loadMoreData();
      }),),

    );
  }

  Widget createThreadItem(ThreadModel threadModel) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context,
            "${Routes.threadDetail}?id=${threadModel
                .id}&type=${controller.type}",
            transition: TransitionType.fadeIn);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 65,
            color: Data.isLight ? Style.contentColor : Colors.black87,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(threadModel.clueName,
                  style: Style.style,),
                Text(getConnectStatusStr(threadModel),
                  style: Style.style,),
              ],),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    controller.deactivate();
  }


}








