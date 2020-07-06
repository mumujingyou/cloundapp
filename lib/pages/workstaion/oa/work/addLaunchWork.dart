import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddLaunchWork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddLaunchWorkState();
  }

}


class AddLaunchWorkState extends State<AddLaunchWork> {

  var nameCon = new TextEditingController(); //名字
  var normsCon = new TextEditingController(); //规格
  var moneyCon = new TextEditingController(); //金额
  var outlineCon = new TextEditingController(); //项目概述
  var createByCon = new TextEditingController(); //发起人

  var siteCon = new TextEditingController(); //地点
  var durationCon = new TextEditingController(); //时长
  var amountCon = new TextEditingController(); //数量
  var reasonCon = new TextEditingController(); //原因
  var remarksCon = new TextEditingController();

  DateTime startDateTime;
  DateTime endDateTime;


  String applyType; //申请类型
  String yongzhangType; //用章类型
  String costType; //费用类型
  String hireForm; //聘用形式
  String turnStat; //转正状态


  void init() {
    applyType = applyTypeInts[0]; //申请类型
    costType = costTypeInts[0]; ////费用类型
    yongzhangType = yongZhangTypeInts[0];

    createByCon.text = Data.user.name;

    applyTypeStr = applyTypeStrs[0];
    costTypeStr = costTypeStrs[0];

    hireForm=hireFormStr;
    turnStat=turnStatStr;
  }


  String applyNo;

  getNumber() async {
    applyNo = await OAAPI.getNumber(type: "8");
  }

