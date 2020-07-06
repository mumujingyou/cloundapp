import 'package:cloundapp/model/crm/BaseClass.dart';

class CustomerModel extends BaseClass {
  String id;
  String highSeasId;
  int isRemoveHighSeas;
  String followId;
  String clueId;
  String customerNo;
  String tel;
  String phone;
  String fax;
  String website;
  String corporateName;
  String customerName;
  String contactName;
  String qq;
  String wechat;
  String mail;
  String address;
  int customerType;
  int followStatus;
  String hobby;
  int scale;
  int customerSource;
  String nextFollowTime;
  String oldOwners;
  String oldDept;
  String owners;
  String dept;
  String ownersName;
  String oldDeptName;
  String oldOwnersName;
  String deptName;
  String createBy;
  String createTime;
  String updateTime;
  String turnTime;
  int delFlag;
  String remarks;
  String post;
  String tenantId;
  String isMyOwner;

  CustomerModel(
      {this.id,
        this.highSeasId,
        this.isRemoveHighSeas,
        this.followId,
        this.clueId,
        this.customerNo,
        this.tel,
        this.phone,
        this.fax,
        this.website,
        this.corporateName,
        this.customerName,
        this.contactName,
        this.qq,
        this.wechat,
        this.mail,
        this.address,
        this.customerType,
        this.followStatus,
        this.hobby,
        this.scale,
        this.customerSource,
        this.nextFollowTime,
        this.oldOwners,
        this.oldDept,
        this.owners,
        this.dept,
        this.ownersName,
        this.oldDeptName,
        this.oldOwnersName,
        this.deptName,
        this.createBy,
        this.createTime,
        this.updateTime,
        this.turnTime,
        this.delFlag,
        this.remarks,
        this.post,
        this.tenantId,
        this.isMyOwner});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    highSeasId = json['highSeasId'];
    isRemoveHighSeas = json['isRemoveHighSeas'];
    followId = json['followId'];
    clueId = json['clueId'];
    customerNo = json['customerNo'];
    tel = json['tel'];
    phone = json['phone'];
    fax = json['fax'];
    website = json['website'];
    corporateName = json['corporateName'];
    customerName = json['customerName'];
    contactName = json['contactName'];
    qq = json['qq'];
    wechat = json['wechat'];
    mail = json['mail'];
    address = json['address'];
    customerType = json['customerType'];
    followStatus = json['followStatus'];
    hobby = json['hobby'];
    scale = json['scale'];
    customerSource = json['customerSource'];
    nextFollowTime = json['nextFollowTime'];
    oldOwners = json['oldOwners'];
    oldDept = json['oldDept'];
    owners = json['owners'];
    dept = json['dept'];
    ownersName = json['ownersName'];
    oldDeptName = json['oldDeptName'];
    oldOwnersName = json['oldOwnersName'];
    deptName = json['deptName'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    turnTime = json['turnTime'];
    delFlag = json['delFlag'];
    remarks = json['remarks'];
    post = json['post'];
    tenantId = json['tenantId'];
    isMyOwner = json['isMyOwner'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['highSeasId'] = this.highSeasId;
    data['isRemoveHighSeas'] = this.isRemoveHighSeas;
    data['followId'] = this.followId;
    data['clueId'] = this.clueId;
    data['customerNo'] = this.customerNo;
    data['tel'] = this.tel;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['website'] = this.website;
    data['corporateName'] = this.corporateName;
    data['customerName'] = this.customerName;
    data['contactName'] = this.contactName;
    data['qq'] = this.qq;
    data['wechat'] = this.wechat;
    data['mail'] = this.mail;
    data['address'] = this.address;
    data['customerType'] = this.customerType;
    data['followStatus'] = this.followStatus;
    data['hobby'] = this.hobby;
    data['scale'] = this.scale;
    data['customerSource'] = this.customerSource;
    data['nextFollowTime'] = this.nextFollowTime;
    data['oldOwners'] = this.oldOwners;
    data['oldDept'] = this.oldDept;
    data['owners'] = this.owners;
    data['dept'] = this.dept;
    data['ownersName'] = this.ownersName;
    data['oldDeptName'] = this.oldDeptName;
    data['oldOwnersName'] = this.oldOwnersName;
    data['deptName'] = this.deptName;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['turnTime'] = this.turnTime;
    data['delFlag'] = this.delFlag;
    data['remarks'] = this.remarks;
    data['post'] = this.post;
    data['tenantId'] = this.tenantId;
    data['isMyOwner'] = this.isMyOwner;
    return data;
  }
}

class CustomerList{
  int total=0;
  List<CustomerModel> list;
  CustomerList({this.total,this.list});
}


