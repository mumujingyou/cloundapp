//1创建2转评审3退回4转执行5发布执行
List<String> planStatusStrs=["创建","转评审","退回","转执行","发布执行"];
List<String> planStatusInts=["1","2","3","4","5"];
String getPlanStatusStr(String status){
  String result=planStatusStrs[0];
  if(status==planStatusInts[0]){
    result=planStatusStrs[0];
  }else if(status==planStatusInts[1]){
    result=planStatusStrs[1];
  }else if(status==planStatusInts[2]){
    result=planStatusStrs[2];
  }else if(status==planStatusInts[3]){
    result=planStatusStrs[3];
  }else if(status==planStatusInts[4]){
    result=planStatusStrs[4];
  }
  return result;
}

//1创建2转执行3进行汇报和评估4退回5.关闭
List<String> taskStatusStrs=["创建","转执行","进行汇报和评估","退回","关闭"];
List<String> taskStatusInts=["1","2","3","4","5"];
String getTaskStatusStr(String status){
  String result=taskStatusStrs[0];
  if(status==taskStatusInts[0]){
    result=taskStatusStrs[0];
  }else if(status==taskStatusInts[1]){
    result=taskStatusStrs[1];
  }else if(status==taskStatusInts[2]){
    result=taskStatusStrs[2];
  }else if(status==taskStatusInts[3]){
    result=taskStatusStrs[3];
  }else if(status==taskStatusInts[4]){
    result=taskStatusStrs[4];
  }
  return result;
}

//1创建2转评审3退回4创建人知悉5关闭6通过
//1创建2转执行3进行汇报和评估4退回5.关闭
List<String> infoStatusStrs=["创建","转评审","退回","创建人知悉","关闭","通过"];
List<String> infoStatusInts=["1","2","3","4","5","6"];
String getInfoStatusStr(String status){
  String result=infoStatusStrs[0];
  if(status==infoStatusInts[0]){
    result=infoStatusStrs[0];
  }else if(status==infoStatusInts[1]){
    result=infoStatusStrs[1];
  }else if(status==infoStatusInts[2]){
    result=infoStatusStrs[2];
  }else if(status==infoStatusInts[3]){
    result=infoStatusStrs[3];
  }else if(status==infoStatusInts[4]){
    result=infoStatusStrs[4];
  }else if(status==infoStatusInts[5]){
    result=infoStatusStrs[5];
  }
  return result;
}




//`计划分类:1年度2季度3月度4周5项目6其他
List<String> planTypeStrs=["年度","季度","月度","周","项目","其他"];
List<String> planTypeInts=["1","2","3","4","5","6"];
String planTypeStr=planTypeStrs[0];
String getPlanTypeStr(String status){
  String result=planTypeStrs[0];
  if(status==planTypeInts[0]){
    result=planTypeStrs[0];
  }else if(status==planTypeInts[1]){
    result=planTypeStrs[1];
  }else if(status==planTypeInts[2]){
    result=planTypeStrs[2];
  }else if(status==planTypeInts[3]){
    result=planTypeStrs[3];
  }else if(status==planTypeInts[4]){
    result=planTypeStrs[4];
  }else if(status==planTypeInts[5]){
    result=planTypeStrs[5];
  }
  return result;
}
String getPlanTypeInt(String status){
  String result=planTypeInts[0];
  if(status==planTypeStrs[0]){
    result=planTypeInts[0];
  }else if(status==planTypeStrs[1]){
    result=planTypeInts[1];
  }else if(status==planTypeStrs[2]){
    result=planTypeInts[2];
  }else if(status==planTypeStrs[3]){
    result=planTypeInts[3];
  }else if(status==planTypeStrs[4]){
    result=planTypeInts[4];
  }else if(status==planTypeStrs[5]){
    result=planTypeInts[5];
  }
  return result;
}


