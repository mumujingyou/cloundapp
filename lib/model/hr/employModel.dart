class EmployModelList {
  int total;
  List<EmployModel> data;

  EmployModelList({this.total, this.data});

  EmployModelList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<EmployModel>();
      json['data'].forEach((v) {
        data.add(new EmployModel.fromJson(v));
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

class EmployModel {
  String id;
  String name;
  String employ;
  String deptId;
  String dept;
  int number;
  String city;
  String status;
  String remarks;
  String createBy;
  String createTime;
  String updateTime;
  String tenantId;
  String urgent;

  EmployModel(
      {this.id,
        this.name,
        this.employ,
        this.deptId,
        this.dept,
        this.number,
        this.city,
        this.status,
        this.remarks,
        this.createBy,
        this.createTime,
        this.updateTime,
        this.tenantId,
        this.urgent});

  EmployModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    employ = json['employ'];
    deptId = json['deptId'];
    dept = json['dept'];
    number = json['number'];
    city = json['city'];
    status = json['status'];
    remarks = json['remarks'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    tenantId = json['tenantId'];
    urgent = json['urgent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['employ'] = this.employ;
    data['deptId'] = this.deptId;
    data['dept'] = this.dept;
    data['number'] = this.number;
    data['city'] = this.city;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['tenantId'] = this.tenantId;
    data['urgent'] = this.urgent;
    return data;
  }
}