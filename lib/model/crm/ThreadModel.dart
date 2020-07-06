import 'package:cloundapp/model/crm/BaseClass.dart';

class ThreadModel extends BaseClass {
  String id;
  String clueNo;
  String followId;
  int followStatus;
  String clueName;
  String post;
  String corporateName;
  String telephone;
  String mobilePhone;
  String mailBox;
  int clueSource;
  int clueturnStatus;
  String owners;
  int ownersDept;
  String ownersDeptName;
  String oldOwners;
  int oldOwnersDept;
  String oldOwnersDeptName;
  String wechatNumber;
  String qqNumber;
  String nextFollowTime;
  String address;
  String hobby;
  String createTime;
  String createBy;
  String createName;
  String updateTime;
  String updateBy;
  String remarks;
  int delFlag;
  String deptId;
  String followStatusStr;
  String turnCustTime;
  String tenantId;

  ThreadModel(
      {this.id,
        this.clueNo,
        this.followId,
        this.followStatus,
        this.clueName,
        this.post,
        this.corporateName,
        this.telephone,
        this.mobilePhone,
        this.mailBox,
        this.clueSource,
        this.clueturnStatus,
        this.owners,
        this.ownersDept,
        this.ownersDeptName,
        this.oldOwners,
        this.oldOwnersDept,
        this.oldOwnersDeptName,
        this.wechatNumber,
        this.qqNumber,
        this.nextFollowTime,
        this.address,
        this.hobby,
        this.createTime,
        this.createBy,
        this.createName,
        this.updateTime,
        this.updateBy,
        this.remarks,
        this.delFlag,
        this.deptId,
        this.followStatusStr,
        this.turnCustTime,
        this.tenantId});

  ThreadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clueNo = json['clueNo'];
    followId = json['followId'];
    followStatus = json['followStatus'];
    clueName = json['clueName'];
    post = json['post'];
    corporateName = json['corporateName'];
    telephone = json['telephone'];
    mobilePhone = json['mobilePhone'];
    mailBox = json['mailBox'];
    clueSource = json['clueSource'];
    clueturnStatus = json['clueturnStatus'];
    owners = json['owners'];
    ownersDept = json['ownersDept'];
    ownersDeptName = json['ownersDeptName'];
    oldOwners = json['oldOwners'];
    oldOwnersDept = json['oldOwnersDept'];
    oldOwnersDeptName = json['oldOwnersDeptName'];
    wechatNumber = json['wechatNumber'];
    qqNumber = json['qqNumber'];
    nextFollowTime = json['nextFollowTime'];
    address = json['address'];
    hobby = json['hobby'];
    createTime = json['createTime'];
    createBy = json['createBy'];
    createName = json['createName'];
    updateTime = json['updateTime'];
    updateBy = json['updateBy'];
    remarks = json['remarks'];
    delFlag = json['delFlag'];
    deptId = json['deptId'];
    followStatusStr = json['followStatusStr'];
    turnCustTime = json['turnCustTime'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clueNo'] = this.clueNo;
    data['followId'] = this.followId;
    data['followStatus'] = this.followStatus;
    data['clueName'] = this.clueName;
    data['post'] = this.post;
    data['corporateName'] = this.corporateName;
    data['telephone'] = this.telephone;
    data['mobilePhone'] = this.mobilePhone;
    data['mailBox'] = this.mailBox;
    data['clueSource'] = this.clueSource;
    data['clueturnStatus'] = this.clueturnStatus;
    data['owners'] = this.owners;
    data['ownersDept'] = this.ownersDept;
    data['ownersDeptName'] = this.ownersDeptName;
    data['oldOwners'] = this.oldOwners;
    data['oldOwnersDept'] = this.oldOwnersDept;
    data['oldOwnersDeptName'] = this.oldOwnersDeptName;
    data['wechatNumber'] = this.wechatNumber;
    data['qqNumber'] = this.qqNumber;
    data['nextFollowTime'] = this.nextFollowTime;
    data['address'] = this.address;
    data['hobby'] = this.hobby;
    data['createTime'] = this.createTime;
    data['createBy'] = this.createBy;
    data['createName'] = this.createName;
    data['updateTime'] = this.updateTime;
    data['updateBy'] = this.updateBy;
    data['remarks'] = this.remarks;
    data['delFlag'] = this.delFlag;
    data['deptId'] = this.deptId;
    data['followStatusStr'] = this.followStatusStr;
    data['turnCustTime'] = this.turnCustTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}



class ThreadList{
  int total=0;
  List<ThreadModel> list;
  ThreadList({this.total,this.list});
}