import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/model/oa/workModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:flutter/material.dart';

var siteCon = new TextEditingController(); //地点
var durationCon = new TextEditingController(); //时长
var amountCon = new TextEditingController(); //个数
var reasonCon = new TextEditingController(); //原因
var remarksCon = new TextEditingController(); //说明
var applyTypeCon = new TextEditingController(); //申请类型
var moneyCon = new TextEditingController(); //金额
var deliveryCon = new TextEditingController(); //期望支付时间
var startDateTimeCon = new TextEditingController(); //开始时间
var endDateTimeCon = new TextEditingController(); //结束时间
var goodsNameCon = new TextEditingController();
var costTypeCon = new TextEditingController();
var fileNameCon = new TextEditingController();
var useTimeCon = new TextEditingController();
var projectNameCon = new TextEditingController();
var outlineCon = new TextEditingController();
var positiveTimeCon = new TextEditingController();
var selfReviewCon = new TextEditingController();
var hireFormCon = new TextEditingController();
var turnStatCon = new TextEditingController();
var specCon = new TextEditingController();
var typeCon = new TextEditingController();
var userNameCon = new TextEditingController();
var projectTimeCon = new TextEditingController();
var leaveTimeCon = new TextEditingController();
var payTimeCon = new TextEditingController();


//请假
Widget waiChuWidget() {
  return Column(children: <Widget>[
    multiTextField("申请类型", applyTypeCon, isImportant: false, isReadOnly: true),

    multiTextField("外出地点", siteCon, isImportant: false, isReadOnly: true),
    multiTextField(
        "开始时间", startDateTimeCon, isImportant: false, isReadOnly: true),
    multiTextField("结束时间", endDateTimeCon, isImportant: false, isReadOnly: true),
    multiTextField("外出时长", durationCon, isImportant: false, isReadOnly: true),
    multiTextField("外出是由", reasonCon, isImportant: false, isReadOnly: true),
  ],);
}

//费用
Widget feiyongWidget() {
  return Column(
    children: <Widget>[
      multiTextField("申请类型", applyTypeCon, isImportant: false, isReadOnly: true),

      multiTextField("费用类型", costTypeCon, isImportant: false, isReadOnly: true),
      multiTextField("时间", payTimeCon, isImportant: false, isReadOnly: true),
      multiTextField("费用金额", moneyCon, isImportant: false, isReadOnly: true,),
      multiTextField("费用是由", reasonCon, isImportant: false, isReadOnly: true,),
      multiTextField("费用说明", remarksCon, isImportant: false, isReadOnly: true,),
    ],
  );
}

//采购
Widget caigouWidget() {

  return Column(children: <Widget>[
    multiTextField("申请类型", applyTypeCon, isImportant: false, isReadOnly: true),

    multiTextField("物品名称", goodsNameCon, isImportant: false, isReadOnly: true),
    multiTextField("期望交付时间", deliveryCon, isImportant: false, isReadOnly: true),
    multiTextField("型号或规格", specCon, isImportant: false, isReadOnly: true),
    multiTextField("数量", amountCon, isImportant: false, isReadOnly: true),
    multiTextField("金额", moneyCon, isImportant: false, isReadOnly: true),
    multiTextField("采购是由", reasonCon, isImportant: false, isReadOnly: true),
    multiTextField("采购备注", remarksCon, isImportant: false, isReadOnly: true),

  ],);
}

//用章
Widget yongzhangWidget() {
  return Column(children: <Widget>[
    multiTextField("申请类型", applyTypeCon, isImportant: false, isReadOnly: true),

    multiTextField("印章类型", typeCon, isImportant: false, isReadOnly: true),
    multiTextField("用印时间", useTimeCon, isImportant: false, isReadOnly: true),
    multiTextField("文件名称", fileNameCon, isImportant: false, isReadOnly: true),
    multiTextField("文件份数", amountCon, isImportant: false, isReadOnly: true),
    multiTextField("用印是由", reasonCon, isImportant: false, isReadOnly: true),
  ],);
}

