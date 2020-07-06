import 'dart:async';

import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/eventBus/eventBus.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class WorkStation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WorkStationState();
  }
}

class WorkStationState extends State<WorkStation> {

  StreamSubscription subscription;
  bool isCheckShow=false;
  @override
  void initState() {
    subscription = Data.checkIsShowEventBus.on<CheckIsShowEventBus>().listen((event) {
      setState(() {
        isCheckShow=event.isShow;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();//State销毁时，清理注册
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("工作台"),
        body: ListView(children: <Widget>[
          CRM(),
          HR(),
          OA(),
        ],)
    );
  }


  Widget CRM() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        showFrontInformation("CRM销售中心"),
        Container(
          alignment: Alignment.center,
          height: 100,
          color: Style.contentColor,
          child:

          GridView.count(
            physics: new NeverScrollableScrollPhysics(),

            crossAxisSpacing: 3,
            crossAxisCount: 4,
            mainAxisSpacing: 3,
            children: <Widget>[
              gridWidget("thread", "线索", () {
                Application.router.navigateTo(
                    context, "${Routes.threadManager}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("customer", "客户", () {
                Application.router.navigateTo(
                    context, "${Routes.customerManager}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("business", "商机", () {
                Application.router.navigateTo(
                    context, "${Routes.businessManager}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("agreenment", "合同", () {
                Application.router.navigateTo(
                    context, "${Routes.agreementManager}",
                    transition: TransitionType.fadeIn);
              }),
            ],
          ),


        )
      ],
    );
  }


  Widget HR() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        showFrontInformation("HR人事中心"),

        Container(
          alignment: Alignment.center,
          height: 200,
          color: Style.contentColor,
          child:

          GridView.count(
            physics: new NeverScrollableScrollPhysics(),

            crossAxisSpacing: 3,
            crossAxisCount: 4,
            mainAxisSpacing: 3,
            children: <Widget>[
              gridWidget("attendance", "考勤", () {
                Application.router.navigateTo(context, "${Routes.attendance}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("check", "审批", () {
                isCheckShow=false;

                Application.router.navigateTo(context, "${Routes.checkManager}",
                    transition: TransitionType.fadeIn);
              }, isShow: isCheckShow),
              gridWidget("askfor", "申请", () {
                Application.router.navigateTo(context, "${Routes.applyManager}",
                    transition: TransitionType.fadeIn);
              },),
              gridWidget("salary", "工资条", () {
                Application.router.navigateTo(context, "${Routes.wagesManager}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("recruit", "招聘", () {
                Application.router.navigateTo(context, "${Routes.employFront}",
                    transition: TransitionType.fadeIn);
              }),
            ],
          ),
        )
      ],
    );
  }

  Widget OA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        showFrontInformation("OA办公中心"),
        Container(
          alignment: Alignment.center,
          height: 100,
          color: Style.contentColor,
          child:

          GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            crossAxisSpacing: 3,
            crossAxisCount: 4,
            mainAxisSpacing: 3,
            children: <Widget>[
              gridWidget("target", "目标", () {
                Application.router.navigateTo(context, "${Routes.targetFront}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("infomation", "信息", () {
                Application.router.navigateTo(
                    context, "${Routes.noticeManager}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("means", "用品资产", () {
                Application.router.navigateTo(context, "${Routes.capitalFront}",
                    transition: TransitionType.fadeIn);
              }),
              gridWidget("work", "事务", () {
                Application.router.navigateTo(context, "${Routes.workFont}",
                    transition: TransitionType.fadeIn);
              }),
            ],
          ),


        )
      ],
    );
  }


  Widget gridWidget(String imageName, String name, Function function,
      {bool isShow = false}) {
    return InkWell(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(width: 70,
            child: isShow
                ? circleShape(width: 10, color: Colors.red)
                : circleShape(width: 10, color: Colors.transparent),
            alignment: Alignment.centerRight,),
          ApplicationUtil.getAssetsImage(imageName, size: 2),
          Text(name, style: Style.style,),
        ],
      ),
    );
  }
}
