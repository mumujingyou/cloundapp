// Copyright 2019 The rhyme_lph Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_calendar/r_calendar.dart';
import 'package:cloundapp/utils/application_util.dart';


enum RCalendarType {
  //正常
  normal,
  //不可用
  disable,
  //不是同一个月
  differentMonth,
  //选中的
  selected,
  //当天
  today,
  //异常
  exception,
  //请假
  qingjia,
  //休息日
  xiu
}

abstract class RCalendarCustomWidget {
  // 如果你想设置第一天是星期一，请更改MaterialLocalizations 的firstDayOfWeekIndex
  // 日 一 二 三 四 五 六
  //构建头部
  List<Widget> buildWeekListWidget(
      BuildContext context, MaterialLocalizations localizations);

  // 1 2 3 4 5 6 7
  //构建普通的日期
  Widget buildDateTime(
      BuildContext context, DateTime time, List<RCalendarType> types);

  // <  2019年 11月 >
  //构建年份和月份,指示器
  Widget buildTopWidget(BuildContext context, RCalendarController controller);

  //是否不可用,不可用时，无点击事件
  bool isUnable(BuildContext context, DateTime time, bool isSameMonth);

  //点击拦截，当返回true时进行拦截，就不会改变选中日期
  FutureOr<bool> clickInterceptor(BuildContext context, DateTime dateTime);

  //子view的高度
  double get childHeight;
}

class DefaultRCalendarCustomWidget extends RCalendarCustomWidget {

  final Function function;

  DefaultRCalendarCustomWidget({this.function});

  @override
  Widget buildDateTime(
      BuildContext context, DateTime time, List<RCalendarType> types) {
    TextStyle childStyle;
    BoxDecoration decoration;
    Color color=Colors.transparent;

    if (types.contains(RCalendarType.disable) ||
        types.contains(RCalendarType.differentMonth)) {
      childStyle = TextStyle(
        color: Colors.grey[400],
        fontSize: 18,
      );
      decoration = BoxDecoration();

    }
    if (types.contains(RCalendarType.normal)) {
      childStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
      );
      decoration = BoxDecoration();
    }

    if (types.contains(RCalendarType.today)) {
      childStyle = TextStyle(
        color: Colors.blue,
        fontSize: 18,
      );
    }

    if (types.contains(RCalendarType.exception)) {
      childStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
      );
      color=Colors.red;
    }

    if (types.contains(RCalendarType.qingjia)) {
      childStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
      );
      color=Colors.green;

    }

    if (types.contains(RCalendarType.xiu)) {
      childStyle = TextStyle(
        color: Colors.grey[400],
        fontSize: 18,
      );
    }

    if (types.contains(RCalendarType.selected)) {
      childStyle = TextStyle(
        color: Colors.white,
        fontSize: 18,
      );
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      );
    }
    return Tooltip(
     // message: MaterialLocalizations.of(context).formatFullDate(time),
        message:  ApplicationUtil.getTime(time),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(width: 30,
            child:types.contains(RCalendarType.xiu)==false?
          Container(width: 5,height: 5,color:color,):
            Text("休",style: TextStyle(color: Colors.red,fontSize: 6),),
            alignment: Alignment.centerRight,),
          Container(
              width: 30,height: 30,
              decoration: decoration,
              alignment: Alignment.center,
              child: Text(
                time.day.toString(),
                style: childStyle,
              ))

        ],
      ),
    );
  }

  @override
  List<Widget> buildWeekListWidget(
      BuildContext context, MaterialLocalizations localizations) {
     const List<String> _narrowWeekdays = <String>[
      '日',
      '一',
      '二',
      '三',
      '四',
      '五',
      '六',
    ];
//    return localizations.narrowWeekdays
    return _narrowWeekdays

        .map(
          (d) => Expanded(
            child: ExcludeSemantics(
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  d,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  double get childHeight => 50;

  @override
  FutureOr<bool> clickInterceptor(BuildContext context, DateTime dateTime) {
    return false;
  }

  @override
  bool isUnable(BuildContext context, DateTime time, bool isSameMonth) {
    return isSameMonth;
  }

  @override
  Widget buildTopWidget(BuildContext context, RCalendarController controller) {

    print(DateFormat('yyyy-MM').format(controller.displayedMonthDate));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
//            if(function!=null){
//              function();
//            }
            controller.previousPage();
          },
        ),
        SizedBox(
          width: 16,
        ),
        Text(
          DateFormat('yyyy-MM').format(controller.displayedMonthDate),
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
        SizedBox(
          width: 16,
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
//            if(function!=null){
//              function();
//            }
            controller.nextPage();
          },
        ),
      ],
    );
  }
}
