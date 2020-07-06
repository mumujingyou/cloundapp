
class TalentDetailModel {
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
  List<TalentNode> list;
  String flag;
  String isTalent;
  String startDate;
  String endDate;

  TalentDetailModel(
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

  TalentDetailModel.fromJson(Map<String, dynamic> json) {
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
    if (json['list'] != null) {
      list = new List<TalentNode>();
      json['list'].forEach((v) {
        list.add(new TalentNode.fromJson(v));
      });
    }
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
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['flag'] = this.flag;
    data['isTalent'] = this.isTalent;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class TalentNode {
  String id;
  String talentId;
  String interviewTime;
  String interviewBy;
  String status;
  String remarks;
  String rotation;
  String grade;
  String createTime;

  TalentNode(
      {this.id,
        this.talentId,
        this.interviewTime,
        this.interviewBy,
        this.status,
        this.remarks,
        this.rotation,
        this.grade,
        this.createTime});

  TalentNode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talentId'];
    interviewTime = json['interviewTime'];
    interviewBy = json['interviewBy'];
    status = json['status'];
    remarks = json['remarks'];
    rotation = json['rotation'];
    grade = json['grade'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentId'] = this.talentId;
    data['interviewTime'] = this.interviewTime;
    data['interviewBy'] = this.interviewBy;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['rotation'] = this.rotation;
    data['grade'] = this.grade;
    data['createTime'] = this.createTime;
    return data;
  }
}