//`任务分类:1.常规2.行政3.人事4.财务5.业务6.项目
List<String> taskTypeStrs=["常规","行政","人事","财务","业务","项目"];
List<String> taskTypeInts=["1","2","3","4","5","6"];
String taskTypeStr=taskTypeStrs[0];
String getTaskTypeStr(String status){
  String result=taskTypeStrs[0];
  if(status==taskTypeInts[0]){
    result=taskTypeStrs[0];
  }else if(status==taskTypeInts[1]){
    result=taskTypeStrs[1];
  }else if(status==taskTypeInts[2]){
    result=taskTypeStrs[2];
  }else if(status==taskTypeInts[3]){
    result=taskTypeStrs[3];
  }else if(status==taskTypeInts[4]){
    result=taskTypeStrs[4];
  }else if(status==taskTypeInts[5]){
    result=taskTypeStrs[5];
  }
  return result;
}
String getTaskTypeInt(String status){
  String result=taskTypeInts[0];
  if(status==taskTypeStrs[0]){
    result=taskTypeInts[0];
  }else if(status==taskTypeStrs[1]){
    result=taskTypeInts[1];
  }else if(status==taskTypeStrs[2]){
    result=taskTypeInts[2];
  }else if(status==taskTypeStrs[3]){
    result=taskTypeInts[3];
  }else if(status==taskTypeStrs[4]){
    result=taskTypeInts[4];
  }else if(status==taskTypeStrs[5]){
    result=taskTypeInts[5];
  }
  return result;
}


//`1001外出、1002采购、1003费用、1004用章、1005立项申请、1006转正、1007离职
List<String> applyTypeStrs=["外出","采购","费用","用章","立项","转正","离职",];
List<String> applyTypeInts=["1001","1002","1003","1004","1005","1006","1007",];
String applyTypeStr=applyTypeStrs[0];
String getApplyTypeStr(String status){
  String result=applyTypeStrs[0];
  if(status==applyTypeInts[0]){
    result=applyTypeStrs[0];
  }else if(status==applyTypeInts[1]){
    result=applyTypeStrs[1];
  }else if(status==applyTypeInts[2]){
    result=applyTypeStrs[2];
  }else if(status==applyTypeInts[3]){
    result=applyTypeStrs[3];
  }else if(status==applyTypeInts[4]){
    result=applyTypeStrs[4];
  }else if(status==applyTypeInts[5]){
    result=applyTypeStrs[5];
  }else if(status==applyTypeInts[6]){
    result=applyTypeStrs[6];
  }
  return result;
}
String getApplyTypeInt(String status){
  String result=applyTypeInts[0];
  if(status==applyTypeStrs[0]){
    result=applyTypeInts[0];
  }else if(status==applyTypeStrs[1]){
    result=applyTypeInts[1];
  }else if(status==applyTypeStrs[2]){
    result=applyTypeInts[2];
  }else if(status==applyTypeStrs[3]){
    result=applyTypeInts[3];
  }else if(status==applyTypeStrs[4]){
    result=applyTypeInts[4];
  }else if(status==applyTypeStrs[5]){
    result=applyTypeInts[5];
  }else if(status==applyTypeStrs[6]){
    result=applyTypeInts[6];
  }
  return result;
}


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

// 3001公章 3002 合同章 3003 法人章 3004 其他
List<String> yongZhangTypeStrs=["公章","合同章","法人章","其他"];//审批类型
List<String> yongZhangTypeInts=["3001","3002","3003","3004"];
String yongZhangTypeStr=yongZhangTypeStrs[0];
String getYongZhangTypeStr(String status){
  String result=checkTypeStrs[0];
  if(status==yongZhangTypeInts[0]){
    result=yongZhangTypeStrs[0];
  }else if(status==yongZhangTypeInts[1]){
    result=yongZhangTypeStrs[1];
  }else if(status==yongZhangTypeInts[2]){
    result=yongZhangTypeStrs[2];
  }else if(status==yongZhangTypeInts[3]){
    result=yongZhangTypeStrs[3];
  }
  return result;
}
String getYongZhangTypeInt(String status){
  String result=yongZhangTypeInts[0];
  if(status==yongZhangTypeStrs[0]){
    result=yongZhangTypeInts[0];
  }else if(status==yongZhangTypeStrs[1]){
    result=yongZhangTypeInts[1];
  }else if(status==yongZhangTypeStrs[2]){
    result=yongZhangTypeInts[2];
  }else if(status==yongZhangTypeStrs[3]){
    result=yongZhangTypeInts[3];
  }
  return result;
}


//费用申请类型2001 差旅费、2002 办公费、2003 招待费、2004 市内交通费、2005 通讯费、2006 采购付款 2007 其他
List<String> costTypeStrs=["差旅费","办公费","招待费","市内交通费","通讯费","采购付款","其他"];
List<String> costTypeInts=["2001","2002","2003","2004","2004","2006","2007",];
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
  }
  return result;
}
String getCostTypeInt(String status){
  String result="";
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
  }
  return result;
}


List<String> hireFormStrs=["正式","非正式",];//聘用形式
String hireFormStr=hireFormStrs[0];

List<String> turnStatStrs=["转正","试用",];//转正状态
String turnStatStr=turnStatStrs[0];