  @override
  void initState() {
    init();
    getNumber();
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
////`1001外出、1002采购、1003费用、1004用章、1005立项申请、1006转正、1007离职
  Future save() async {
    if (applyType == applyTypeInts[0]) {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await OAAPI.saveOut(
          applyType: applyType,
          reason: reasonCon.text,
          startTime: ApplicationUtil.getTime(startDateTime),
          endTime: ApplicationUtil.getTime(endDateTime),
          duration: getDuration().toString(),
          site: siteCon.text,
          applyNo: applyNo,
        );

        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.pop(context);
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    } else if (applyType == applyTypeInts[1]) {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await OAAPI.savePurchase(
            applyType: applyType,
            reason: reasonCon.text,
            delivery: DateFormat('yyyy-MM-dd').format(startDateTime),
            applyNo: applyNo,
            goodsName: nameCon.text,
            spec: normsCon.text,
            money: moneyCon.text,
            amount: amountCon.text,
            remarks: remarksCon.text
        );

        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.pop(context);
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    } else if (applyType == applyTypeInts[2]) {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await OAAPI.saveCost(
          applyType: applyType,
          reason: reasonCon.text,
          payTime: DateFormat('yyyy-MM-dd').format(startDateTime),
          applyNo: applyNo,
          money: moneyCon.text,
          remarks: remarksCon.text,
          costType: costType,
        );

        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.pop(context);
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    } else if (applyType == applyTypeInts[3]) {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await OAAPI.saveChapter(
            applyType: applyType,
            reason: reasonCon.text,
            useTime: DateFormat('yyyy-MM-dd').format(startDateTime),
            applyNo: applyNo,
            amount: amountCon.text,
            type: yongzhangType,
            fileName: nameCon.text
        );

        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.pop(context);
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    } else if (applyType == applyTypeInts[4]) {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await OAAPI.saveProject(
          applyType: applyType,
          projectName: nameCon.text,
          projectTime: DateFormat('yyyy-MM-dd').format(startDateTime),
          applyNo: applyNo,
          money: moneyCon.text,
          remarks: remarksCon.text,
          outline: outlineCon.text,
        );

        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.pop(context);
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    } else if (applyType == applyTypeInts[5]) {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await OAAPI.savePositive(
            applyType: applyType,
            selfReview: remarksCon.text,
            positiveTime: DateFormat('yyyy-MM-dd').format(startDateTime),
            applyNo: applyNo
        );

        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.pop(context);
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    } else if (applyType == applyTypeInts[6]) {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await OAAPI.saveDimission(
          applyType: applyType,
          hireForm: hireForm,
          leaveTime: DateFormat('yyyy-MM-dd').format(startDateTime),
          applyNo: applyNo,
          turnStat: turnStat,
          reason: reasonCon.text,
        );

        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.pop(context);
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    }
  }


  //外出
  Widget waichuWidget() {
    return Column(children: <Widget>[

      multiTextField("外出地点", siteCon, isImportant: true, hint: "请输入外出地点"),

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
      multiTextField("外出时长", durationCon, isImportant: true, isReadOnly: true),
      remarkContainer(controller: reasonCon, hint: "外出事由"),
    ],);
  }

  //采购
  Widget caigouWidget() {
    return Column(
      children: <Widget>[
        multiTextField(
            "物品名称", nameCon, isImportant: true,
            isReadOnly: false,
            hint: "请输入物品名称",),
        downArrowContainer(isImportant: true,
            name: "期望交付时间",
            content: startDateTime==null?"":DateFormat('yyyy-MM-dd').format(startDateTime),
            function: () {
              PickHelper.openDateTimePicker(
                  context,
                  type: PickerDateTimeType.kYMD,
                  value: startDateTime,
                  title: "选择时间", onConfirm: (Picker picker, List value) {
                setState(() {
                  startDateTime =
                      (picker.adapter as DateTimePickerAdapter).value;
                });
              });
            }),
        multiTextField(
            "型号或规格", normsCon, isImportant: true,
            isReadOnly: false,
            hint: "请输入物品型号或规格"),
        multiTextField(
            "数量", amountCon, isImportant: true,
            isReadOnly: false,
            hint: "请输入费用金额", textInputType: TextInputType.number),
        multiTextField(
            "金额", moneyCon, isImportant: true,
            isReadOnly: false,
            hint: "请输入费用金额", textInputType: TextInputType.number),
        remarkContainer(controller: reasonCon, hint: "采购事由"),
        SizedBox(height: 2,),
        remarkContainer(controller: remarksCon, hint: "备注"),
      ],
    );
  }


  //费用
  Widget feiyongWidget() {
    return Column(
      children: <Widget>[
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
            name: "时间",
            content: startDateTime==null?"":DateFormat('yyyy-MM-dd').format(startDateTime),
            function: () {
              PickHelper.openDateTimePicker(
                  context,
                  type: PickerDateTimeType.kYMD,

                  value: startDateTime,
                  title: "选择时间", onConfirm: (Picker picker, List value) {
                setState(() {
                  startDateTime =
                      (picker.adapter as DateTimePickerAdapter).value;
                });
              });
            }),

        multiTextField(
            "费用金额", moneyCon, isImportant: true,
            isReadOnly: false,
            hint: "请输入费用金额", textInputType: TextInputType.number),
        remarkContainer(controller: reasonCon, hint: "费用说明事由"),
        SizedBox(height: 2,),
        remarkContainer(controller: remarksCon, hint: "备注"),

      ],
    );
  }


  //用章
  Widget yongzhangWidget() {
    return Column(
      children: <Widget>[
        downArrowContainer(isImportant: true,
            name: "印章类型", content: yongZhangTypeStr ?? "", function: () {
              PickHelper.openSimpleDataPicker(
                  context, list: yongZhangTypeStrs,
                  value: yongZhangTypeStr,

                  onConfirm: (picker, List value) {

                    setState(() {
                      yongZhangTypeStr = picker.getSelectedValues()[0];
                      yongzhangType = yongZhangTypeInts[value[0]];
                    });
                  });
            }),

        downArrowContainer(isImportant: true,
            name: "用印时间",
            content: startDateTime==null?"":DateFormat('yyyy-MM-dd').format(startDateTime),
            function: () {
              PickHelper.openDateTimePicker(
                  context,
                  type: PickerDateTimeType.kYMD,

                  value: startDateTime,
                  title: "选择时间", onConfirm: (Picker picker, List value) {
                setState(() {
                  startDateTime =
                      (picker.adapter as DateTimePickerAdapter).value;
                });
              });
            }),

        multiTextField(
          "文件名称", nameCon, isImportant: true, isReadOnly: false,
          hint: "请输入文件名称",),
        multiTextField(
            "文件份数", amountCon, isImportant: true, isReadOnly: false,
            hint: "请输入文件份数", textInputType: TextInputType.number),
        remarkContainer(controller: reasonCon, hint: "用印事由"),

      ],
    );
  }

