
import 'package:cloundapp/pages/other/noPage.dart';
import 'package:cloundapp/routes/route_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  //根路径
  static String mainPage = '/mainPage';
  //登录
  static String login = '/login';

  //
  static String splash = '/splash';

  //线索管理
  static String threadManager = '/threadManager';
  //新增线索
  static String addThread = '/addThread';
  //线索详情
  static String threadDetail = '/threadDetail';
  //线索编辑
  static String threadEdit = '/threadEdit';
  //跟进记录
  static String followRecord = '/followRecord';
  //写跟进
  static String writeFollow = '/writeFollow';
  //转为客户
  static String transformToCustomer = '/transformToCustomer';
  //选择用户
  static String selectUser = '/selectUser';
  //线索详情已转化的
  static String threadDetailUnEdit = '/threadDetailUnEdit';
  //线索详情已转化的
  static String departmentManager = '/departmentManager';


  //客户列表
  static String customerManager = '/customerManager';
  //新增客户
  static String addCustomer = '/addCustomer';
  //客户详情
  static String customerDetail = '/customerDetail';
  //客户详情
  static String customerEdit = '/customerEdit';
  //客户详情不可编辑
  static String customerDetailUnEdit = '/customerDetailUnEdit';
  //客户下的商机
  static String customerBusinessList = '/customerBusinessList';
  //客户下的合同
  static String customerAgreementList = '/customerAgreementList';
  //客户公海列表
  static String customersSeaList = '/customersSeaList';


  //商机列表
  static String businessEdit = '/businessEdit';
  static String businessManager = '/businessManager';
  static String addBusindess = '/addBusindess';
  static String businessDetail = '/businessDetail';
  static String productManager = '/productManager';
  static String addProduct = '/addProduct';
  static String editProduct = '/editProduct';
  static String businessDetailUnEdit = '/businessDetailUnEdit';


  //合同
  static String agreementManager = '/agreementManager';
  static String addAgreement = '/addAgreement';
  static String agreementDetail = '/agreementDetail';
  static String agreementDetailUnEdit = '/agreementDetailUnEdit';
  static String agreementEdit = '/agreementEdit';



  //我的
  static String changePassword = '/changePassword';
  static String aboutUs = '/aboutUs';


  //考勤
  static String attendance = '/attendance';

  //申请
  //申请列表
  static String applyManager = '/applyManager';
  static String addApply = '/addApply';
  static String applyDetail = '/applyDetail';

  //审批
  static String checkManager = '/checkManager';
  static String checkDetail = '/checkDetail';

  //工资
  static String wagesManager = '/wagesManager';
  static String wagesDetail = '/wagesDetail';

  //招聘
  static String employFront = '/employFront';
  static String employManager = '/employManager';
  static String talentManager = '/talentManager';
  static String talentDetail = '/talentDetail';


  //计划
  static String targetFront = '/targetFront';
  static String planManager = '/planManager';
  static String addPlan = '/addPlan';
  static String planDetailUnEdit = '/planDetailUnEdit';
  static String planDetail = '/planDetail';
  static String planEdit = '/planEdit';

  //任务
  static String taskManager = '/taskManager';
  static String addTask = '/addTask';
  static String taskDetail = '/taskDetail';
  static String taskDetailUnEdit = '/taskDetailUnEdit';
  static String taskEdit = '/taskEdit';

  //报告
  static String infoManager = '/infoManager';
  static String addInfo = '/addInfo';
  static String infoDetail = '/infoDetail';
  static String infoDetailUnEdit = '/infoDetailUnEdit';
  static String infoEdit = '/infoEdit';


  //公告信息
  static String noticeManager = '/noticeManager';
  static String noticeDetail = '/noticeDetail';

  //用品资产
  static String capitalFront = '/capitalFront';
  static String supplyManager = '/supplyManager';
  static String supplyDetail = '/supplyDetail';
  static String addSupply = '/addSupply';

  //资产领用
  static String capitalManager = '/capitalManager';
  static String capitalDetail = '/capitalDetail';
  static String addCapital = '/addCapital';


  static String launchWorkManager = '/launchWorkManager';
  static String workFont = '/workFront';
  static String addLaunchWork = '/addLaunchWork';
  static String launchWorkDetail = '/launchWorkDetail';
  static String checkWorkManager = '/checkWorkManager';
  static String checkWorkDetail = '/checkWorkDetail';


  //通讯录
  static String departmentUserManager = '/departmentUserManager';
  static String contactUserManager = '/contactUserManager';


  //test
  static String test = '/test';

  //配置路由对象
  static void configureRoutes(Router router) {
    //没有找到路由的回调方法
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return NoPage();
        }
    );

    router.define(login, handler: loginHandler);
    router.define(splash, handler: splashHandler);
    router.define(mainPage, handler: mainPageHandler);
    router.define(threadManager, handler: threadManagerHandler);
    router.define(addThread, handler: addThreadHandler);
    router.define(threadDetail, handler: threadDetailHandler);
    router.define(threadEdit, handler: threadEditHandler);

    router.define(followRecord, handler: followRecordHandler);
    router.define(writeFollow, handler: writeFollowHandler);
    router.define(transformToCustomer, handler: transformToCustomerHandler);
    router.define(selectUser, handler: selectUserHandler);
    router.define(threadDetailUnEdit, handler: threadDetailUnEditHandler);
    router.define(departmentManager, handler: departmentManagerHandler);
    router.define(customerManager, handler: customerManagerHandler);
    router.define(addCustomer, handler: addCustomerHandler);
    router.define(customerDetail, handler: customerDetailHandler);
    router.define(customerEdit, handler: customerEditHandler);

    router.define(customerDetailUnEdit, handler: customerDetailUnEditHandler);
    router.define(customerBusinessList, handler: customerBusinessListHandler);
    router.define(customerAgreementList, handler: customerAgreementListHandler);
    router.define(customersSeaList, handler: customersSeaListHandler);
    router.define(businessManager, handler: businessManagerHandler);
    router.define(addBusindess, handler: addBusinessHandler);
    router.define(businessDetail, handler: businessDetailHandler);
    router.define(businessDetailUnEdit, handler: businessDetailUnEditHandler);
    router.define(businessEdit, handler: businessEditHandler);

    router.define(productManager, handler: productManagerHandler);
    router.define(addProduct, handler: addProductHandler);
    router.define(editProduct, handler:editProductHandler);
    router.define(changePassword, handler:changePasswordHandler);
    router.define(agreementManager, handler:agreementManagerHandler);
    router.define(addAgreement, handler:addAgreementHandler);
    router.define(agreementDetail, handler:agreementDetailHandler);
    router.define(agreementDetailUnEdit, handler:agreementDetailUnEditHandler);
    router.define(agreementEdit, handler:agreementEditHandler);

    router.define(attendance, handler:attendanceHandler);
    router.define(applyManager, handler:applyManagerHandler);

    router.define(addApply, handler:addApplyHandler);
    router.define(applyDetail, handler:applyDetailHandler);
    router.define(checkManager, handler:checkManagerHandler);
    router.define(checkDetail, handler:checkDetailHandler);

    router.define(wagesManager, handler:wagesManagerHandler);
    router.define(wagesDetail, handler:wagesDetailHandler);

    router.define(employFront, handler:employFrontHandler);
    router.define(talentManager, handler:talentManagerHandler);
    router.define(employManager, handler:employManagerHandler);
    router.define(talentDetail, handler:talentDetailHandler);


    router.define(targetFront, handler:targetFrontHandler);
    router.define(planManager, handler:planManagerHandler);
    router.define(addPlan, handler:addPlanHandler);
    router.define(planDetailUnEdit, handler:planDetailUnEditHandler);
    router.define(planDetail, handler:planDetailHandler);
    router.define(planEdit, handler:planEditHandler);

    router.define(taskManager, handler:taskManagerHandler);
    router.define(addTask, handler:addTaskHandler);
    router.define(taskDetail, handler:taskDetailHandler);
    router.define(taskDetailUnEdit, handler:taskDetailUnEditHandler);
    router.define(taskEdit, handler:taskEditHandler);


    router.define(infoManager, handler:infoManagerHandler);
    router.define(addInfo, handler:addInfoHandler);
    router.define(infoDetail, handler:infoDetailHandler);
    router.define(infoDetailUnEdit, handler:infoDetailUnEditHandler);
    router.define(infoEdit, handler:infoEditHandler);


    router.define(noticeManager, handler:noticeManagerHandler);
    router.define(noticeDetail, handler:noticeDetailHandler);


    router.define(capitalFront, handler:capitalFrontHandler);
    router.define(supplyManager, handler:supplyManagerHandler);
    router.define(supplyDetail, handler:supplyDetailHandler);
    router.define(addSupply, handler:addSupplyHandler);


    router.define(capitalManager, handler:capitalManagerHandler);
    router.define(capitalDetail, handler:capitalDetailHandler);
    router.define(addCapital, handler:addCapitalHandler);

    router.define(launchWorkManager, handler:launchWorkHandler);
    router.define(workFont, handler:workFrontHandler);
    router.define(addLaunchWork, handler:addLaunchWorkHandler);
    router.define(launchWorkDetail, handler:launchWorkDetailHandler);
    router.define(checkWorkManager, handler:checkWorkManagerHandler);
    router.define(checkWorkDetail, handler:checkWorkDetailHandler);


    router.define(departmentUserManager, handler:departmentUserManagerHandler);
    router.define(contactUserManager, handler:contactUserManagerHandler);


    router.define(aboutUs, handler:aboutUsHandler);

    router.define(test, handler:testHandler);



  }



}