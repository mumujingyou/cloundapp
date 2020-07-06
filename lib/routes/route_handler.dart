import 'package:cloundapp/model/hr/wagesModel.dart';
import 'package:cloundapp/pages/other/SplashPage.dart';
import 'package:cloundapp/pages/maillist/contactUserManager.dart';
import 'package:cloundapp/pages/maillist/departmentUserManager.dart';
import 'package:cloundapp/pages/main_page.dart';
import 'package:cloundapp/pages/me/aboutUs.dart';
import 'package:cloundapp/pages/me/changePassword.dart';
import 'package:cloundapp/pages/other/login_page.dart';
import 'package:cloundapp/pages/workstaion/crm/agreenment/addAgreement.dart';
import 'package:cloundapp/pages/workstaion/crm/agreenment/agreementDetail.dart';
import 'package:cloundapp/pages/workstaion/crm/agreenment/agreementDetailUnEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/agreenment/agreementEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/agreenment/agreementManager.dart';
import 'package:cloundapp/pages/workstaion/crm/business/addBusiness.dart';
import 'package:cloundapp/pages/workstaion/crm/business/businessDetail.dart';
import 'package:cloundapp/pages/workstaion/crm/business/businessDetailUnEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/business/businessEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/business/businessManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/DepartmentManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addFollow.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addProduct.dart';
import 'package:cloundapp/pages/workstaion/crm/common/editProduct.dart';
import 'package:cloundapp/pages/workstaion/crm/common/followManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/productManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/selectUser.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/CustomerEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/addCustomer.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerAgreementManager.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerBusinessManager.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerDetail.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerDetailUnEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerManager.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerSeasManager.dart';
import 'package:cloundapp/pages/workstaion/crm/thread/addThread.dart';
import 'package:cloundapp/pages/workstaion/crm/thread/threadDeatil.dart';
import 'package:cloundapp/pages/workstaion/crm/thread/threadDeatilUnEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/thread/threadEdit.dart';
import 'package:cloundapp/pages/workstaion/crm/thread/threadManager.dart';
import 'package:cloundapp/pages/workstaion/crm/thread/transformToCumstomer.dart';
import 'package:cloundapp/pages/workstaion/hr/apply/ApplyManager.dart';
import 'package:cloundapp/pages/workstaion/hr/apply/addApply.dart';
import 'package:cloundapp/pages/workstaion/hr/apply/applyDetail.dart';
import 'package:cloundapp/pages/workstaion/hr/attendance/attendance.dart';
import 'package:cloundapp/pages/workstaion/hr/check/CheckManager.dart';
import 'package:cloundapp/pages/workstaion/hr/check/checkDetail.dart';
import 'package:cloundapp/pages/workstaion/hr/employ/talentDetail.dart';
import 'package:cloundapp/pages/workstaion/hr/employ/employFront.dart';
import 'package:cloundapp/pages/workstaion/hr/employ/employManager.dart';
import 'package:cloundapp/pages/workstaion/hr/employ/talentManager.dart';
import 'package:cloundapp/pages/workstaion/hr/wages/wagesDetail.dart';
import 'package:cloundapp/pages/workstaion/hr/wages/wagesManager.dart';
import 'package:cloundapp/pages/workstaion/oa/capital/capital/addCapital.dart';
import 'package:cloundapp/pages/workstaion/oa/capital/capital/capitalDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/capital/capital/capitalManager.dart';
import 'package:cloundapp/pages/workstaion/oa/capital/capitalFront.dart';
import 'package:cloundapp/pages/workstaion/oa/capital/supply/addSupply.dart';
import 'package:cloundapp/pages/workstaion/oa/capital/supply/supplyDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/capital/supply/supplyManager.dart';
import 'package:cloundapp/pages/workstaion/oa/notice/NoticeManager.dart';
import 'package:cloundapp/pages/workstaion/oa/notice/noticeDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/target/info/addInfo.dart';
import 'package:cloundapp/pages/workstaion/oa/target/info/infoDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/target/info/infoDetailUnEdit.dart';
import 'package:cloundapp/pages/workstaion/oa/target/info/infoEdit.dart';
import 'package:cloundapp/pages/workstaion/oa/target/info/infoManager.dart';
import 'package:cloundapp/pages/workstaion/oa/target/plan/addPlan.dart';
import 'package:cloundapp/pages/workstaion/oa/target/plan/planDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/target/plan/planDetailUnEdit.dart';
import 'package:cloundapp/pages/workstaion/oa/target/plan/planEdit.dart';
import 'package:cloundapp/pages/workstaion/oa/target/plan/planManager.dart';
import 'package:cloundapp/pages/workstaion/oa/target/targetFront.dart';
import 'package:cloundapp/pages/workstaion/oa/target/task/addTask.dart';
import 'package:cloundapp/pages/workstaion/oa/target/task/taskDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/target/task/taskDetailUnEdit.dart';
import 'package:cloundapp/pages/workstaion/oa/target/task/taskEdit.dart';
import 'package:cloundapp/pages/workstaion/oa/target/task/taskManager.dart';
import 'package:cloundapp/pages/workstaion/oa/work/addLaunchWork.dart';
import 'package:cloundapp/pages/workstaion/oa/work/checkWorkDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/work/checkWorkManager.dart';
import 'package:cloundapp/pages/workstaion/oa/work/launchWorkDetail.dart';
import 'package:cloundapp/pages/workstaion/oa/work/luanchWorkManager.dart';
import 'package:cloundapp/pages/workstaion/oa/work/workFront.dart';
import 'package:cloundapp/test/test.dart';


