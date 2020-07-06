import 'package:cloundapp/model/crm/FollowModel.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';


//联系方式状态
List<String> connectStatusList=["未处理","联系方式有效","联系方式无效","关闭"];
String connectStatusStr=connectStatusList[0];
int getConnectStatusInt(String value){
  int result=-1;
  if(value==connectStatusList[0]){
    result=5011;
  }else if(value==connectStatusList[1]){
    result=5012;
  }else if(value==connectStatusList[2]){
    result=5013;
  }else if(value==connectStatusList[3]){
    result=5014;
  }
  return result;
}

String getConnectStatusStr(ThreadModel threadModel){
  String result;
  if(threadModel.followStatus==5011){
    result=connectStatusList[0];
  }else  if(threadModel.followStatus==5012){
    result=connectStatusList[1];
  }else  if(threadModel.followStatus==5013){
    result=connectStatusList[2];
  }else  if(threadModel.followStatus==5014){
    result=connectStatusList[3];
  }
  return result;
}

//线索管理
List<String> typeList=["我的线索","已转化的线索"];
String typeStr=null;
String getTypeStr(int type){
  String result;
  if(type==1){
    result=typeList[0];
  }else  if(type==3){
    result=typeList[1];
  }
  return result;
}
int getTypeInt(String value){
  int result=-1;
  if(value==typeList[0]){
    result=1;
  }else if(value==typeList[1]){
    result=3;
  }
  return result;
}

/*
  跟进方式 4011、到访 4012、电话 4013、微信 4014、短信 4015、QQ 4016、邮件  4017、其他
  */
List<String> followWayList=["到访","电话","微信","短信","QQ","邮件","其他"];
String followWayStr=followWayList[0];
String getFollowWayStr(FollowModel followModel){
  if(followModel.way=="4011"){
    return followWayList[0];
  }else  if(followModel.way=="4012"){
    return followWayList[1];
  }else  if(followModel.way=="4013"){
    return followWayList[2];
  }else  if(followModel.way=="4014"){
    return followWayList[3];
  }else  if(followModel.way=="4015"){
    return followWayList[4];
  }else  if(followModel.way=="4016"){
    return followWayList[5];
  }else  if(followModel.way=="4017"){
    return followWayList[6];
  }
  return "";
}

int getFollowWayInt(String value){
  int result=-1;
  if(value==followWayList[0]){
    result=4011;
  }else if(value==followWayList[1]){
    result=4012;
  }else if(value==followWayList[2]){
    result=4013;
  }else if(value==followWayList[3]){
    result=4014;
  }else if(value==followWayList[4]){
    result=4015;
  }else if(value==followWayList[5]){
    result=4016;
  }else if(value==followWayList[6]){
    result=4017;
  }
  return result;
}

//客户类型 1021、重要客户 1022、普通客户 1023、低价值客户
List<String> customerTypeList=["重要客户","普通客户","低价值客户"];
String customerTypeStr=customerTypeList[0];
String getCustomerTypeStr(String value){
  if(value=="1021"){
    return customerTypeList[0];
  }else  if(value=="1022"){
    return customerTypeList[1];
  }else  if(value=="1023"){
    return customerTypeList[2];
  }
  return "";
}

int getCustomerTypeInt(String value){
  int result=-1;
  if(value==customerTypeList[0]){
    result=1021;
  }else if(value==customerTypeList[1]){
    result=1022;
  }else if(value==customerTypeList[2]){
    result=1023;
  }
  return result;
}

List<String> customers=["我负责的客户","我协作的客户"];
String customersStr="";
String getCustomerStr(int type){
  String result;
  if(type==2){
    result=customers[0];
  }else  if(type==3){
    result=customers[1];
  }
  return result;
}
int customerTypeInt(String value){
  int result=-1;
  if(value==customers[0]){
    result=2;
  }else if(value==customers[1]){
    result=3;
  }
  return result;
}


List<String> businesses=["我的商机","我协作的商机"];
String businessStr="";
String getBusinessStr(int type){
  String result;
  if(type==1){
    result=businesses[0];
  }else  if(type==2){
    result=businesses[1];
  }
  return result;
}
int getBusinessInt(String value){
  int result=-1;
  if(value==businesses[0]){
    result=1;
  }else if(value==businesses[1]){
    result=2;
  }
  return result;
}

//不传该参数则查全部，6021 初步接洽 6022 需求确定 6023 方案/报价 6024 谈判合同 6025 赢单 6026 输单
List<String> businessTypes=["初步接洽","需求确定","方案/报价","谈判合同","赢单","输单"];
String businessTypeStr="";
String getBusinessTypeStr(int type){
  String result="";
  if(type==6021){
    result=businessTypes[0];
  }else  if(type==6022){
    result=businessTypes[1];
  }else  if(type==6023){
    result=businessTypes[2];
  }else  if(type==6024){
    result=businessTypes[3];
  }else  if(type==6025){
    result=businessTypes[4];
  }else  if(type==6026){
    result=businessTypes[5];
  }
  return result;
}
int getBusinessTypeInt(String value){
  int result=-1;
  if(value==businessTypes[0]){
    result=6021;
  }else if(value==businessTypes[1]){
    result=6022;
  }else if(value==businessTypes[2]){
    result=6023;
  }else if(value==businessTypes[3]){
    result=6024;
  }else if(value==businessTypes[4]){
    result=6025;
  }else if(value==businessTypes[5]){
    result=6026;
  }
  return result;
}



List<String> agreements=["我的合同","我协作的合同"];
String agreementStr=agreements[0];
String getAgreementStr(int type){
  String result;
  if(type==2){
    result=agreements[0];
  }else  if(type==3){
    result=agreements[1];
  }
  return result;
}
int getAgreementInt(String value){
  int result=-1;
  if(value==agreements[0]){
    result=2;
  }else if(value==agreements[1]){
    result=3;
  }
  return result;
}


// 9011、未开始 9012 执行中 9013成功结束 9014意外终止
List<String> agreementTypes=["未开始","执行中","成功结束","意外终止"];
String agreementTypesStr=agreementTypes[0];
String getAgreementTypesStr(int type){
  String result="";
  if(type==9011){
    result=agreementTypes[0];
  }else  if(type==9012){
    result=agreementTypes[1];
  }else  if(type==9013){
    result=agreementTypes[2];
  }else  if(type==9014){
    result=agreementTypes[3];
  }
  return result;
}
int getAgreementTypesInt(String value){
  int result=-1;
  if(value==agreementTypes[0]){
    result=9011;
  }else if(value==agreementTypes[1]){
    result=9012;
  }else if(value==agreementTypes[2]){
    result=9013;
  }else if(value==agreementTypes[3]){
    result=9014;
  }
  return result;
}



