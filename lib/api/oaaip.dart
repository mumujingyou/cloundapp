import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/contactModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/model/hr/CheckNodeModel.dart';
import 'package:cloundapp/model/oa/captialModel.dart';
import 'package:cloundapp/model/oa/infoModel.dart';
import 'package:cloundapp/model/oa/noticeModel.dart';
import 'package:cloundapp/model/oa/planModel.dart';
import 'package:cloundapp/model/oa/supplyModel.dart';
import 'package:cloundapp/model/oa/taskModel.dart';
import 'package:cloundapp/model/oa/workModel.dart';
import 'package:dio/dio.dart';

class OAAPI {


  static const String getNumberUrl = address + "api-oa/getNumber";

  //目标
  static const String workPlanSelcetUrl = address + "api-oa/workPlan/select";
  static const String removeWorkPlanUrl = address + "api-oa/workPlan/remove";
  static const String saveWorkPlanUrl = address + "api-oa/workPlan/save";
  static const String workPlanInfoUrl = address + "api-oa/workPlan/info";


  //任务
  static const String workTaskListUrl = address + "api-oa/workTask/select";
  static const String removeTaskUrl = address + "api-oa/workTask/remove";
  static const String saveTaskUrl = address + "api-oa/workTask/save";
  static const String workTaskDetailUrl = address + "api-oa/workTask/info";

  //报告
  static const String workInfoListUrl = address + "api-oa/workInfo/select";
  static const String saveWorkInfoUrl = address + "api-oa/workInfo/save";
  static const String workInfoDetailUrl = address + "api-oa/workInfo/info";
  static const String removeWorkInfoUrl = address + "api-oa/workInfo/remove";


  //公告信息
  static const String selectNoticePageListUrl = address +
      "api-oa/notice/selectNoticePageList";
  static const String noticeDetailUrl = address +
      "api-oa/notice/selectSingleById";


  static const String suppliesListUrl = address +
      "api-oa/supplies/apply/select";
  static const String suppliesApplyDetailUrl = address +
      "api-oa/supplies/apply/info";
  static const String addSupplyUrl = address + "api-oa/supplies/apply/add";
  static const String selectAdminSuppliesPageListUrl = address +
      "api-oa/adminSupplies/selectAdminSuppliesPageList";

  static const String capitalListUrl = address + "api-oa/capital/apply/select";
  static const String capitalApplyDetailUrl = address +
      "api-oa/capital/apply/info";
  static const String addCapitalUrl = address + "api-oa/capital/apply/add";
  static const String selectAdminCapitalPageListUrl = address +
      "api-oa/adminCapital/selectAdminCapitalPageList";


  static const String workListUrl = address + "api-oa/apply/listItem";
  static const String workDetailUrl = address + "api-oa/apply/detail";

  static const String saveOutUrl = address + "api-oa/apply/saveOut";
  static const String savePurchaseUrl = address + "api-oa/apply/savePurchase";
  static const String saveCostUrl = address + "api-oa/apply/saveCost";
  static const String saveChapterUrl = address + "api-oa/apply/saveChapter";
  static const String saveProjectUrl = address + "api-oa/apply/saveProject";
  static const String savePositiveUrl = address + "api-oa/apply/savePositive";
  static const String saveDimissionUrl = address + "api-oa/apply/saveDimission";

  static const String allProcessNodeInfoUrl= address + "api-oa/busProcess/allProcessNodeInfo";
  static const String approvsalBusProcessUrl = address + "api-oa/busProcess/approvsal";


  static const String externalContactsListUrl = address + "api-oa/externalContacts/listPage";
  static const String contactsTypeListUrl = address + "api-oa/contactsType/list";




  //我的工作计划列表
  static Future<PlanModelList> selectWorkPlan({int start = 0,
    int length = 10, String title}) async {
    var formData = {
      'start': start,
      "length": length,
      "title": title,
    };
    Response response = await API.requestResponse(
        url: workPlanSelcetUrl, formData: formData);
    dynamic map = response.data;
    return PlanModelList.fromJson(map);
  }

  //根据id删除计划
  static Future<Map<String, dynamic>> removeWorkPlan({String id}) async {
    var formData = {
      'id': "$id",
    };
    return await API.requestBool(formData: formData, url: removeWorkPlanUrl);
  }

