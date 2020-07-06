import 'dart:async';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(children: <Widget>[
        new Container(
          width: double.infinity,
          height: double.infinity,
          color: Style.themeColor,
        ),
        Align(
          child: Container(width:30,child:
          Text("找不到该界面",textAlign:TextAlign.center ,style:
          TextStyle(color: Style.contentColor,fontSize: 50),)),
          alignment: new FractionalOffset(0.5, 0.5),
        ),
      ]),
    );
  }

}

