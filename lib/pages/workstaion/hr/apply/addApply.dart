import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/eventBus/eventBus.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddApply extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddApplyState();
  }

}


class AddApplyState extends State<AddApply> {

  var siteCon = new TextEditingController(); //地点
  var durationCon = new TextEditingController(); //时长
  var amountCon = new TextEditingController(); //金额
  var reasonCon = new TextEditingController(); //原因
  var costRemarkCon = new TextEditingController();

  DateTime startDateTime;
  DateTime endDateTime;
  DateTime payTime;


  String applyType; //申请类型
  String vacateType; //请假类型
  String costType; //费用类型
  String reimbType; //报销类型


  void init() {
    applyType = applyTypeInts[0]; //申请类型
    vacateType = vacateTypeInts[0]; //请假类型
    costType = costTypeInts[0]; ////费用类型
    reimbType = reimbTypeInts[0]; ////费用类型

//    startDateTime = DateTime.now();
//    startDateTime= getTime(startDateTime);
//
//    endDateTime = DateTime.now();
//    endDateTime= getTime(endDateTime);

    //durationCon.text=getDuration().toString()+"天";


    applyTypeStr = applyTypeStrs[0];
    vacateTypeStr = vacateTypeStrs[0];
    reimbTypeStr = reimbTypeStrs[0];
    costTypeStr = costTypeStrs[0];
  }

