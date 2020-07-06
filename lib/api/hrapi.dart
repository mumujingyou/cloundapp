import 'dart:io';

import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/model/hr/ApplyDetailModel.dart';
import 'package:cloundapp/model/hr/ApplyModel.dart';
import 'package:cloundapp/model/hr/AttendanceInfo.dart';
import 'package:cloundapp/model/hr/CheckNodeModel.dart';
import 'package:cloundapp/model/hr/MonthModel.dart';
import 'package:cloundapp/model/hr/TalentDetailModel.dart';
import 'package:cloundapp/model/hr/employModel.dart';
import 'package:cloundapp/model/hr/talentModel.dart';
import 'package:cloundapp/model/hr/wagesModel.dart';
import 'package:dio/dio.dart';

class HRAPI {


  //考勤次数
  static const String getAttendanceLogMonthStatisticsUrl = address +
      "api-h/attendanceLog/getAttendanceLogMonthStatistics";
  static const String getAttendanceLogMonthLisUrl = address +
      "api-h/attendanceLog/getAttendanceLogMonthList";
  static const String getAttUploadLogDateListUrl = address +
      "api-h/attendanceLog/getAttUploadLogDateList";
  static const String getLastTreeDayLogUrl = address +
      "api-h/attendanceLog/getLastTreeDayLog";
  static const String addAttLogByAppUrl = address + "api-h/attendanceLog/addAttLogByApp";


  static const String applyListItemUrl = address + "api-h/apply/listItem";
  static const String addApplyUrl = address + "api-h/apply/save";
  static const String applyDetailUrl = address + "api-h/apply/detail";
  static const String allProcessNodeInfoUrl = address +
      "api-h/busProcess/allProcessNodeInfo";
  static const String approvsalBusProcessUrl = address +
      "api-h/busProcess/approvsal";
  static const String wagesSendListUrl = address +
      "api-h/wagesSendReport/selectDetailList";
  static const String getMonthUrl = address + "api-h/wagesSendReport/getMonth";

  //招聘
  static const String employListUrl = address + "api-h/employ/select";
  static const String myTalentUrl = address + "api-h/talent/myTalent";
  static const String talentDetailUrl = address + "api-h/talent/info";
  static const String interviewTalentUrl = address + "api-h/talent/interview";


  static Future<AttendanceInfo> getAttendanceLogMonthStatistics(
      {String month}) async {
    var formData = {
      'month': month,
    };
    Response response = await API.requestResponseByCode(
        url: getAttendanceLogMonthStatisticsUrl, formData: formData);
    return AttendanceInfo.fromJson(response.data["data"]);
  }

  static Future<Map<String, dynamic>> getAttendanceLogMonthLis(
      {String month}) async {
    var formData = {
      'month': month,
    };
    Response response = await API.requestResponse(
        url: getAttendanceLogMonthLisUrl, formData: formData);
    print(response.data.toString());
    if (response.data["code"] == 500) {
      return {"msg": response.data["msg"], "data": false};
    } else {
      return {"msg": AttendanceModelList.fromJson(response.data), "data": true};
    }
  }


  static Future<Map<String, dynamic>> getAttUploadLogDateList(
      {String month}) async {
    var formData = {
      'month': month,
    };
    Response response = await API.requestResponse(
        url: getAttUploadLogDateListUrl, formData: formData);
    if (response.data["code"] == 500) {
      return {"msg": response.data["msg"], "data": false};
    } else {
      return {"msg": AttendanceModelList.fromJson(response.data), "data": true};
    }
  }


  //我的申请列表
  static Future<ApplyModelList> applyList({int start = 0,
    int length = 10, var type = 1, var status}) async {
    var formData = {
      'start': start,
      "length": length,
      "type": type,
      "status": status,
    };
    Response response = await API.requestResponse(
        url: applyListItemUrl, formData: formData);
    return ApplyModelList.fromJson(response.data);
  }


  //我的申请列表
  static Future<ApplyModelList> applyList2({int start = 0,
    int length = 10, var type = 1, var status}) async {
    var formData = {
      'start': start,
      "length": length,
      "type": type,
      "approvalStatus": status,
    };
    Response response = await API.requestResponse(
        url: applyListItemUrl, formData: formData);
    return ApplyModelList.fromJson(response.data);
  }