import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';


Handler splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SplashPage();
    }
);

Handler mainPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return MainPage();
    }
);

Handler threadManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ThreadManager();
    }
);

Handler addThreadHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddThread();
    }
);


Handler threadDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String goodId = params['id'].first;
      String type = params['type'].first;


      return ThreadDetail(id: goodId,type: type,);
    }
);

Handler threadEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String goodId = params['id'].first;
      return ThreadEdit(id: goodId,);
    }
);

Handler threadDetailUnEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String goodId = params['id'].first;
      return ThreadDetailUnEdit(id: goodId,);
    }
);


Handler followRecordHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String type = params['type'].first;
//      String source=params['source'].first;
//      return FollowRecord(type: type,source: source,);
      return FollowManager();
    }
);


Handler writeFollowHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddFollow();
    }
);

Handler transformToCustomerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return TransformToCustomer();
    }
);

Handler selectUserHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SelectUser();
    }
);

Handler loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    }
);

Handler departmentManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {

      return DepartmentManager();
    }
);

Handler customerManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CustomerManager();
    }
);

Handler addCustomerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddCustomer();
    }
);

Handler customerDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String threadId = params['id'].first;
      String type = params['type'].first;

      return CustomerDetail(id: threadId,type: type,);
    }
);
Handler customerEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String threadId = params['id'].first;
      return CustomerEdit(id: threadId,);
    }
);

Handler customerDetailUnEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String threadId = params['id'].first;
      return CustomerDetailUnEdit(id: threadId,);
    }
);


Handler customerBusinessListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String owners = params['owners'].first;

      return CustomerBusinessManager(id: id, owners: owners,);
    }
);

Handler customerAgreementListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String owners = params['owners'].first;
      String isBusiness = params['isBusiness'].first;

      return CustomerAgreementManager(id: id, owners: owners,isBusiness: isBusiness,);
    }
);

Handler customersSeaListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String custId = params['custId'].first;

      return CustomersSeaManager(custId: custId,);
    }
);

Handler businessManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return BusinessManager();
    }
);


Handler addBusinessHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddBusiness();
    }
);


Handler businessDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String type = params['type'].first;

      return BusinessDetail(id: id,type: type,);
    }
);

Handler businessEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return BusinessEdit(id: id,);
    }
);

Handler businessDetailUnEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return BusinessDetailUnEdit(id: id,);
    }
);


Handler  productManagerHandler= Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String type = params['type'].first;

      return ProductManager(id: id, type: type,);
    }
);

Handler  addProductHandler= Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddProduct();
    }
);

Handler  editProductHandler= Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return EditProduct();
    }
);

