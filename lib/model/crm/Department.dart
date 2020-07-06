import 'package:cloundapp/model/crm/BaseClass.dart';
class Department extends BaseContact {
  int deptId;
  int parentId;
  String ancestors;
  String deptName;
  String orderNum;
  String leader;
  String phone;
  String email;
  String status;
  String delFlag;
  String createBy;
  String createTime;
  String parentName;
  String tenantId;

  Department(
      {this.deptId,
        this.parentId,
        this.ancestors,
        this.deptName,
        this.orderNum,
        this.leader,
        this.phone,
        this.email,
        this.status,
        this.delFlag,
        this.createBy,
        this.createTime,
        this.parentName,
        this.tenantId});

  Department.fromJson(Map<String, dynamic> json) {
    deptId = json['deptId'];
    parentId = json['parentId'];
    ancestors = json['ancestors'];
    deptName = json['deptName'];
    orderNum = json['orderNum'];
    leader = json['leader'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    delFlag = json['delFlag'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    parentName = json['parentName'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deptId'] = this.deptId;
    data['parentId'] = this.parentId;
    data['ancestors'] = this.ancestors;
    data['deptName'] = this.deptName;
    data['orderNum'] = this.orderNum;
    data['leader'] = this.leader;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['delFlag'] = this.delFlag;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['parentName'] = this.parentName;
    data['tenantId'] = this.tenantId;
    return data;
  }

}