  //立项
  Widget lixiangWidget() {
    return Column(
      children: <Widget>[

        multiTextField(
          "项目名称", nameCon, isImportant: true, isReadOnly: false,
          hint: "请输入项目名称",),
        multiTextField(
          "项目名称", outlineCon, isImportant: true, isReadOnly: false,
          hint: "请输入项目概述",),
        multiTextField(
          "发起人", createByCon, isImportant: true, isReadOnly: true,
          hint: "请输入项目名称",),
        downArrowContainer(isImportant: true,
            name: "时间",
            content: startDateTime==null?"":DateFormat('yyyy-MM-dd').format(startDateTime),
            function: () {
              PickHelper.openDateTimePicker(
                  context,
                  type: PickerDateTimeType.kYMD,

                  value: startDateTime,
                  title: "选择时间", onConfirm: (Picker picker, List value) {
                setState(() {
                  startDateTime =
                      (picker.adapter as DateTimePickerAdapter).value;
                });
              });
            }),

        multiTextField(
            "项目金额", moneyCon, isImportant: true, isReadOnly: false,
            hint: "请输入项目金额", textInputType: TextInputType.number),
        remarkContainer(controller: remarksCon, hint: "备注"),

      ],
    );
  }

  //转正
  Widget zhuanzhengWidget() {
    return Column(children: <Widget>[

      downArrowContainer(isImportant: true,
          name: "开始时间",
          content: startDateTime==null?"":DateFormat('yyyy-MM-dd').format(startDateTime),
          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kYMD,
                value: startDateTime,

                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                startDateTime = (picker.adapter as DateTimePickerAdapter).value;
                startDateTime = getTime(startDateTime);
                durationCon.text = getDuration().toString() + "天";
              });
            });
          }),

      remarkContainer(controller: remarksCon, hint: "自我评价"),

    ],);
  }

  //离职
  Widget lizhiWidget() {
    return Column(children: <Widget>[
      downArrowContainer(isImportant: true,
          name: "离职时间",
          content: startDateTime==null?"":DateFormat('yyyy-MM-dd').format(startDateTime),
          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kYMD,
                value: startDateTime,
                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                startDateTime = (picker.adapter as DateTimePickerAdapter).value;
                startDateTime = getTime(startDateTime);
                durationCon.text = getDuration().toString() + "天";
              });
            });
          }),

      downArrowContainer(isImportant: true,
          name: "聘用形式", content: hireFormStr ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: hireFormStrs,
                value: hireFormStr,
                onConfirm: (picker, List value) {
                  setState(() {
                    hireFormStr = picker.getSelectedValues()[0];
                    hireForm = hireFormStrs[value[0]];
                  });
                });
          }),

      downArrowContainer(isImportant: true,
          name: "转正状态", content: turnStatStr ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: turnStatStrs,
                value: turnStatStr,
                onConfirm: (picker, List value) {

                  setState(() {
                    turnStatStr = picker.getSelectedValues()[0];
                    turnStat = turnStatStrs[value[0]];
                  });
                });
          }),

      remarkContainer(controller: reasonCon, hint: "离职原因"),

    ],);
  }

//1001外出、1002采购、1003费用、1004用章、1005立项申请、1006转正、1007离职
  Widget getResultWidget() {
    if (applyType == applyTypeInts[0]) {
      return waichuWidget();
    } else if (applyType == applyTypeInts[1]) {
      return caigouWidget();
    } else if (applyType == applyTypeInts[2]) {
      return feiyongWidget();
    } else if (applyType == applyTypeInts[3]) {
      return yongzhangWidget();
    } else if (applyType == applyTypeInts[4]) {
      return lixiangWidget();
    } else if (applyType == applyTypeInts[5]) {
      return zhuanzhengWidget();
    } else if (applyType == applyTypeInts[6]) {
      return lizhiWidget();
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


