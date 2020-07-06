import 'package:cloundapp/model/crm/BaseClass.dart';

class ContactListModel {
  int total;
  List<ContactModel> data;

  ContactListModel({this.total, this.data});

  ContactListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<ContactModel>();
      json['data'].forEach((v) {
        data.add(new ContactModel.fromJson(v));
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

class ContactModel {
  String id;
  String typeId;
  String name;
  String title;
  String sex;
  String tel;
  String phone;
  String mail;
  String wechat;
  String remark;
  String createTime;
  String updateTime;
  String delFlag;
  String tenantId;

  ContactModel(
      {this.id,
        this.typeId,
        this.name,
        this.title,
        this.sex,
        this.tel,
        this.phone,
        this.mail,
        this.wechat,
        this.remark,
        this.createTime,
        this.updateTime,
        this.delFlag,
        this.tenantId});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['typeId'];
    name = json['name'];
    title = json['title'];
    sex = json['sex'];
    tel = json['tel'];
    phone = json['phone'];
    mail = json['mail'];
    wechat = json['wechat'];
    remark = json['remark'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    delFlag = json['delFlag'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeId'] = this.typeId;
    data['name'] = this.name;
    data['title'] = this.title;
    data['sex'] = this.sex;
    data['tel'] = this.tel;
    data['phone'] = this.phone;
    data['mail'] = this.mail;
    data['wechat'] = this.wechat;
    data['remark'] = this.remark;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['delFlag'] = this.delFlag;
    data['tenantId'] = this.tenantId;
    return data;
  }
}

class ContactTypeModel extends BaseContact {
  var id;
  var name;
  var depict;
  var stat;
  var orderNum;
  var users;
  var createTime;
  var updateTime;
  var delFlag;
  var tenantId;

  ContactTypeModel(
      {this.id,
        this.name,
        this.depict,
        this.stat,
        this.orderNum,
        this.users,
        this.createTime,
        this.updateTime,
        this.delFlag,
        this.tenantId});

  ContactTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    depict = json['depict'];
    stat = json['stat'];
    orderNum = json['orderNum'];
    users = json['users'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    delFlag = json['delFlag'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['depict'] = this.depict;
    data['stat'] = this.stat;
    data['orderNum'] = this.orderNum;
    data['users'] = this.users;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['delFlag'] = this.delFlag;
    data['tenantId'] = this.tenantId;
    return data;
  }
}