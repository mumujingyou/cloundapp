import 'dart:ui';

import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class Data {
  static User user;

  static bool isLight = true; //白天模式
  static bool isConnect = true; //连接网路
  static bool isNetUse = true; //网络是否可用

//建立公共的event busEventBus eventBus = new EventBus();
  static EventBus themeEventBus = new EventBus();//主题通知
  static EventBus connectEventBus = new EventBus();//网络连接通知
  static EventBus checkIsShowEventBus = new EventBus();//申请新增通知

  static BusinessModel businessModel;
  static CustomerModel customerModel;
  static const String emptyListStr = "当前列表是空的";


  static const String phone="phone";
  static const String dept="dept";
  static const String username="username";
  static const String password="password";
  static const String headImgUrl="headImgUrl";
  static const String isLogin="isLogin";

  static const String access_token="access_token";


}


class Style {
  static const Color blueColor = Color.fromARGB(255, 95, 198, 253); //蓝颜色
  static Color themeColor = blueColor; //主题颜色
  static Color bgcolor = Colors.grey[300]; //页面背景颜色
  static Color contentColor = Colors.white; //内容主題背景颜色

  static double themeFontSize = 18; //主题字体大小
  static double appbarFontSize = 25; //标题字体大小
  static double smallFontSize = 13; //主题小字体
  static double midumnFontSize = 16; //主题小字体


  static TextStyle style = TextStyle(
    fontSize: themeFontSize, color: Colors.black54,); //文本主题
  static TextStyle smallStyle = TextStyle(
      fontSize: smallFontSize, color: Colors.black54); //小文本主题
  static TextStyle infoStyle = TextStyle(fontSize: themeFontSize,
      color: Colors.black54,
      fontWeight: FontWeight.bold); //文本提示主题
  static TextStyle greenStyle = TextStyle(
    fontSize: midumnFontSize, color: Colors.green,);
  static TextStyle redStyle = TextStyle(
    fontSize: midumnFontSize, color: Colors.red,);
  static TextStyle blueStyle = TextStyle(
    fontSize: midumnFontSize, color: blueColor,);

  static TextStyle headInfoStyle = TextStyle(fontSize: appbarFontSize,
      color: Colors.black54,
      fontWeight: FontWeight.bold); //文本提示主题
  static TextStyle midumStyle = TextStyle(
      fontSize: midumnFontSize, color: Colors.black54); //小文本主题
  static TextStyle textStyle = TextStyle(fontSize: 15, color: Colors.black54);




  static const double textFieldWidth = 200;


  static changeIsLight() {
    if (Data.isLight) {
      style = TextStyle(fontSize: themeFontSize, color: Colors.black54,); //文本主题
      smallStyle =
          TextStyle(fontSize: smallFontSize, color: Colors.black54); //小文本主题
      infoStyle = TextStyle(fontSize: themeFontSize,
          color: Colors.black54,
          fontWeight: FontWeight.bold); //文本提示主题
      contentColor = Colors.white;
      themeColor = Color.fromARGB(255, 95, 198, 253);
      midumStyle = TextStyle(fontSize: midumnFontSize, color: Colors.black54);
      textStyle = TextStyle(fontSize: 15, color: Colors.black54);
    } else {
      smallStyle = TextStyle(fontSize: smallFontSize,);
      infoStyle =
          TextStyle(fontSize: themeFontSize, fontWeight: FontWeight.bold);
      style = TextStyle(fontSize: themeFontSize,);
      contentColor = Colors.black38;
      themeColor = Color.fromARGB(255, 35, 112, 152);
      midumStyle = TextStyle(fontSize: midumnFontSize,);
      textStyle = TextStyle(fontSize: 15,);
    }
  }
}