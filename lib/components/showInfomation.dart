import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

Widget showFrontInformation(String name){
  return  Container(height: 40,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      child: Text(name, style: Style.infoStyle,));
}