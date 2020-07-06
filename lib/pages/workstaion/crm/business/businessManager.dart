import 'dart:ui';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/controller/businessManagerController.dart';
import 'package:cloundapp/controller/listViewController.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
import 'package:flutter_sujian_select/flutter_select.dart';
import 'package:fluttertoast/fluttertoast.dart';


//商机管理
class BusinessManager extends StatefulWidget {

  final bool isCanPop;

  const BusinessManager({Key key, this.isCanPop = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BusinessManagerState();
  }
}


class BusinessManagerState extends State<BusinessManager> {


  BusinessListModel businessListModel;

  BusinessManagerController controller;

  static BusinessManagerState threadManagerState;

  BusinessManagerState() {
    threadManagerState = this;
    controller =
    new BusinessManagerController(state: threadManagerState);
  }

  @override
  void initState() {
    controller.init();
    controller.loadMoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            PickHelper.openSimpleDataPicker(context, list: businesses,
                value: businesses[controller.typeIndex],
                onConfirm: (picker, List value) {
                  controller.onConfirm(picker, value);
                });
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.appBarName ?? "",
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
              Application.router.navigateTo(context, "${Routes.addBusindess}",
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
        SearchBarDemoPage(hint: "输入商机名字", function: (value) {
          controller.search(value);
        },key: controller.searchKey,),
        Container(padding: EdgeInsets.all(10), height: 250,
          color: Style.contentColor, child: Column(children: <Widget>[
            Expanded(child: getTypeShape(), flex: 1,),
            Expanded(child: getShape(), flex: 4,)
          ],),),
        SizedBox(height: 2,),

        Expanded(flex: 2, child:
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
                  child: Container(
                    child: createItem(controller.lists[index]),
                  ),
                  onTap: () {

                  },
                  behavior: HitTestBehavior.translucent,
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
              Map result = await CRMAPI.removeOpportunity(
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
        ),),

      ],) : Center(child: NetError(onPressed: () async {
        setState(() {
          controller.init();
        });
        controller.loadMoreData();
      }),),

    );
  }


  Widget getShape() {
    if (businessListModel == null) return Container();
    return Row(crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        shapeItem(function: () {
          controller.followStatus = 6021;
          key.currentState.setIndex(-1);
          controller.getListBySearch();
        },
            content: "${businessListModel?.approachlNum}\n初步接洽",
            height: businessListModel?.approachlNum,
            color: businessListModel?.approachlNum == 0
                ? Colors.transparent
                : Style.themeColor),
        SizedBox(width: 5,),
        shapeItem(function: () {
          controller.followStatus = 6022;
          key.currentState.setIndex(-1);
          controller.getListBySearch();
        },
            content: "${businessListModel?.confirmNum}\n需求确定",
            height: businessListModel?.confirmNum,
            color: businessListModel?.confirmNum == 0
                ? Colors.transparent
                : Style.themeColor),
        SizedBox(width: 5,),
        shapeItem(function: () {
          controller.followStatus = 6023;
          key.currentState.setIndex(-1);
          controller.getListBySearch();
        },
            content: "${businessListModel?.offerNum}\n方案/报价",
            height: businessListModel?.offerNum,
            color: businessListModel?.offerNum == 0
                ? Colors.transparent
                : Style.themeColor),
        SizedBox(width: 5,),
        shapeItem(function: () {
          controller.followStatus = 6024;
          key.currentState.setIndex(-1);
          controller.getListBySearch();
        },
            content: "${businessListModel?.contractNum}\n谈判/合同",
            height: businessListModel?.contractNum,
            color: businessListModel?.contractNum == 0
                ? Colors.transparent
                : Style.themeColor),
      ],
    );
  }

  GlobalKey<SelectGroupState> key = GlobalKey();

  Widget getTypeShape() {
    if (businessListModel == null) return Container();
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SelectGroup<String>(
            key: key,
            style: SelectStyle.rectangle,
            selectColor: Style.themeColor,
            borderColor: Style.themeColor,
            index: 0,
            items: <SelectItem<String>>[
              SelectItem(label: '全部${businessListModel.allNum}', value: null),
              SelectItem(label: '赢单${businessListModel.winNum}', value: "6025"),
              SelectItem(
                  label: '输单${businessListModel.loseNum}', value: "6026"),
            ],
            onSingleSelect: (String value) {
              if (value == null) {
                controller.followStatus = null;
                controller.getListBySearch();
              } else {
                controller.followStatus = int.parse(value);
                controller.getListBySearch();
              }
            },
          ),

        ],
      ),
    );
  }

  Widget shapeItem(
      {String content, Color color, Function function, int height}) {
    return Expanded(flex: 1, child: InkWell(
      onTap: function,
      child: Container(
        color: color,
        height: controller.containerHeight(height),
        child: Text(content ?? "", textAlign: TextAlign.center,),
        alignment: Alignment.bottomCenter,
      ),
    ));
  }


  Widget createItem(BusinessModel businessModel) {
    return InkWell(
      onTap: () {
        if (widget.isCanPop) {
          Navigator.pop(context, businessModel);
          return;
        }
        Application.router.navigateTo(
            context,
            "${Routes.businessDetail}?id=${businessModel.id}&type=${controller
                .type}",
            transition: TransitionType.fadeIn);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),

            color: Data.isLight ? Style.contentColor : Colors.black87,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(businessModel?.oppoName ?? "",
                      style: Style.infoStyle,),
                    Text("￥${businessModel?.amount ?? ""}|${businessModel
                        ?.clientName ?? ""}",
                      style: Style.smallStyle,),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(businessModel.createTime ?? "",
                      style: Style.smallStyle,),
                    Text(getBusinessTypeStr(
                        int.parse(businessModel?.followStatus ?? "")),
                      style: Style.smallStyle,),
                  ],
                )
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







