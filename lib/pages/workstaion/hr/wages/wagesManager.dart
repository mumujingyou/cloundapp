import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/hr/ApplyModel.dart';
import 'package:cloundapp/model/hr/MonthModel.dart';
import 'package:cloundapp/model/hr/wagesModel.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/pages/workstaion/hr/wages/wagesDetail.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class WagesManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WagesManagerState();
  }

}

class WagesManagerState extends State<WagesManager> {

  bool isEmpty = false;


  List<WagesModel> wagesModelList = [];

  Future getWagesList() async {
    WagesModelList wagesModelLists = await HRAPI.wagesSendList(month: "");
    setState(() {
      wagesModelList.addAll(wagesModelLists.data);
    });
  }


  @override
  void initState() {
    getWagesList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "我的工资条", automaticallyImplyLeading: true,),
      body: Data.isNetUse==true?wagesModelList.length == 0 ? Center(
        child: isEmpty
            ? Text(Data.emptyListStr)
            : CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: wagesModelList.length,
        itemBuilder: (context, index) {
          return createItem(wagesModelList[index]);
        },
      ):Center(child: NetError(onPressed: () async {
        setState(() {
          wagesModelList.clear();
        });
        getWagesList();
      }),),

    );
  }

  Widget createItem(WagesModel wagesModel) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Application.router.navigateTo(
                context, "${Routes.wagesDetail}?month=${wagesModel.month}&wagesModel=${Uri.encodeComponent(jsonEncode(wagesModel))}",
                transition: TransitionType.fadeIn);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            color: Style.contentColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(wagesModel?.month ?? "",
                  style: Style.style,),
                Text(wagesModel.sendBy ?? "",
                  style: Style.style,),
              ],),
          ),
        ),
        Divider(height: 1, color: Colors.grey,)
      ],
    );
  }

}