  static Future<Map<String, dynamic>> addApply(
      {String applyType, String vacateType, String reason, String startTime,
        String endTime, String duration, String applyNo, String reimbType, String costType,
        String payTime, String costAmount, String costRemark, String site}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'vacateType': vacateType, //请假类型
      'reason': reason,
      'endTime': endTime,
      'startTime': startTime,
      "duration": duration,
      "applyNo": applyNo,
      "reimbType": reimbType, //报销类型
      "costType": costType, //费用类型
      "payTime": payTime,
      "costAmount": costAmount,
      "costRemark": costRemark,
      "site": site,
    };
    return await API.requestBool(formData: formData, url: addApplyUrl);
  }


  //根据id查申请或者审批详情
  static Future<ApplyDetailModel> applyDetail({String applyId}) async {
    var formData = {
      'applyId': "$applyId",
    };
    Response response = await API.requestResponseByCode(
        url: applyDetailUrl, formData: formData);
    return ApplyDetailModel.fromJson(response.data["data"]);
  }

  //根据id查询审批节点
  static Future<CheckNodeModelList> allProcessNodeInfo({String busId}) async {
    var formData = {
      'busId': "$busId",
    };
    Response response = await API.requestResponseByCode(
        url: allProcessNodeInfoUrl, formData: formData);
    return CheckNodeModelList.fromJson(response.data);
  }

  //根据id赞成或者驳回审批
  static Future<Map<String, dynamic>> approvsalBusProcess(
      {String busId, String status}) async {
    var formData = {
      'busId': "$busId",
      'status': "$status",
    };
    return await API.requestBool(
        formData: formData, url: approvsalBusProcessUrl);
  }

  //工资列表
  static Future<WagesModelList> wagesSendList({String month}) async {
    var formData = {
      'month': "$month",
    };
    Response response = await API.requestResponseByCode(
        url: wagesSendListUrl, formData: formData);
    return WagesModelList.fromJson(response.data);
  }

  //工资条月份
  static Future<MonthList> getMonth() async {
    Response response = await API.requestResponseByCode(url: getMonthUrl,);
    return MonthList.fromJson(response.data);
  }


  //招聘信息
  static Future<EmployModelList> employList({int start = 0,
    int length = 10, var status,}) async {
    var formData = {
      'start': start,
      "length": length,
      "status": status,
    };
    Response response = await API.requestResponse(
        url: employListUrl, formData: formData);
    dynamic map = response.data;
    return EmployModelList.fromJson(map);
  }

  //面试信息
  static Future<TalentModelList> getMyTalentList({int start = 0,
    int length = 10, var appsta = 0,}) async {
    var formData = {
      'start': start,
      "length": length,
      "appsta": appsta,
    };
    Response response = await API.requestResponse(
        url: myTalentUrl, formData: formData);
    dynamic map = response.data;
    return TalentModelList.fromJson(map);
  }


  //面试详情
  static Future<TalentDetailModel> getTalentDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response = await API.requestResponseByCode(
        url: talentDetailUrl, formData: formData);
    return TalentDetailModel.fromJson(response.data["data"]);
  }

  //面试
  static Future<Map<String, dynamic>> interviewTalent(
      {String grade, String id, String remarks, String status}) async {
    var formData = {
      "grade": grade,
      'id': "$id",
      "remarks": remarks,
      "status": status,
    };
    return await API.requestBool(
        formData: formData, url: interviewTalentUrl, contentType:
    API.json);
  }

  static Future<List<AttendanceLogModel>> getLastTreeDayLog() async {
    Response response = await API.requestResponseByCode(
      url: getLastTreeDayLogUrl,);
    List<dynamic> dynamicList = response.data["data"];
    List<AttendanceLogModel> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      list.add(AttendanceLogModel.fromJson(dynamicList[i]));
    }
    return list;
  }



  //打卡
  static Future<Map<String, dynamic>> addAttLogByApp(
      {String longitude, String latitude,String macAddress,String wifiName}) async {
    var formData = {
      'longitude': "$longitude",
      'latitude': "$latitude",
      'wifiName': "$wifiName",
      'macAddress': "$macAddress",
    };
    return await API.requestBool(
        formData: formData, url: addAttLogByAppUrl);
  }

}