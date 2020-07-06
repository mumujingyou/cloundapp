class ApplyModelList {
  int total;
  List<ApplyModel> data;

  ApplyModelList({this.total, this.data});

  ApplyModelList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<ApplyModel>();
      json['data'].forEach((v) {
        data.add(new ApplyModel.fromJson(v));
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

class ApplyModel {
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
  String approvalBy;
  String flag;
  String startTime;
  String endTime;
  String payTime;


  ApplyModel(
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
        this.approvalBy,
        this.startTime,
        this.endTime,
        this.payTime,
        this.flag});

  ApplyModel.fromJson(Map<String, dynamic> json) {
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
    approvalBy = json['approvalBy'];
    flag = json['flag'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    payTime = json['payTime'];


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
    data['approvalBy'] = this.approvalBy;
    data['flag'] = this.flag;
    data['payTime'] = this.payTime;

    return data;
  }
}