  @override
  void initState() {
    init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("新增申请", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[

          downArrowContainer(isImportant: true,
              name: "申请类型", content: applyTypeStr ?? "", function: () {
                PickHelper.openSimpleDataPicker(
                    context, list: applyTypeStrs,
                    value: applyTypeStr,
                    onConfirm: (picker, List value) {
                      setState(() {
                        applyTypeStr = picker.getSelectedValues()[0];
                        applyType = applyTypeInts[value[0]];
                      });
                    });
              }),
          SizedBox(height: 20,),

          getResultWidget(),

          SizedBox(height: 20,),
          RoundedRectangleButton(
            name: "保存", width: 0, height: 50, function: save,)
        ],)

    );
  }

  Future save() async {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await HRAPI.addApply(
          applyType: applyType,
          vacateType: vacateType,
          reason: reasonCon.text,
          startTime: startDateTime==null?"":ApplicationUtil.getTime(startDateTime),
          endTime: endDateTime==null?"":ApplicationUtil.getTime(endDateTime),
          duration: getDuration().toString(),
          reimbType: reimbType,
          costRemark: costRemarkCon.text,
          costType: costType,
          costAmount: amountCon.text,
          payTime: ApplicationUtil.getTime(payTime),
          site: siteCon.text
      );

      if (result["data"] == true) {
        Fluttertoast.showToast(msg: result["msg"]);
        Navigator.pop(context);
        Data.checkIsShowEventBus.fire(CheckIsShowEventBus(true));
        return true;
      } else {
        Fluttertoast.showToast(msg: result["msg"]);
        return false;

      }
    });
  }


  //请假
  Widget qingJia() {
    return Column(children: <Widget>[
      downArrowContainer(isImportant: true,
          name: "请假类型", content: vacateTypeStr ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: vacateTypeStrs,
                value: vacateTypeStr,
                onConfirm: (picker, List value) {
                  setState(() {
                    vacateTypeStr = picker.getSelectedValues()[0];
                    vacateType = vacateTypeInts[value[0]];
                  });
                });
          }),

      downArrowContainer(isImportant: true,
          name: "开始时间",
          content: "${startDateTime == null ? "" : getTimeStr(startDateTime)}",
          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kMDYHM_AP,
                value: startDateTime,

                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                startDateTime = (picker.adapter as DateTimePickerAdapter).value;

                startDateTime = getTime(startDateTime);
                if (endDateTime != null) {
                  durationCon.text = getDuration().toString() + "天";
                }
              });
            });
          }),

      downArrowContainer(isImportant: true,
          name: "结束时间",
          content: "${endDateTime == null ? "" : getTimeStr(endDateTime)}",
          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kMDYHM_AP,
                value: endDateTime,
                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                endDateTime = (picker.adapter as DateTimePickerAdapter).value;
                endDateTime = getTime(endDateTime);
                durationCon.text = getDuration().toString() + "天";
              });
            });
          }),
      multiTextField("请假时长", durationCon, isImportant: true, isReadOnly: true),
      remarkContainer(controller: reasonCon, hint: "请假事由"),
    ],);
  }

  //报销
  Widget baoxiaoWidget() {
    return Column(
      children: <Widget>[
        downArrowContainer(isImportant: true,
            name: "报销类型", content: reimbTypeStr ?? "", function: () {
              PickHelper.openSimpleDataPicker(
                  context, list: reimbTypeStrs,
                  value: reimbTypeStr,
                  onConfirm: (picker, List value) {
                    setState(() {
                      reimbTypeStr = picker.getSelectedValues()[0];
                      reimbType = reimbTypeInts[value[0]];
                    });
                  });
            }),

        downArrowContainer(isImportant: true,
            name: "费用类型", content: costTypeStr ?? "", function: () {
              PickHelper.openSimpleDataPicker(
                  context, list: costTypeStrs,
                  value: costTypeStr,
                  onConfirm: (picker, List value) {
                    setState(() {
                      costTypeStr = picker.getSelectedValues()[0];
                      costType = costTypeInts[value[0]];
                    });
                  });
            }),

        downArrowContainer(isImportant: true,
            name: "发生时间",
            content: "${payTime == null ? "" : ApplicationUtil.getTime(payTime)}",
            function: () {
              PickHelper.openDateTimePicker(
                  context, type: PickerDateTimeType.kYMDHMS,
                  value: payTime,

                  title: "选择时间", onConfirm: (Picker picker, List value) {
                setState(() {
                  payTime = (picker.adapter as DateTimePickerAdapter).value;
                });
              });
            }),

        multiTextField(
            "费用金额", amountCon, isImportant: true,
            isReadOnly: false,
            hint: "请输入费用金额", textInputType: TextInputType.number),
        remarkContainer(controller: reasonCon, hint: "报销事由"),

        SizedBox(height: 2,),
        remarkContainer(controller: costRemarkCon, hint: "费用说明"),


      ],
    );
  }

  //加班
  Widget jiaBan() {
    return Column(children: <Widget>[

      downArrowContainer(isImportant: true,
          name: "开始时间",
          content: "${startDateTime == null ? "" : getTimeStr(startDateTime)}",

          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kMDYHM_AP,
                value: startDateTime,

                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                startDateTime = (picker.adapter as DateTimePickerAdapter).value;
                startDateTime = getTime(startDateTime);
                if (endDateTime != null) {
                  durationCon.text = getDuration().toString() + "天";
                }
              });
            });
          }),

      downArrowContainer(isImportant: true,
          name: "结束时间",
          content: "${endDateTime == null ? "" : getTimeStr(endDateTime)}",

          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kMDYHM_AP,
                value: endDateTime,
                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                endDateTime = (picker.adapter as DateTimePickerAdapter).value;
                endDateTime = getTime(endDateTime);
                durationCon.text = getDuration().toString() + "天";
              });
            });
          }),
      multiTextField("加班时长", durationCon, isImportant: true, isReadOnly: true),
      remarkContainer(controller: reasonCon, hint: "加班事由"),

    ],);
  }

  //出差
  Widget chuChai() {
    return Column(children: <Widget>[

      downArrowContainer(isImportant: true,
          name: "开始时间",
          content: "${startDateTime == null ? "" : getTimeStr(startDateTime)}",

          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kMDYHM_AP,
                value: startDateTime,

                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                startDateTime = (picker.adapter as DateTimePickerAdapter).value;
                startDateTime = getTime(startDateTime);
                if (endDateTime != null) {
                  durationCon.text = getDuration().toString() + "天";
                }
              });
            });
          }),

      downArrowContainer(isImportant: true,
          name: "结束时间",
          content: "${endDateTime == null ? "" : getTimeStr(endDateTime)}",

          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kMDYHM_AP,
                value: endDateTime,
                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                endDateTime = (picker.adapter as DateTimePickerAdapter).value;
                endDateTime = getTime(endDateTime);
                durationCon.text = getDuration().toString() + "天";
              });
            });
          }),
      multiTextField("出差地点", siteCon, isImportant: true, hint: "请输入出差地点"),
      remarkContainer(controller: reasonCon, hint: "出差事由"),

    ],);
  }


  Widget getResultWidget() {
    if (applyType == applyTypeInts[0]) {
      return qingJia();
    } else if (applyType == applyTypeInts[1]) {
      return jiaBan();
    } else if (applyType == applyTypeInts[2]) {
      return baoxiaoWidget();
    } else if (applyType == applyTypeInts[3]) {
      return chuChai();
    }
    return Container();
  }


  String getTimeStr(DateTime dateTime){
    if(dateTime.hour < 12){
      return "${DateFormat('yyyy-MM-dd').format(dateTime)}   上午";
    }else{
      return "${DateFormat('yyyy-MM-dd').format(dateTime)}   下午";
    }

  }

  //获得时间
  DateTime getTime(DateTime dateTime) {
    if (dateTime.hour < 12) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, 9);
    }
    else {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, 18);
    }
  }

  //获得时间长度
  double getDuration() {
    if(endDateTime==null||startDateTime==null) return 0.0;

    Duration duration=endDateTime.difference(startDateTime);

    int days = duration.inDays;

    int hours=duration.inHours;

    if(hours<0){
      endDateTime=null;
      startDateTime=null;
      Fluttertoast.showToast(msg: "结束时间不能大于开始时间，请重新选择时间");
      return 0.0;
    }

    if (startDateTime.hour == endDateTime.hour) {
      return days + 0.5;
    } else {
      if (endDateTime.hour < startDateTime.hour) {
        return days.toDouble();
      } else if (endDateTime.hour > startDateTime.hour) {
        return days + 1.0;
      }

      return days.toDouble();
    }
  }

}


