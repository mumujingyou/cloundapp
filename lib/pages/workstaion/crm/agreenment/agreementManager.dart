import 'dart:ui';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/controller/agreementManagerController.dart';
import 'package:cloundapp/controller/listViewController.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AgreementManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return AgreementManagerState();
  }
}

class AgreementManagerState extends State<AgreementManager> {

  AgreementManagerController controller;



  AgreementManagerState() {
    controller = new AgreementManagerController(state: this);
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
          onTap: (){
            PickHelper.openSimpleDataPicker(context, list: agreements,
                value: agreements[controller.typeIndex], onConfirm:(picker, List value) {
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
            onTap: (){
              Application.router.navigateTo(context, "${Routes.addAgreement}",
                  transition: TransitionType.fadeIn);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add,size: 35,),
            ),
          ),
        ],
      ),

      body: Data.isNetUse==true?Column(children: <Widget>[
        SearchBarDemoPage(function: (value){
          controller.search(value);
        },key: controller.searchKey,),
         Expanded(flex: 1,child:
         controller.lists.length == 0
             ? new Center(
             child: controller.isEmpty
                 ? new Text(Data.emptyListStr)
                 : new CircularProgressIndicator()) :
        new RefreshIndicator(
          color: Style.themeColor,

          child: SlideListView(
            needLoadMore: true,//是否要加载更多

            controller: controller.controller, //指明控制器加载更多使用
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
                children: <Widget>[Icon(Icons.delete,color: Colors.white,), Text('删除',style: TextStyle(color: Colors.white),)],
              );
            }, (int indexInList, int index, BaseSlideItem item) async {
             Map result= await CRMAPI.removeContract(ids: controller.lists[indexInList].id);
             if(result["data"]){
               item.remove();
               Fluttertoast.showToast(msg: result["msg"]);
             }else{
               Fluttertoast.showToast(msg: result["msg"]);
             }
            }, [Colors.redAccent]),
            dataList: controller.lists,
          ),
          onRefresh: controller.pullToRefresh,
        ),)
      ],):Center(child: NetError(onPressed: () async {
        setState(() {
          controller.init();
        });
        controller.loadMoreData();
      }),),

    );
  }

  Widget createItem(AgreementModel agreementModel) {
    return InkWell(
      onTap: (){

        Application.router.navigateTo(context, "${Routes.agreementDetail}?id=${agreementModel.id}&type=${controller..type}",
            transition: TransitionType.fadeIn);
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 65,
            padding: EdgeInsets.all(10),

            color: Data.isLight?Style.contentColor:Colors.black87,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(agreementModel?.contractName??"",
                      style: Style.infoStyle,),
                    Text("￥${agreementModel?.amount??""}|${agreementModel?.clientName??""}",
                      style: Style.smallStyle,),
                  ],
                ),
                Text(getAgreementTypesStr(int.parse(agreementModel.followStatus)),
                  style:  Style.style,),
              ],),
          ),

        ],
      ),
    );
  }

  @override
  void deactivate() {
   controller.deactivate();
    super.deactivate();
  }

}





