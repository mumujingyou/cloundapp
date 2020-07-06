import 'package:cloundapp/model/crm/BaseClass.dart';

class AgreementModelList {
  int total;
  List<AgreementModel> data;

  AgreementModelList({this.total, this.data});

  AgreementModelList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<AgreementModel>();
      json['data'].forEach((v) {
        data.add(new AgreementModel.fromJson(v));
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

class AgreementModel  extends BaseClass{
  var id;
  var client;
  var clientName;
  var opportunity;
  var oppoName;
  var amount;
  var backAmount;
  var unBackAmount;
  var invoiceAmount;
  var unInvoiceAmount;
  var startDate;
  var endDate;
  var contractDate;
  var ourSigner;
  var customerSigner;
  var type;
  var followStatus;
  var contractNo;
  var contractual;
  var ctNo;
  var contractName;
  var payWay;
  var nextFollowTime;
  var approveStatus;
  var approveTime;
  var approveFinishTime;
  var oldOwners;
  var oldDept;
  var owners;
  var ownersid;
  var ownersDept;
  var createBy;
  var createTime;
  var updateTime;
  var delFlag;
  var remarks;
  var tenantId;
  var productData;

  AgreementModel(
      {this.id,
        this.client,
        this.clientName,
        this.opportunity,
        this.oppoName,
        this.amount,
        this.backAmount,
        this.unBackAmount,
        this.invoiceAmount,
        this.unInvoiceAmount,
        this.startDate,
        this.endDate,
        this.contractDate,
        this.ourSigner,
        this.customerSigner,
        this.type,
        this.followStatus,
        this.contractNo,
        this.contractual,
        this.ctNo,
        this.contractName,
        this.payWay,
        this.nextFollowTime,
        this.approveStatus,
        this.approveTime,
        this.approveFinishTime,
        this.oldOwners,
        this.oldDept,
        this.owners,
        this.ownersid,
        this.ownersDept,
        this.createBy,
        this.createTime,
        this.updateTime,
        this.delFlag,
        this.remarks,
        this.tenantId,
        this.productData});

  AgreementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    clientName = json['clientName'];
    opportunity = json['opportunity'];
    oppoName = json['oppoName'];
    amount = json['amount'];
    backAmount = json['backAmount'];
    unBackAmount = json['unBackAmount'];
    invoiceAmount = json['invoiceAmount'];
    unInvoiceAmount = json['unInvoiceAmount'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    contractDate = json['contractDate'];
    ourSigner = json['ourSigner'];
    customerSigner = json['customerSigner'];
    type = json['type'];
    followStatus = json['followStatus'];
    contractNo = json['contractNo'];
    contractual = json['contractual'];
    ctNo = json['ctNo'];
    contractName = json['contractName'];
    payWay = json['payWay'];
    nextFollowTime = json['nextFollowTime'];
    approveStatus = json['approveStatus'];
    approveTime = json['approveTime'];
    approveFinishTime = json['approveFinishTime'];
    oldOwners = json['oldOwners'];
    oldDept = json['oldDept'];
    owners = json['owners'];
    ownersid = json['ownersid'];
    ownersDept = json['ownersDept'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    delFlag = json['delFlag'];
    remarks = json['remarks'];
    tenantId = json['tenantId'];
    productData = json['productData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client'] = this.client;
    data['clientName'] = this.clientName;
    data['opportunity'] = this.opportunity;
    data['oppoName'] = this.oppoName;
    data['amount'] = this.amount;
    data['backAmount'] = this.backAmount;
    data['unBackAmount'] = this.unBackAmount;
    data['invoiceAmount'] = this.invoiceAmount;
    data['unInvoiceAmount'] = this.unInvoiceAmount;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['contractDate'] = this.contractDate;
    data['ourSigner'] = this.ourSigner;
    data['customerSigner'] = this.customerSigner;
    data['type'] = this.type;
    data['followStatus'] = this.followStatus;
    data['contractNo'] = this.contractNo;
    data['contractual'] = this.contractual;
    data['ctNo'] = this.ctNo;
    data['contractName'] = this.contractName;
    data['payWay'] = this.payWay;
    data['nextFollowTime'] = this.nextFollowTime;
    data['approveStatus'] = this.approveStatus;
    data['approveTime'] = this.approveTime;
    data['approveFinishTime'] = this.approveFinishTime;
    data['oldOwners'] = this.oldOwners;
    data['oldDept'] = this.oldDept;
    data['owners'] = this.owners;
    data['ownersid'] = this.ownersid;
    data['ownersDept'] = this.ownersDept;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['delFlag'] = this.delFlag;
    data['remarks'] = this.remarks;
    data['tenantId'] = this.tenantId;
    data['productData'] = this.productData;
    return data;
  }
}