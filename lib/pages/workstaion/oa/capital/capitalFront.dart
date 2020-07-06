import 'dart:ui';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/mylisttile.dart';
import 'package:cloundapp/components/search.dart';
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


class CapitalFront extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CapitalFrontState();
  }
}


class CapitalFrontState extends State<CapitalFront> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: createAppBar("用品资产",automaticallyImplyLeading: true),

      body: Column(children: <Widget>[
        frontWidget(name: "用品领用",function: (){
            Application.router.navigateTo(
                context, "${Routes.supplyManager}",
                transition: TransitionType.fadeIn);
          }),
          frontWidget(name: "资产领用",function: (){
            Application.router.navigateTo(
                context, "${Routes.capitalManager}",
                transition: TransitionType.fadeIn);
          }),
      ],),

    );
  }



}



