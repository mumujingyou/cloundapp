class SupplyListModel {
  int total;
  List<SuppliesApply> data;

  SupplyListModel({this.total, this.data});

  SupplyListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<SuppliesApply>();
      json['data'].forEach((v) {
        data.add(new SuppliesApply.fromJson(v));
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

class SuppliesApply {
  String id;
  String busNo;
  String priority;
  String title;
  String deptId;
  String deptName;
  String beginDate;
  String endDate;
  String participant;
  String principalId;
  String principal;
  String content;
  String opinion;
  String remarks;
  String status;
  String createName;
  String createBy;
  String createTime;
  String tenantId;
  int amount;

  SuppliesApply(
      {this.id,
        this.busNo,
        this.priority,
        this.title,
        this.deptId,
        this.deptName,
        this.beginDate,
        this.endDate,
        this.participant,
        this.principalId,
        this.principal,
        this.content,
        this.opinion,
        this.remarks,
        this.status,
        this.createName,
        this.createBy,
        this.createTime,
        this.tenantId,
        this.amount});

  SuppliesApply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busNo = json['busNo'];
    priority = json['priority'];
    title = json['title'];
    deptId = json['deptId'];
    deptName = json['deptName'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    participant = json['participant'];
    principalId = json['principalId'];
    principal = json['principal'];
    content = json['content'];
    opinion = json['opinion'];
    remarks = json['remarks'];
    status = json['status'];
    createName = json['createName'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    tenantId = json['tenantId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['busNo'] = this.busNo;
    data['priority'] = this.priority;
    data['title'] = this.title;
    data['deptId'] = this.deptId;
    data['deptName'] = this.deptName;
    data['beginDate'] = this.beginDate;
    data['endDate'] = this.endDate;
    data['participant'] = this.participant;
    data['principalId'] = this.principalId;
    data['principal'] = this.principal;
    data['content'] = this.content;
    data['opinion'] = this.opinion;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['createName'] = this.createName;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    data['amount'] = this.amount;
    return data;
  }
}


class SupplyApplyDetail {
  SuppliesApply suppliesApply;
  List<SuppliesApplyItem> suppliesApplyItems;
  var saInfoProcessList;

  SupplyApplyDetail({this.suppliesApply, this.suppliesApplyItems, this.saInfoProcessList});

  SupplyApplyDetail.fromJson(Map<String, dynamic> json) {
    suppliesApply = json['suppliesApply'] != null
        ? new SuppliesApply.fromJson(json['suppliesApply'])
        : null;
    if (json['suppliesApplyItems'] != null) {
      suppliesApplyItems = new List<SuppliesApplyItem>();
      json['suppliesApplyItems'].forEach((v) {
        suppliesApplyItems.add(new SuppliesApplyItem.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suppliesApply != null) {
      data['suppliesApply'] = this.suppliesApply.toJson();
    }
    if (this.suppliesApplyItems != null) {
      data['suppliesApplyItems'] =
          this.suppliesApplyItems.map((v) => v.toJson()).toList();
    }
    if (this.saInfoProcessList != null) {
      data['saInfoProcessList'] =
          this.saInfoProcessList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class SuppliesApplyItem {
  String id;
  String saId;
  String suppliesId;
  String suppliesName;
  String norms;
  int quantity;
  int amount;
  String remarks;
  String createTime;
  String tenantId;

  SuppliesApplyItem(
      {this.id,
        this.saId,
        this.suppliesId,
        this.suppliesName,
        this.norms,
        this.quantity,
        this.amount,
        this.remarks,
        this.createTime,
        this.tenantId});

  SuppliesApplyItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saId = json['saId'];
    suppliesId = json['suppliesId'];
    suppliesName = json['suppliesName'];
    norms = json['norms'];
    quantity = json['quantity'];
    amount = json['amount'];
    remarks = json['remarks'];
    createTime = json['createTime'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['saId'] = this.saId;
    data['suppliesId'] = this.suppliesId;
    data['suppliesName'] = this.suppliesName;
    data['norms'] = this.norms;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['remarks'] = this.remarks;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}


class SupplyProductListModel {
  int total;
  List<SupplyProduct> data;

  SupplyProductListModel({this.total, this.data});

  SupplyProductListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<SupplyProduct>();
      json['data'].forEach((v) {
        data.add(new SupplyProduct.fromJson(v));
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

class SupplyProduct {
  String id;
  String suppliesName;
  String suppliesType;
  String suppliesNo;
  String norms;
  String unit;
  int initialQuantity;
  int quantity;
  String deposit;
  String managerId;
  String remarks;
  String createBy;
  String createTime;
  int delFlag;
  String tenantId;

  SupplyProduct(
      {this.id,
        this.suppliesName,
        this.suppliesType,
        this.suppliesNo,
        this.norms,
        this.unit,
        this.initialQuantity,
        this.quantity,
        this.deposit,
        this.managerId,
        this.remarks,
        this.createBy,
        this.createTime,
        this.delFlag,
        this.tenantId});

  SupplyProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suppliesName = json['suppliesName'];
    suppliesType = json['suppliesType'];
    suppliesNo = json['suppliesNo'];
    norms = json['norms'];
    unit = json['unit'];
    initialQuantity = json['initialQuantity'];
    quantity = json['quantity'];
    deposit = json['deposit'];
    managerId = json['managerId'];
    remarks = json['remarks'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    delFlag = json['delFlag'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suppliesName'] = this.suppliesName;
    data['suppliesType'] = this.suppliesType;
    data['suppliesNo'] = this.suppliesNo;
    data['norms'] = this.norms;
    data['unit'] = this.unit;
    data['initialQuantity'] = this.initialQuantity;
    data['quantity'] = this.quantity;
    data['deposit'] = this.deposit;
    data['managerId'] = this.managerId;
    data['remarks'] = this.remarks;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['delFlag'] = this.delFlag;
    data['tenantId'] = this.tenantId;
    return data;
  }
}