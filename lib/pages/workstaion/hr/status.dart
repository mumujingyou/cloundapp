
//0审批通过 1 审批驳回 2 审批中 不传则查全部，查已审批列表时传用,拼接的字符串 0,1 待审批传2
List<String> applyStatusStr=["全部","审批通过","审批驳回","审批中"];
List<String> applyStatusInt=["","0","1","2"];
String statusStr=applyStatusStr[0];
String getApplyStatusStr(String status){
  String result="";
  if(status==applyStatusInt[0]){
    result=applyStatusStr[0];
  }else if(status==applyStatusInt[1]){
    result=applyStatusStr[1];
  }else if(status==applyStatusInt[2]){
    result=applyStatusStr[2];
  }else if(status==applyStatusInt[3]){
    result=applyStatusStr[3];
  }
  return result;
}
String getApplyStatusInt(String status){
  String result="";
  if(status==applyStatusStr[0]){
    result=applyStatusInt[0];
  }else if(status==applyStatusStr[1]){
    result=applyStatusInt[1];
  }else if(status==applyStatusStr[2]){
    result=applyStatusInt[2];
  }else if(status==applyStatusStr[3]){
    result=applyStatusInt[4];
  }
  return result;
}


//申请类型1001请假1002加班1003.报销1004.出差 用于查看详情区分
List<String> applyTypeStrs=["请假","加班","报销","出差"];
List<String> applyTypeInts=["1001","1002","1003","1004"];
String applyTypeStr=applyTypeStrs[0];
String getApplyTypeStr(String status){
  String result="";
  if(status==applyTypeInts[0]){
    result=applyTypeStrs[0];
  }else if(status==applyTypeInts[1]){
    result=applyTypeStrs[1];
  }else if(status==applyTypeInts[2]){
    result=applyTypeStrs[2];
  }else if(status==applyTypeInts[3]){
    result=applyTypeStrs[3];
  }
  return result;
}
String getApplyTypeInt(String status){
  String result="";
  if(status==applyTypeStrs[0]){
    result=applyTypeInts[0];
  }else if(status==applyTypeStrs[1]){
    result=applyTypeInts[1];
  }else if(status==applyTypeStrs[2]){
    result=applyTypeInts[2];
  }else if(status==applyTypeStrs[3]){
    result=applyTypeInts[4];
  }
  return result;
}


//请假类型：1011 年假 1012 事假 1013 病假 1014 调休假 1015 婚假 1016 产假 1017 陪产假 1018 其他
List<String> vacateTypeStrs=["年假","事假","病假","调休假","婚假","产假","陪产假","其他"];
List<String> vacateTypeInts=["1011","1012","1013","1014","1015","1016","1017","1018"];
String vacateTypeStr=vacateTypeStrs[0];
String getvacateTypeStr(String status){
  String result="";
  if(status==vacateTypeInts[0]){
    result=vacateTypeStrs[0];
  }else if(status==vacateTypeInts[1]){
    result=vacateTypeStrs[1];
  }else if(status==vacateTypeInts[2]){
    result=vacateTypeStrs[2];
  }else if(status==vacateTypeInts[3]){
    result=vacateTypeStrs[3];
  }else if(status==vacateTypeInts[4]){
    result=vacateTypeStrs[4];
  }else if(status==vacateTypeInts[5]){
    result=vacateTypeStrs[5];
  }else if(status==vacateTypeInts[6]){
    result=vacateTypeStrs[6];
  }else if(status==vacateTypeInts[7]){
    result=vacateTypeStrs[7];
  }
  return result;
}
String getVacateTypeInt(String status){
  String result="1011";
  if(status==vacateTypeStrs[0]){
    result=vacateTypeInts[0];
  }else if(status==vacateTypeStrs[1]){
    result=vacateTypeInts[1];
  }else if(status==vacateTypeStrs[2]){
    result=vacateTypeInts[2];
  }else if(status==vacateTypeStrs[3]){
    result=vacateTypeInts[3];
  }else if(status==vacateTypeStrs[4]){
    result=vacateTypeInts[4];
  }else if(status==vacateTypeStrs[5]){
    result=vacateTypeInts[5];
  }else if(status==vacateTypeStrs[6]){
    result=vacateTypeInts[6];
  }else if(status==vacateTypeStrs[7]){
    result=vacateTypeInts[7];
  }
  return result;
}


//报销类型：1021 差旅费 1022 交通费 1023 招待费 1024 其他
List<String> reimbTypeStrs=["差旅费","交通费","招待费","其他",];
List<String> reimbTypeInts=["1021","1022","1023","1024"];
String reimbTypeStr=reimbTypeStrs[0];
String getReimbTypeStr(String status){
  String result="";
  if(status==reimbTypeInts[0]){
    result=reimbTypeStrs[0];
  }else if(status==reimbTypeInts[1]){
    result=reimbTypeStrs[1];
  }else if(status==reimbTypeInts[2]){
    result=reimbTypeStrs[2];
  }else if(status==reimbTypeInts[3]){
    result=reimbTypeStrs[3];
  }
  return result;
}
String getReimbTypeInt(String status){
  String result="1021";
  if(status==reimbTypeStrs[0]){
    result=reimbTypeInts[0];
  }else if(status==reimbTypeStrs[1]){
    result=reimbTypeInts[1];
  }else if(status==reimbTypeStrs[2]){
    result=reimbTypeInts[2];
  }else if(status==reimbTypeStrs[3]){
    result=reimbTypeInts[3];
  }
  return result;
}


