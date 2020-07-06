class CheckNodeModelList {

  List<CheckNodeModel> data;

  CheckNodeModelList({this.data});

  CheckNodeModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CheckNodeModel>();
      json['data'].forEach((v) {
        data.add(new CheckNodeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckNodeModel {
  String nodeStatus;
  String orderSeq;
  List<BusProcessLogs> busProcessLogs;

  CheckNodeModel({this.nodeStatus, this.orderSeq, this.busProcessLogs});

  CheckNodeModel.fromJson(Map<String, dynamic> json) {
    nodeStatus = json['nodeStatus'];
    orderSeq = json['orderSeq'];
    if (json['busProcessLogs'] != null) {
      busProcessLogs = new List<BusProcessLogs>();
      json['busProcessLogs'].forEach((v) {
        busProcessLogs.add(new BusProcessLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nodeStatus'] = this.nodeStatus;
    data['orderSeq'] = this.orderSeq;
    if (this.busProcessLogs != null) {
      data['busProcessLogs'] =
          this.busProcessLogs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusProcessLogs {
  String id;
  String busId;
  String processId;
  String processDetailId;
  String mode;
  String orderSeq;
  String approvalBy;
  String approvalVal;
  String status;
  String opinion;
  String approvalInfo;
  String createBy;
  String createTime;
  String tenantId;
  String copyBy;
  String copyVal;

  BusProcessLogs(
      {this.id,
        this.busId,
        this.processId,
        this.processDetailId,
        this.mode,
        this.orderSeq,
        this.approvalBy,
        this.approvalVal,
        this.status,
        this.opinion,
        this.approvalInfo,
        this.createBy,
        this.createTime,
        this.tenantId,
        this.copyBy,
        this.copyVal});

  BusProcessLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busId = json['busId'];
    processId = json['processId'];
    processDetailId = json['processDetailId'];
    mode = json['mode'];
    orderSeq = json['orderSeq'];
    approvalBy = json['approvalBy'];
    approvalVal = json['approvalVal'];
    status = json['status'];
    opinion = json['opinion'];
    approvalInfo = json['approvalInfo'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    tenantId = json['tenantId'];
    copyBy = json['copyBy'];
    copyVal = json['copyVal'];
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
    data['status'] = this.status;
    data['opinion'] = this.opinion;
    data['approvalInfo'] = this.approvalInfo;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    data['copyBy'] = this.copyBy;
    data['copyVal'] = this.copyVal;
    return data;
  }
}