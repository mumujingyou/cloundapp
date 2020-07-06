class CapitalListModel {
  int total;
  List<CapitalApply> data;

  CapitalListModel({this.total, this.data});

  CapitalListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<CapitalApply>();
      json['data'].forEach((v) {
        data.add(new CapitalApply.fromJson(v));
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

class CapitalApply {
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

  CapitalApply({this.id,
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

  CapitalApply.fromJson(Map<String, dynamic> json) {
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


class CapitalApplyDetail {
  CapitalApply capitalApply;
  List<CapitalApplyItem> capitalApplyItems;
  var caInfoProcessList;

  CapitalApplyDetail({this.capitalApply, this.capitalApplyItems, this.caInfoProcessList});

  CapitalApplyDetail.fromJson(Map<String, dynamic> json) {
    capitalApply = json['capitalApply'] != null
        ? new CapitalApply.fromJson(json['capitalApply'])
        : null;
    if (json['capitalApplyItems'] != null) {
      capitalApplyItems = new List<CapitalApplyItem>();
      json['capitalApplyItems'].forEach((v) {
        capitalApplyItems.add(new CapitalApplyItem.fromJson(v));
      });
    }
    caInfoProcessList = json['caInfoProcessList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.capitalApply != null) {
      data['capitalApply'] = this.capitalApply.toJson();
    }
    if (this.capitalApplyItems != null) {
      data['capitalApplyItems'] =
          this.capitalApplyItems.map((v) => v.toJson()).toList();
    }
    data['caInfoProcessList'] = this.caInfoProcessList;
    return data;
  }
}



class CapitalApplyItem {
  String id;
  String caId;
  String capitalId;
  String capitalName;
  String capitalNo;
  String norms;
  String recipient;
  String recipientId;
  String createTime;
  String tenantId;

  CapitalApplyItem(
      {this.id,
        this.caId,
        this.capitalId,
        this.capitalName,
        this.capitalNo,
        this.norms,
        this.recipient,
        this.recipientId,
        this.createTime,
        this.tenantId});

  CapitalApplyItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caId = json['caId'];
    capitalId = json['capitalId'];
    capitalName = json['capitalName'];
    capitalNo = json['capitalNo'];
    norms = json['norms'];
    recipient = json['recipient'];
    recipientId = json['recipientId'];
    createTime = json['createTime'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['caId'] = this.caId;
    data['capitalId'] = this.capitalId;
    data['capitalName'] = this.capitalName;
    data['capitalNo'] = this.capitalNo;
    data['norms'] = this.norms;
    data['recipient'] = this.recipient;
    data['recipientId'] = this.recipientId;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}

class CapitalProductListModel {
  int total;
  List<CapitalProduct> data;

  CapitalProductListModel({this.total, this.data});

  CapitalProductListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<CapitalProduct>();
      json['data'].forEach((v) {
        data.add(new CapitalProduct.fromJson(v));
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

class CapitalProduct {
  String id;
  String capitalName;
  String capitalType;
  String norms;
  String capitalNo;
  String capitalSource;
  double price;
  String producer;
  String productTime;
  String supplier;
  String purchaseTime;
  String deposit;
  String underGuaranteeTime;
  String receiveId;
  String managerId;
  int status;
  String remarks;
  String createBy;
  String createTime;
  int delFlag;
  String tenantId;

  CapitalProduct(
      {this.id,
        this.capitalName,
        this.capitalType,
        this.norms,
        this.capitalNo,
        this.capitalSource,
        this.price,
        this.producer,
        this.productTime,
        this.supplier,
        this.purchaseTime,
        this.deposit,
        this.underGuaranteeTime,
        this.receiveId,
        this.managerId,
        this.status,
        this.remarks,
        this.createBy,
        this.createTime,
        this.delFlag,
        this.tenantId});

  CapitalProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    capitalName = json['capitalName'];
    capitalType = json['capitalType'];
    norms = json['norms'];
    capitalNo = json['capitalNo'];
    capitalSource = json['capitalSource'];
    price = json['price'];
    producer = json['producer'];
    productTime = json['productTime'];
    supplier = json['supplier'];
    purchaseTime = json['purchaseTime'];
    deposit = json['deposit'];
    underGuaranteeTime = json['underGuaranteeTime'];
    receiveId = json['receiveId'];
    managerId = json['managerId'];
    status = json['status'];
    remarks = json['remarks'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    delFlag = json['delFlag'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['capitalName'] = this.capitalName;
    data['capitalType'] = this.capitalType;
    data['norms'] = this.norms;
    data['capitalNo'] = this.capitalNo;
    data['capitalSource'] = this.capitalSource;
    data['price'] = this.price;
    data['producer'] = this.producer;
    data['productTime'] = this.productTime;
    data['supplier'] = this.supplier;
    data['purchaseTime'] = this.purchaseTime;
    data['deposit'] = this.deposit;
    data['underGuaranteeTime'] = this.underGuaranteeTime;
    data['receiveId'] = this.receiveId;
    data['managerId'] = this.managerId;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['delFlag'] = this.delFlag;
    data['tenantId'] = this.tenantId;
    return data;
  }
}