  //新增编辑工作计划
  static Future<Map<String, dynamic>> saveWorkPlan(
      {String busNo, String beginDate,
        String endDate, String title, String wpType, String content, var status = 1, String id,
        String executeId, String executeBy, String approvalId, String approvalBy}) async {
    var formData = {
      "beginDate": beginDate,
      'endDate': endDate,
      "title": title,
      "wpType": wpType,
      "content": content,
      "status": status,
      "busNo": busNo,
      "executeId": executeId,
      "executeBy": executeBy,
      "approvalId": approvalId,
      "approvalBy": approvalBy,
      "priority": 1,
      "createName": Data.user.name,
      "id": id,

    };
    print(Data.user.name);
    return await API.requestBool(
        formData: formData, url: saveWorkPlanUrl, contentType:
    API.json);
  }


  //获取业务编号
  //1、公告信息 2、文档 3、行政资产 4、电子消息 5、行政用品6执行计划7审批申请
  //8.工作任务编号9工作任务执行结果编号10工作报告 11行政资产申请 12 行政用品申请

  static Future<String> getNumber({String type}) async {
    var formData = {
      'type': "$type",
    };
    return await API.requestString(formData: formData, url: getNumberUrl);
  }


  //计划详情
  static Future<WorkPlanDetail> workPlan({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response = await API.requestResponseByCode(
        url: workPlanInfoUrl, formData: formData);
    return WorkPlanDetail.fromJson(response.data["data"]);
  }


  //我的工作任务列表
  static Future<WorkTaskListModel> workTaskList({int start = 0,
    int length = 10, String title}) async {
    var formData = {
      'start': start,
      "length": length,
      "title": title,
    };
    Response response = await API.requestResponse(
        url: workTaskListUrl, formData: formData);
    dynamic map = response.data;
    return WorkTaskListModel.fromJson(map);
  }

  //根据id删除任务
  static Future<Map<String, dynamic>> removeTask({String id}) async {
    var formData = {
      'id': "$id",
    };
    return await API.requestBool(formData: formData, url: removeTaskUrl);
  }

  //新增编辑工作任务
  static Future<Map<String, dynamic>> saveWorkTask(
      {String busNo, String beginDate,
        String endDate, String title, String wpType, String mission, var status = 1, String id,
        String executeId, String executeBy, String abWork, String acWork, String missionNo,
        String resultsNo}) async {
    var formData = {
      "beginDate": beginDate,
      'endDate': endDate,
      "title": title,
      "wpType": wpType,
      "mission": mission,
      "status": status,
      "executeId": executeId,
      "executeBy": executeBy,
      "priority": 1,
      "createName": Data.user.name,
      "abWork": abWork,
      "acWork": acWork,
      "missionNo": missionNo,
      "resultsNo": resultsNo,

      "id": id,

    };
    return await API.requestBool(
        formData: formData, url: saveTaskUrl, contentType:
    API.json);
  }

  //计划详情
  static Future<WorkTaskDetail> workTaskDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response = await API.requestResponseByCode(
        url: workTaskDetailUrl, formData: formData);
    return WorkTaskDetail.fromJson(response.data["data"]);
  }

  //我的工作报告列表
  static Future<WorkInfoListModel> workInfoList({int start = 0,
    int length = 10, String title}) async {
    var formData = {
      'start': start,
      "length": length,
      "title": title,
    };
    Response response = await API.requestResponse(
        url: workInfoListUrl, formData: formData);
    dynamic map = response.data;
    return WorkInfoListModel.fromJson(map);
  }

  //新增编辑工作报告
  static Future<Map<String, dynamic>> saveWorkInfo(
      {String busNo, String createTime,
        String title, String wpType, String content, var status = 1, String id,
        String approvalId, String approvalBy}) async {
    var formData = {
      "createTime": createTime,
      "title": title,
      "wpType": wpType,
      "content": content,
      "status": status,
      "busNo": busNo,
      "approvalId": approvalId,
      "approvalBy": approvalBy,
      "priority": 1,
      "createName": Data.user.name,
      "id": id,

    };
    return await API.requestBool(
        formData: formData, url: saveWorkInfoUrl, contentType: API.json);
  }

