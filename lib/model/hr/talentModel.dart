class TalentModelList {
  int total;
  List<TalentModel> data;

  TalentModelList({this.total, this.data});

  TalentModelList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<TalentModel>();
      json['data'].forEach((v) {
        data.add(new TalentModel.fromJson(v));
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

class TalentModel {
  String id;
  String talentNo;
  String name;
  String phone;
  String mail;
  String education;
  String employId;
  String employ;
  String interviewTime;
  String interviewBy;
  String channel;
  String deliveryTime;
  String status;
  String reason;
  String remarks;
  String createBy;
  String createTime;
  String updateTime;
  String tenantId;
  var list;
  String flag;
  String isTalent;
  String startDate;
  String endDate;

  TalentModel(
      {this.id,
        this.talentNo,
        this.name,
        this.phone,
        this.mail,
        this.education,
        this.employId,
        this.employ,
        this.interviewTime,
        this.interviewBy,
        this.channel,
        this.deliveryTime,
        this.status,
        this.reason,
        this.remarks,
        this.createBy,
        this.createTime,
        this.updateTime,
        this.tenantId,
        this.list,
        this.flag,
        this.isTalent,
        this.startDate,
        this.endDate});

  TalentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentNo = json['talentNo'];
    name = json['name'];
    phone = json['phone'];
    mail = json['mail'];
    education = json['education'];
    employId = json['employId'];
    employ = json['employ'];
    interviewTime = json['interviewTime'];
    interviewBy = json['interviewBy'];
    channel = json['channel'];
    deliveryTime = json['deliveryTime'];
    status = json['status'];
    reason = json['reason'];
    remarks = json['remarks'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    tenantId = json['tenantId'];
    list = json['list'];
    flag = json['flag'];
    isTalent = json['isTalent'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentNo'] = this.talentNo;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['mail'] = this.mail;
    data['education'] = this.education;
    data['employId'] = this.employId;
    data['employ'] = this.employ;
    data['interviewTime'] = this.interviewTime;
    data['interviewBy'] = this.interviewBy;
    data['channel'] = this.channel;
    data['deliveryTime'] = this.deliveryTime;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['remarks'] = this.remarks;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['tenantId'] = this.tenantId;
    data['list'] = this.list;
    data['flag'] = this.flag;
    data['isTalent'] = this.isTalent;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}