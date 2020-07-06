class WorkListModel {
  int total;
  List<WorkModel> data;

  WorkListModel({this.total, this.data});

  WorkListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<WorkModel>();
      json['data'].forEach((v) {
        data.add(new WorkModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkModel {
  String id;
  String applyType;
  String applyTypeStr;
  String applyReason;
  String userName;
  String dept;
  String applyTime;
  String status;
  String approver;
  String updateTime;
  String flag;
  String approvalBy;

  WorkModel(
      {this.id,
        this.applyType,
        this.applyTypeStr,
        this.applyReason,
        this.userName,
        this.dept,
        this.applyTime,
        this.status,
        this.approver,
        this.updateTime,
        this.flag,
        this.approvalBy});

  WorkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applyType = json['applyType'];
    applyTypeStr = json['applyTypeStr'];
    applyReason = json['applyReason'];
    userName = json['userName'];
    dept = json['dept'];
    applyTime = json['applyTime'];
    status = json['status'];
    approver = json['approver'];
    updateTime = json['updateTime'];
    flag = json['flag'];
    approvalBy = json['approvalBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applyType'] = this.applyType;
    data['applyTypeStr'] = this.applyTypeStr;
    data['applyReason'] = this.applyReason;
    data['userName'] = this.userName;
    data['dept'] = this.dept;
    data['applyTime'] = this.applyTime;
    data['status'] = this.status;
    data['approver'] = this.approver;
    data['updateTime'] = this.updateTime;
    data['flag'] = this.flag;
    data['approvalBy'] = this.approvalBy;
    return data;
  }
}


class WorkDetailModel {
  String id;
  String applyId;
  String applyNo;
  String applyTitle;
  String userName;
  String dept;
  String post;
  String sex;
  String hiredate;
  String applyType;
  String status;
  String site;
  String reason;
  String startTime;
  String endTime;
  double duration;
  String createTime;
  String updateTime;
  String tenantId;
  String delFlag;
  var money;
  String delivery;//期望支付时间
  var amount;
  String remarks;
  String goodsName;
  String costType;
  String fileName;
  String useTime;
  String projectName;
  String projectTime;
  String outline;
  String positiveTime;
  String selfReview;
  String hireForm;
  String turnStat;
  String spec;
  String type;
  String leaveTime;
  String payTime;

  WorkDetailModel(
      {this.id,
        this.applyId,
        this.applyNo,
        this.applyTitle,
        this.userName,
        this.dept,
        this.post,
        this.sex,
        this.hiredate,
        this.applyType,
        this.status,
        this.site,
        this.reason,
        this.startTime,
        this.endTime,
        this.duration,
        this.createTime,
        this.updateTime,
        this.tenantId,
        this.delFlag,
        this.money,
        this.delivery,
        this.amount,
        this.remarks,
        this.goodsName,
        this.costType,
        this.fileName,
        this.useTime,
        this.projectName,
        this.outline,
        this.positiveTime,
        this.selfReview,
        this.hireForm,
        this.turnStat,
        this.spec,
        this.type,
        this.projectTime,
        this.leaveTime,
        this.payTime,

      });

  WorkDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applyId = json['applyId'];
    applyNo = json['applyNo'];
    applyTitle = json['applyTitle'];
    userName = json['userName'];
    dept = json['dept'];
    post = json['post'];
    sex = json['sex'];
    hiredate = json['hiredate'];
    applyType = json['applyType'];
    status = json['status'];
    site = json['site'];
    reason = json['reason'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    duration = json['duration'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    tenantId = json['tenantId'];
    delFlag = json['delFlag'];
    money = json['money'];
    delivery = json['delivery'];
    amount = json['amount'];
    remarks = json['remarks'];
    goodsName = json['goodsName'];
    costType = json['costType'];
    fileName = json['fileName'];
    useTime = json['useTime'];
    projectName = json['projectName'];
    outline = json['outline'];
    positiveTime = json['positiveTime'];
    selfReview = json['selfReview'];
    hireForm = json['hireForm'];
    turnStat = json['turnStat'];
    spec = json['spec'];
    type = json['type'];
    projectTime = json['projectTime'];
    leaveTime = json['leaveTime'];
    payTime = json['payTime'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applyId'] = this.applyId;
    data['applyNo'] = this.applyNo;
    data['applyTitle'] = this.applyTitle;
    data['userName'] = this.userName;
    data['dept'] = this.dept;
    data['post'] = this.post;
    data['sex'] = this.sex;
    data['hiredate'] = this.hiredate;
    data['applyType'] = this.applyType;
    data['status'] = this.status;
    data['site'] = this.site;
    data['reason'] = this.reason;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['duration'] = this.duration;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['tenantId'] = this.tenantId;
    data['delFlag'] = this.delFlag;
    data['money'] = this.money;
    data['delivery'] = this.delivery;
    data['amount'] = this.amount;
    data['remarks'] = this.remarks;
    data['goodsName'] = this.goodsName;
    data['costType'] = this.costType;
    data['fileName'] = this.fileName;
    data['useTime'] = this.useTime;
    data['projectName'] = this.projectName;
    data['outline'] = this.outline;
    data['positiveTime'] = this.positiveTime;
    data['selfReview'] = this.selfReview;
    data['hireForm'] = this.hireForm;
    data['turnStat'] = this.turnStat;
    data['spec'] = this.spec;
    data['type'] = this.type;
    data['projectTime'] = this.projectTime;
    data['leaveTime'] = this.leaveTime;
    data['payTime'] = this.payTime;

    return data;
  }
}


class WorkNodeModel {
  String id;
  String busId;
  String processId;
  String processDetailId;
  String mode;
  String orderSeq;
  String approvalBy;
  String approvalVal;
  String copyBy;
  String copyVal;
  String status;
  String opinion;
  String approvalInfo;
  String createBy;
  String createTime;
  String tenantId;

  WorkNodeModel(
      {this.id,
        this.busId,
        this.processId,
        this.processDetailId,
        this.mode,
        this.orderSeq,
        this.approvalBy,
        this.approvalVal,
        this.copyBy,
        this.copyVal,
        this.status,
        this.opinion,
        this.approvalInfo,
        this.createBy,
        this.createTime,
        this.tenantId});

  WorkNodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busId = json['busId'];
    processId = json['processId'];
    processDetailId = json['processDetailId'];
    mode = json['mode'];
    orderSeq = json['orderSeq'];
    approvalBy = json['approvalBy'];
    approvalVal = json['approvalVal'];
    copyBy = json['copyBy'];
    copyVal = json['copyVal'];
    status = json['status'];
    opinion = json['opinion'];
    approvalInfo = json['approvalInfo'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['busId'] = this.busId;
    data['processId'] = this.processId;
    data['processDetailId'] = this.processDetailId;
    data['mode'] = this.mode;
    data['orderSeq'] = this.orderSeq;
    data['approvalBy'] = this.approvalBy;
    data['approvalVal'] = this.approvalVal;
    data['copyBy'] = this.copyBy;
    data['copyVal'] = this.copyVal;
    data['status'] = this.status;
    data['opinion'] = this.opinion;
    data['approvalInfo'] = this.approvalInfo;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}