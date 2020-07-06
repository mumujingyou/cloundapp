import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

Widget circleShape({double width=20,Color color}){
  return new Container(
    width: width,
    height: width,
    decoration: BoxDecoration(
      color: color??Style.themeColor,
      shape: BoxShape.circle,
    ),
  );
}
