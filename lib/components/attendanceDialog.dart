/*
 * 自定义等待加载提示框
 * Created by ZhangJun on 2018-11-29
 */

import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceDialog extends Dialog {
  final String text;

  AttendanceDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 300,
          height: 300.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Style.contentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Row(mainAxisAlignment:MainAxisAlignment.end,children: <Widget>[
                  InkWell(child: ApplicationUtil.getAssetsImage("cross",size: 1.5),onTap: (){
                    Navigator.pop(context);
                  },),
                ],),
                SizedBox(height: 20,),
                ApplicationUtil.getAssetsImage("attendancesuccess",size: 2),

                SizedBox(height: 20,),
                Text("打卡成功", style: Style.infoStyle,),
                SizedBox(height: 20,),
                Text(text, style: Style.greenStyle,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class AttendanceFailDialog extends Dialog {
  final String text;

  AttendanceFailDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 300,
          height: 300.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Style.contentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment:MainAxisAlignment.end,children: <Widget>[
                  InkWell(child: ApplicationUtil.getAssetsImage("cross",size: 1.5),onTap: (){
                    Navigator.pop(context);
                  },),
                ],),
                SizedBox(height: 20,),
                ApplicationUtil.getAssetsImage("attendancefail",size: 2),

                SizedBox(height: 20,),
                Text("打卡失败", style: Style.infoStyle,),
                SizedBox(height: 20,),
                Container(width:200,child: Text(text,style: Style.style,textAlign: TextAlign.center,)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
