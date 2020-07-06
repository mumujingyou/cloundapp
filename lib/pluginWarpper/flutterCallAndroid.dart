//声明MethodChannel
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

var openMarketPlatform = MethodChannel('samples.chenhang/utils');
//处理按钮点击
openMarket() async{
  int result;
  //异常捕获
  try {
    //异步等待方法通道的调用结果
    result = await openMarketPlatform.invokeMethod('openAppMarket');
  }
  catch (e) {
    result = -1;
  }
  print("Result：$result");
}


var openSettingsPlatform = MethodChannel('cloundapp/plugin');
//处理按钮点击
openSettings() async{
  int result;
  //异常捕获
  try {
    //异步等待方法通道的调用结果
    result = await openSettingsPlatform.invokeMethod('openSettings');
  }
  catch (e) {
    result = -1;
  }
  print("Result：$result");
}

Future<List<String>> getJingwei() async{
  String result;
  List<String> resultList=[];
  //异常捕获
  try {
    //异步等待方法通道的调用结果
    result = await openSettingsPlatform.invokeMethod('getJingwei');
    if(result!=""){
      List<String> list=result.split(",");
      resultList.add(list[0].toString());
      resultList.add(list[1].toString());
    }
  }
  catch (e) {
  }
  Fluttertoast.showToast(msg: "${resultList[0]},${resultList[1]}",toastLength: Toast.LENGTH_LONG);
  print("Result：${resultList[0]},${resultList[1]}");
  return resultList;

}

Future close() async {
  await openSettingsPlatform.invokeMethod('close');
}