//立项
Widget lixiangWidget() {
  return Column(children: <Widget>[
    multiTextField("申请类型", applyTypeCon, isImportant: false, isReadOnly: true),

    multiTextField("项目名称", projectNameCon, isImportant: false, isReadOnly: true),
    multiTextField("项目概述", outlineCon, isImportant: false, isReadOnly: true),
    multiTextField("发起人", userNameCon, isImportant: false, isReadOnly: true),
    multiTextField("时间", projectTimeCon, isImportant: false, isReadOnly: true),
    multiTextField("项目金额", moneyCon, isImportant: false, isReadOnly: true),
    multiTextField("备注", remarksCon, isImportant: false, isReadOnly: true),
  ],);
}

//转正
Widget zhuanzhengWidget() {
  return Column(children: <Widget>[
    multiTextField("申请类型", applyTypeCon, isImportant: false, isReadOnly: true),

    multiTextField(
        "转正时间", positiveTimeCon, isImportant: false, isReadOnly: true),
    multiTextField("自我评价", selfReviewCon, isImportant: false, isReadOnly: true),
  ],);
}

//离职
Widget lizhiWidget() {
  return Column(children: <Widget>[
    multiTextField("申请类型", applyTypeCon, isImportant: false, isReadOnly: true),

    multiTextField("离职时间", leaveTimeCon, isImportant: false, isReadOnly: true),
    multiTextField("聘用形式", hireFormCon, isImportant: false, isReadOnly: true),
    multiTextField("转正状态", turnStatCon, isImportant: false, isReadOnly: true),
    multiTextField("离职原因", reasonCon, isImportant: false, isReadOnly: true),

  ],);
}

String applyType;

Widget getResultWidget() {
  if (applyType == applyTypeStrs[0]) {
    return waiChuWidget();
  } else if (applyType == applyTypeStrs[1]) {
    return caigouWidget();
  } else if (applyType == applyTypeStrs[2]) {
    return feiyongWidget();
  } else if (applyType == applyTypeStrs[3]) {
    return yongzhangWidget();
  } else if (applyType == applyTypeStrs[4]) {
    return lixiangWidget();
  } else if (applyType == applyTypeStrs[5]) {
    return zhuanzhengWidget();
  } else if (applyType == applyTypeStrs[6]) {
    return lizhiWidget();
  }
  return Center(child: CircularProgressIndicator(),);
}

Future<WorkDetailModel> getDetail({State state,String id,String type,}) async {
  WorkDetailModel workDetailModel = await OAAPI.workDetail(
      id: id, type:type);
  state.setState(() {
    applyType = workDetailModel.applyType;
    siteCon.text = workDetailModel.site;
    durationCon.text = workDetailModel.duration.toString() + "天";
    amountCon.text = workDetailModel.amount.toString();
    reasonCon.text = workDetailModel.reason;
    applyTypeCon.text = workDetailModel.applyType;
    costTypeCon.text =workDetailModel.costType;
    startDateTimeCon.text =workDetailModel.startTime;
    remarksCon.text = workDetailModel.remarks;
    endDateTimeCon.text =workDetailModel.endTime;
    moneyCon.text = workDetailModel.money.toString();
    deliveryCon.text = workDetailModel.delivery;
    goodsNameCon.text = workDetailModel.goodsName;
    fileNameCon.text = workDetailModel.fileName;
    useTimeCon.text = workDetailModel.useTime;
    projectNameCon.text = workDetailModel.projectName;
    outlineCon.text = workDetailModel.outline;
    positiveTimeCon.text = workDetailModel.positiveTime;
    selfReviewCon.text = workDetailModel.selfReview;
    hireFormCon.text = workDetailModel.hireForm;
    turnStatCon.text = workDetailModel.turnStat;
    specCon.text = workDetailModel.spec;
    typeCon.text = workDetailModel.type;
    userNameCon.text = workDetailModel.userName;
    projectTimeCon.text = workDetailModel.projectTime;
    leaveTimeCon.text = workDetailModel.leaveTime;
    payTimeCon.text = workDetailModel.payTime;
  });

  return workDetailModel;
}