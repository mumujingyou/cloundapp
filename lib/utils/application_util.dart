import 'dart:convert';

import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/loadingDialog.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/eventBus/eventBus.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ApplicationUtil{




  static String getAssetsImagePath(String name){
    return "assets/images/$name.png";
  }

  static Widget getAssetsImage(String name,{double size=1}){
    return Image.asset("assets/images/$name.png",scale: size,);
  }

  static Future showLoadingBool(BuildContext context,Function() function) async {
    BuildContext buildContext;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          buildContext = context;
          return new LoadingDialog(
            text: "拼命加载中…",
          );
        });
    bool result=await function();
    if(result){
      Navigator.pop(buildContext);
    }else{
      Navigator.pop(buildContext);
    }

  }

  static String getTime(DateTime dateTime){
    if(dateTime==null) return"";
    String time=dateTime.toString();
    return time.substring(0,19);//2020-04-13 15:30:31
  }

  static String getTime2(DateTime dateTime){
    if(dateTime==null) return "";
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }


  static bool isChinaPhoneLegal(String str) {
    return new RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }

  /// 检查是否是邮箱格式
  static bool isEmail(String input) {
    /// 邮箱正则
    final String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    if (input == null || input.isEmpty) return false;
    return new RegExp(regexEmail).hasMatch(input);
  }


  static var subscription;
  //网络状态描述
  static String connectStateDescription;
  static void listenNetChange(){
    //监测网络变化
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        connectStateDescription = "手机网络";
        Data.isConnect=true;
        Data.isNetUse=true;
        API.dio?.clear();//清空所有的网络请求。
        API.dio=null;

      } else if (result == ConnectivityResult.wifi) {
        connectStateDescription = "Wifi网络";
        Data.isConnect=true;
        Data.isNetUse=true;
        API.dio?.clear();//清空所有的网络请求。
        API.dio=null;


      } else {
        connectStateDescription = "无网络";
        Data.isConnect=false;
        Data.isNetUse=false;

      }

      Data.connectEventBus.fire(ConnectEventBus(Data.isConnect));
//      Fluttertoast.showToast(msg: "连接到$connectStateDescription");
    });
  }


  static Future<String> getWifiName() async {
    return await Connectivity().getWifiName();
  }

  static Future<String> getWifiIP() async {
    return await Connectivity().getWifiIP();
  }

  static Future<String> getWifiBSSID() async {
    return await Connectivity().getWifiBSSID();
  }

}