Handler  changePasswordHandler= Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ChangePassword();
    }
);

Handler  agreementManagerHandler= Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AgreementManager();
    }
);

Handler  addAgreementHandler= Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddAgreement();
    }
);

Handler agreementDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String type = params['type'].first;

      return AgreementDetail(id: id,type: type,);
    }
);

Handler agreementEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return AgreementEdit(id: id,);
    }
);

Handler agreementDetailUnEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return AgreementDetailUnEdit(id: id,);
    }
);

Handler attendanceHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Attendance();
    }
);

Handler applyManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ApplyManager();
    }
);

Handler addApplyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddApply();
    }
);

Handler applyDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return ApplyDetail(id: id,);
    }
);


Handler checkManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CheckManager();
    }
);

Handler checkDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String checkType = params['checkType'].first;

      return CheckDetail(id: id,checkType: checkType,);
    }
);

Handler wagesManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return WagesManager();
    }
);

Handler wagesDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String month = params['month'].first;
      Map<String, dynamic> json=jsonDecode(params['wagesModel'][0]);
      WagesModel wagesModel=WagesModel.fromJson(json);
      return WagesDetail(month: month,wagesModel: wagesModel,);
    }
);

Handler employFrontHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return EmployFront();
    }
);

Handler employManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return EmployManager();
    }
);

Handler talentManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return TalentManager();
    }
);

Handler talentDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String employ = params['employ'].first;

      print(params['employ']);
      return TalentDetail(id: id,employ: employ,);
    }
);


Handler targetFrontHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return TargetFront();
    }
);

Handler planManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return PlanManager();
    }
);

Handler addPlanHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddPlan();
    }
);

Handler planDetailUnEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return PlanDetailUnEdit(id: id,);
    }
);

Handler planDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String status = params['status'].first;


      return PlanDetail(id: id,status:status);
    }
);


Handler planEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return PlanEdit(id: id,);
    }
);

Handler taskManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return TaskManager();
    }
);

Handler addTaskHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddTask();
    }
);

Handler taskDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String status=params['status'].first;
      return TaskDetail(id: id,status: status,);
    }
);

Handler taskEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return TaskEdit(id: id,);
    }
);

Handler taskDetailUnEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return TaskDetailUnEdit(id: id,);
    }
);

Handler infoManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return InfoManager();
    }
);

Handler addInfoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddInfo();
    }
);

Handler infoDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String status=params['status'].first;
      return InfoDetail(id: id,status: status,);
    }
);

Handler infoEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return InfoEdit(id: id);
    }
);

Handler infoDetailUnEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return InfoDetailUnEdit(id: id,);
    }
);

Handler noticeManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return NoticeManager();
    }
);

Handler noticeDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return NoticeDetail(id: id,);
    }
);

Handler capitalFrontHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CapitalFront();
    }
);

Handler supplyManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SupplyManager();
    }
);

Handler supplyDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return SupplyDetail(id: id,);
    }
);

Handler addSupplyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddSupply();
    }
);

Handler capitalManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CapitalManager();
    }
);

Handler capitalDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      return CapitalDetail(id: id,);
    }
);

Handler addCapitalHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddCapital();
    }
);


Handler launchWorkHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LaunchWorkManager();
    }
);

Handler workFrontHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return WorkFront();
    }
);

Handler addLaunchWorkHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddLaunchWork();
    }
);

Handler launchWorkDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String type = params['type'].first;
      return LaunchWorkDetail(id: id,type: type,);
    }
);

Handler checkWorkManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CheckWorkManager();
    }
);

Handler checkWorkDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id'].first;
      String type = params['type'].first;
      String checkType = params['checkType'].first;

      return CheckWorkDetail(id: id,type: type,checkType: checkType,);
    }
);

Handler departmentUserManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['deptId'].first;
      return DepartmentUserManager(deptId: id,);
    }
);

Handler contactUserManagerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['typeId'].first;
      return ContactUserManager(typeId: id,);
    }
);

Handler aboutUsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AboutUs();
    }
);

Handler testHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return TestSettingsPage();
    }
);