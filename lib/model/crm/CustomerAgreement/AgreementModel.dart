class CustomerAgreementModel {
  String id;
  String client;
  String clientName;
  String opportunity;
  String oppoName;
  double amount;
  String backAmount;
  String unBackAmount;
  String invoiceAmount;
  String unInvoiceAmount;
  String startDate;
  String endDate;
  String contractDate;
  String ourSigner;
  String customerSigner;
  String type;
  String followStatus;
  String contractNo;
  String contractual;
  String ctNo;
  String contractName;
  String payWay;
  String nextFollowTime;
  String approveStatus;
  String approveTime;
  String approveFinishTime;
  String oldOwners;
  String oldDept;
  String owners;
  String ownersid;
  String ownersDept;
  String createBy;
  String createTime;
  String updateTime;
  String delFlag;
  String remarks;
  String tenantId;
  String productData;

  CustomerAgreementModel(
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

  CustomerAgreementModel.fromJson(Map<String, dynamic> json) {
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

class AgreementList{
  int total=0;
  List<CustomerAgreementModel> list;
  AgreementList({this.total,this.list});
}