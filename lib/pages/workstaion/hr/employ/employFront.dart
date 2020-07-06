import 'dart:ui';

import 'package:cloundapp/components/mylisttile.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class EmployFront extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return EmployFrontState();
  }
}


class EmployFrontState extends State<EmployFront> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("招聘", style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        frontWidget(name: "招聘信息", function: () {
          Application.router.navigateTo(
              context, "${Routes.employManager}",
              transition: TransitionType.fadeIn);
        }),
        frontWidget(name: "我的面试", function: () {
          Application.router.navigateTo(
              context, "${Routes.talentManager}",
              transition: TransitionType.fadeIn);
        }),

      ],),

    );
  }


}