  //报告详情
  static Future<WorkInfoDetail> workInfoDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response = await API.requestResponseByCode(
        url: workInfoDetailUrl, formData: formData);
    return WorkInfoDetail.fromJson(response.data["data"]);
  }

  //根据id删除报告
  static Future<Map<String, dynamic>> removeWorkInfo({String id}) async {
    var formData = {
      'id': "$id",
    };
    return await API.requestBool(formData: formData, url: removeWorkInfoUrl);
  }

  //我的公告信息列表
  static Future<NoticeListModel> selectNoticePageList({int start = 0,
    int length = 10, String title, String noticeType}) async {
    var formData = {
      'start': start,
      "length": length,
      "title": title,
      "noticeType": noticeType,
    };
    Response response = await API.requestResponse(
        url: selectNoticePageListUrl, formData: formData);
    dynamic map = response.data;
    return NoticeListModel.fromJson(map);
  }

  //信息公告详情
  static Future<NoticeModel> noticeDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response = await API.requestResponseByCode(
        url: noticeDetailUrl, formData: formData);
    return NoticeModel.fromJson(response.data["data"]);
  }


  //用品领用列表
  static Future<SupplyListModel> suppliesList({int start = 0,
    int length = 10, String beginDate}) async {
    var formData = {
      'start': start,
      "length": length,
      "beginDate": beginDate,
    };
    Response response = await API.requestResponse(
        url: suppliesListUrl, formData: formData);
    dynamic map = response.data["page"];
    return SupplyListModel.fromJson(map);
  }

  //用品领用详情
  static Future<SupplyApplyDetail> suppliesApplyDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response = await API.requestResponseByCode(
        url: suppliesApplyDetailUrl, formData: formData);
    return SupplyApplyDetail.fromJson(response.data["data"]);
  }


  //新增用品领用
  static Future<Map<String, dynamic>> addSupply(
      {SuppliesApply suppliesApply, List<
          SuppliesApplyItem> suppliesApplyItems}) async {
    var formData = {
      "suppliesApply": suppliesApply,
      "suppliesApplyItems": suppliesApplyItems,
    };
    return await API.requestBool(
        formData: formData, url: addSupplyUrl, contentType: API.json);
  }


  //所用用品
  static Future<List<SupplyProduct>> selectAdminSuppliesPageList(
      {int start = 0, int length = 100,}) async {
    var formData = {
      'start': "$start",
      'length': "$length",
    };
    Response response = await API.requestResponse(
        url: selectAdminSuppliesPageListUrl, formData: formData);
    List<SupplyProduct> list = [];
    List<dynamic> dynamicList = response.data["data"];
    for (int i = 0; i < dynamicList.length; i++) {
      SupplyProduct supplyProduct = SupplyProduct.fromJson(dynamicList[i]);
      if (supplyProduct.quantity > 0) {
        list.add(supplyProduct);
      }
    }
    return list;
  }

  //资产领用列表
  static Future<CapitalListModel> capitalList({int start = 0,
    int length = 10, String beginDate}) async {
    var formData = {
      'start': start,
      "length": length,
      "beginDate": beginDate,
    };
    Response response = await API.requestResponse(
        url: capitalListUrl, formData: formData);
    dynamic map = response.data["page"];
    return CapitalListModel.fromJson(map);
  }

  //资产领用详情
  static Future<CapitalApplyDetail> capitalApplyDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response = await API.requestResponseByCode(
        url: capitalApplyDetailUrl, formData: formData);
    return CapitalApplyDetail.fromJson(response.data["data"]);
  }


  //新增用品领用
  static Future<Map<String, dynamic>> addCapital(
      {CapitalApply capitalApply, List<
          CapitalApplyItem> capitalApplyItems}) async {
    var formData = {
      "capitalApply": capitalApply,
      "capitalApplyItems": capitalApplyItems,
    };
    return await API.requestBool(
        formData: formData, url: addCapitalUrl, contentType: API.json);
  }

  //所用资产
  static Future<List<CapitalProduct>> selectAdminCapitalPageList(
      {int start = 0, int length = 100,}) async {
    var formData = {
      'start': "$start",
      'length': "$length",
    };
    Response response = await API.requestResponse(
        url: selectAdminCapitalPageListUrl, formData: formData);
    List<CapitalProduct> list = [];
    List<dynamic> dynamicList = response.data["data"];
    for (int i = 0; i < dynamicList.length; i++) {
      CapitalProduct capitalProduct = CapitalProduct.fromJson(dynamicList[i]);
      list.add(capitalProduct);
    }
    return list;
  }


  //我的工作任务列表
  static Future<WorkListModel> workList({int start = 0,
    int length = 10, String applyType, String type = "1", String status}) async {
    var formData = {
      'start': start,
      "length": length,
      "applyType": applyType,
      "type": type,
      "status": status,

    };
    Response response = await API.requestResponse(
        url: workListUrl, formData: formData);
    dynamic map = response.data["page"];
    return WorkListModel.fromJson(map);
  }

  static Future<Map<String, dynamic>> saveOut(
      {String applyType, String reason, String startTime,
        String endTime, String duration, String applyNo,
        String site}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'reason': reason,
      'endTime': endTime,
      'startTime': startTime,
      "duration": duration,
      "applyNo": applyNo,
      "site": site,
    };
    return await API.requestBool(formData: formData, url: saveOutUrl);
  }

  static Future<Map<String, dynamic>> savePurchase(
      {String applyType, String reason, String amount,
        String money, String remarks, String applyNo,
        String delivery, String goodsName, String spec}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'delivery': delivery, //
      'reason': reason,
      'goodsName': goodsName, //
      'spec': spec, //
      'amount': amount, //
      'money': money, //
      "remarks": remarks,
      "applyNo": applyNo,
    };
    return await API.requestBool(formData: formData, url: savePurchaseUrl);
  }


  static Future<Map<String, dynamic>> saveCost(
      {String applyType, String reason, String payTime,
        String money, String remarks, String applyNo,
        String costType}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'costType': costType, //
      'reason': reason,
      'money': money, //
      "remarks": remarks,
      "applyNo": applyNo,
      "payTime": payTime,
    };
    return await API.requestBool(formData: formData, url: saveCostUrl);
  }

  static Future<Map<String, dynamic>> saveChapter(
      {String applyType, String reason, String useTime,
        String fileName, String amount, String applyNo,
        String type}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'type': type, //
      'reason': reason,
      'fileName': fileName, //
      "amount": amount,
      "applyNo": applyNo,
      "useTime": useTime,
    };
    return await API.requestBool(formData: formData, url: saveChapterUrl);
  }


  static Future<Map<String, dynamic>> saveProject(
      {String applyType, String remarks, String projectTime,
        String outline, String money, String applyNo,
        String projectName}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'projectName': projectName, //
      'outline': outline, //
      "money": money,
      "applyNo": applyNo,
      "remarks": remarks,
      "initiator": Data.user.name,
      "projectTime": projectTime,

    };
    return await API.requestBool(formData: formData, url: saveProjectUrl);
  }


  static Future<Map<String, dynamic>> savePositive(
      {String applyType, String positiveTime, String selfReview,String applyNo}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'selfReview': selfReview, //
      'positiveTime': positiveTime, //
      "applyNo": applyNo,

    };
    return await API.requestBool(formData: formData, url: savePositiveUrl);
  }

  static Future<Map<String, dynamic>> saveDimission(
      {String applyType, String hireForm, String turnStat,String applyNo,
      String reason,String leaveTime}) async {
    Map<String, dynamic> formData = {
      'applyType': applyType, //申请类型
      'hireForm': hireForm, //
      'turnStat': turnStat, //
      "applyNo": applyNo,
      "reason": reason,
      "leaveTime": leaveTime,
    };
    return await API.requestBool(formData: formData, url: saveDimissionUrl);
  }


  //事务详情
  static Future<WorkDetailModel> workDetail({String id,String type}) async {
    var formData = {
      'applyId': "$id",
      'type': "$type",
    };
    Response response = await API.requestResponseByCode(
        url: workDetailUrl, formData: formData);
    return WorkDetailModel.fromJson(response.data["data"]);
  }


  //根据id查询审批节点
  static Future<CheckNodeModelList> allProcessNodeInfo({String busId}) async {
    var formData = {
      'busId': "$busId",
    };
    Response response= await API.requestResponseByCode(url: allProcessNodeInfoUrl,formData: formData);
    return CheckNodeModelList.fromJson(response.data);
  }


  //根据id赞成或者驳回审批
  static Future<Map<String, dynamic>> approvsalBusProcess({String busId,String status,String opinion}) async {
    var formData = {
      'busId': "$busId",
      'status': "$status",
      'opinion': "$opinion",
    };
    return await API.requestBool(formData: formData,url:approvsalBusProcessUrl );
  }




  //外部通讯录
  static Future<ContactListModel> externalContactsList({var start,var length,String typeId,var name}) async {
    var formData = {
      'start': "$start",
      'length': "$length",
      'typeId': "$typeId",
      'name': name,

    };
    Response response = await API.requestResponseByCode(
        url: externalContactsListUrl, formData: formData);
    return ContactListModel.fromJson(response.data["page"]);
  }

  //外部通讯录分类
  static Future<List<ContactTypeModel>> contactsTypeList({int start=0,int length=100,}) async {
    var formData = {
      'start': "$start",
      'length': "$length",
    };
    Response response= await API.requestResponseByCode(url: contactsTypeListUrl,formData: formData);
    List<dynamic> dynamicList = response.data["data"];
    List<ContactTypeModel> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      list.add(ContactTypeModel.fromJson(dynamicList[i]));
    }
    return list;
  }
}