//费用类型：1031 飞机票 1032 火车票 1033 的士票 1034 住宿费 1035 餐饮费 1036
// 礼品费 1037 活动费 1038 通讯费 1039 补助 1040 其他
List<String> costTypeStrs=["飞机票","火车票","的士票","住宿费","餐饮费","礼品费",
                              "活动费","通讯费", "补助","其他"];
List<String> costTypeInts=["1031","1032","1033","1034","1035","1036","1037","1038","1039","1040"];
String costTypeStr=costTypeStrs[0];
String getCostTypeStr(String status){
  String result="";
  if(status==costTypeInts[0]){
    result=costTypeStrs[0];
  }else if(status==costTypeInts[1]){
    result=costTypeStrs[1];
  }else if(status==costTypeInts[2]){
    result=costTypeStrs[2];
  }else if(status==costTypeInts[3]){
    result=costTypeStrs[3];
  }else if(status==costTypeInts[4]){
    result=costTypeStrs[4];
  }else if(status==costTypeInts[5]){
    result=costTypeStrs[5];
  }else if(status==costTypeInts[6]){
    result=costTypeStrs[6];
  }else if(status==costTypeInts[7]){
    result=costTypeStrs[7];
  }else if(status==costTypeInts[7]){
    result=costTypeStrs[8];
  }else if(status==costTypeInts[7]){
    result=costTypeStrs[9];
  }
  return result;
}
String getCostTypeInt(String status){
  String result="1031";
  if(status==costTypeStrs[0]){
    result=costTypeInts[0];
  }else if(status==costTypeStrs[1]){
    result=costTypeInts[1];
  }else if(status==costTypeStrs[2]){
    result=costTypeInts[2];
  }else if(status==costTypeStrs[3]){
    result=costTypeInts[3];
  }else if(status==costTypeStrs[4]){
    result=costTypeInts[4];
  }else if(status==costTypeStrs[5]){
    result=costTypeInts[5];
  }else if(status==costTypeStrs[6]){
    result=costTypeInts[6];
  }else if(status==costTypeStrs[7]){
    result=costTypeInts[7];
  }else if(status==costTypeStrs[8]){
    result=costTypeInts[8];
  }else if(status==costTypeStrs[9]){
    result=costTypeInts[9];
  }
  return result;
}


List<String> checkTypeStrs=["我的审批","抄送我的",];//审批类型
List<String> checkTypeInts=["2","3",];
String checkTypeStr=checkTypeStrs[0];
String getCheckTypeStr(String status){
  String result=checkTypeStrs[0];
  if(status==checkTypeInts[0]){
    result=checkTypeStrs[0];
  }else if(status==checkTypeInts[1]){
    result=checkTypeStrs[1];
  }
  return result;
}
String getCheckTypeInt(String status){
  String result=checkTypeInts[0];
  if(status==checkTypeStrs[0]){
    result=checkTypeInts[0];
  }else if(status==checkTypeStrs[1]){
    result=checkTypeInts[1];
  }
  return result;
}

//`grade`  '等级1优2良3中4差',
List<String> talentGradeStrs=["优","良","中","差"];
List<String> talentGradeInts=["1","2","3","4"];
String talentGradeStr=talentGradeStrs[0];
String getTalentGradeStr(String status){
  String result=talentGradeStrs[0];
  if(status==talentGradeInts[0]){
    result=talentGradeStrs[0];
  }else if(status==talentGradeInts[1]){
    result=talentGradeStrs[1];
  }else if(status==talentGradeInts[2]){
    result=talentGradeStrs[2];
  }else if(status==talentGradeInts[3]){
    result=talentGradeStrs[3];
  }
  return result;
}
String getTalentGradeInt(String status){
  String result=talentGradeInts[0];
  if(status==talentGradeStrs[0]){
    result=talentGradeInts[0];
  }else if(status==talentGradeStrs[1]){
    result=talentGradeInts[1];
  }else if(status==talentGradeStrs[2]){
    result=talentGradeInts[2];
  }else if(status==talentGradeStrs[3]){
    result=talentGradeInts[3];
  }
  return result;
}


// `status`状态0新建1面试中2录用3.放弃',  最终状态
List<String> talentStatuss=["新建","面试中","录用","放弃"];
String getTalentStatusStr(String type){
  String result="";
  if(type=="0"){
    result=talentStatuss[0];
  }else  if(type=="1"){
    result=talentStatuss[1];
  }else  if(type=="2"){
    result=talentStatuss[2];
  }else  if(type=="3"){
    result=talentStatuss[3];
  }
  return result;
}


// `0未进行1通过2拒绝  节点
List<String> talentResultStr=["未进行","通过","拒绝",];
String getTalentResultStr(String type){
  String result="";
  if(type=="0"){
    result=talentResultStr[0];
  }else  if(type=="1"){
    result=talentResultStr[1];
  }else  if(type=="2"){
    result=talentResultStr[2];
  }
  return result;
}

