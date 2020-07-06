import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

Widget createCircleAvatar(
    {String path}) {
  return ClipOval(
    child:  createNetWorkImage(path: path),
  );
}

double scale=65;
Widget createCircleAvatarDefault() {
  return SizedBox(
    width: scale,
    height: scale,
    child: Image.asset(
      "assets/images/head.png",),
  );
}


Widget createNetWorkImage({String path}){
  return SizedBox(
    width: scale,
    height: scale,
    child: FadeInImage.assetNetwork(
      placeholder: "assets/images/loading.gif", //预览图
      fit: BoxFit.fitWidth,
      image: path,
    ),
  );
}



double radius =70;

Widget createCircleDefaultHeadImage({String content}) {
  return
    Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Style.themeColor,
      ),
      alignment: Alignment.center,
      child: Text(content, style: Style.headInfoStyle,),
    );
}
