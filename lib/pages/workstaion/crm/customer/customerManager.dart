import 'dart:ui';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/controller/customerManagerController.dart';
import 'package:cloundapp/controller/listViewController.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

//线索管理
class CustomerManager extends StatefulWidget {

  final bool isCanPop;

  const CustomerManager({Key key, this.isCanPop=false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomerManagerState();
  }
}

class CustomerManagerState extends State<CustomerManager> {


  CustomerManagerController controller;

  static CustomerManagerState state;

  CustomerManagerState() {
    state = this;
    controller =
    new CustomerManagerController(state: state);
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
            PickHelper.openSimpleDataPicker(context, list: customers,
                value: customers[controller.typeIndex], onConfirm:(picker, List value) {
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
              Application.router.navigateTo(context, "${Routes.addCustomer}",
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
        SearchBarDemoPage(key:controller.searchKey,hint: "输入客户类型",function: (value){
        controller.search(value);
        },),
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
                    child: createThreadItem(controller.lists[index]),
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

             Map result= await CRMAPI.deleteCustomer(ids: controller.lists[indexInList].id);
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

  Widget createThreadItem(CustomerModel customerModel) {
    return InkWell(
      onTap: (){

        if(widget.isCanPop){
          Navigator.pop(context,customerModel);
          return;
        }

        Application.router.navigateTo(context, "${Routes.customerDetail}?id=${customerModel.id}&type=${controller.type}",
            transition: TransitionType.fadeIn);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 65,
        color: Data.isLight?Style.contentColor:Colors.black87,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(customerModel.customerName,
              style: Style.style,),
            Text(getCustomerTypeStr(customerModel.customerType.toString()),
              style:  Style.style,),
          ],),
      ),
    );
  }

  @override
  void deactivate() {
    controller.deactivate();
  }

}




