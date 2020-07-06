import 'package:cloundapp/model/crm/BaseClass.dart';

class BusinessModel extends BaseClass{
  String id;
  String client;
  String clientName;
  double amount;
  String issueDate;
  String getDate;
  String type;
  String followStatus;
  String oppoNo;
  String oppoName;
  String oppoSource;
  String nextFollowTime;
  String turnStatus;
  String oldOwners;
  String oldDept;
  String owners;
  String ownersDept;
  String ownersName;
  String deptName;
  String createBy;
  String createTime;
  String updateTime;
  String delFlag;
  String remarks;
  String tenantId;
  String productData;

  BusinessModel(
      {this.id,
        this.client,
        this.clientName,
        this.amount,
        this.issueDate,
        this.getDate,
        this.type,
        this.followStatus,
        this.oppoNo,
        this.oppoName,
        this.oppoSource,
        this.nextFollowTime,
        this.turnStatus,
        this.oldOwners,
        this.oldDept,
        this.owners,
        this.ownersDept,
        this.ownersName,
        this.deptName,
        this.createBy,
        this.createTime,
        this.updateTime,
        this.delFlag,
        this.remarks,
        this.tenantId,
        this.productData});

  BusinessModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    clientName = json['clientName'];
    amount = json['amount'];
    issueDate = json['issueDate'];
    getDate = json['getDate'];
    type = json['type'];
    followStatus = json['followStatus'];
    oppoNo = json['oppoNo'];
    oppoName = json['oppoName'];
    oppoSource = json['oppoSource'];
    nextFollowTime = json['nextFollowTime'];
    turnStatus = json['turnStatus'];
    oldOwners = json['oldOwners'];
    oldDept = json['oldDept'];
    owners = json['owners'];
    ownersDept = json['ownersDept'];
    ownersName = json['ownersName'];
    deptName = json['deptName'];
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
    data['amount'] = this.amount;
    data['issueDate'] = this.issueDate;
    data['getDate'] = this.getDate;
    data['type'] = this.type;
    data['followStatus'] = this.followStatus;
    data['oppoNo'] = this.oppoNo;
    data['oppoName'] = this.oppoName;
    data['oppoSource'] = this.oppoSource;
    data['nextFollowTime'] = this.nextFollowTime;
    data['turnStatus'] = this.turnStatus;
    data['oldOwners'] = this.oldOwners;
    data['oldDept'] = this.oldDept;
    data['owners'] = this.owners;
    data['ownersDept'] = this.ownersDept;
    data['ownersName'] = this.ownersName;
    data['deptName'] = this.deptName;
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


class BusinessList{
  int total=0;
  List<BusinessModel> list;
  BusinessList({this.total,this.list});
}


class BusinessListModel {
  int allNum;//全部数量
  int winNum;//赢单数量
  int loseNum;//输单数量
  int approachlNum;//初步接洽数量
  int confirmNum;//需求确定数量
  int offerNum;//方案/报价数量
  int contractNum;//谈判/合同数量
  List<BusinessModel> opportunityList;

  BusinessListModel(
      {this.allNum,
        this.winNum,
        this.loseNum,
        this.approachlNum,
        this.confirmNum,
        this.offerNum,
        this.contractNum,
        this.opportunityList});

  BusinessListModel.fromJson(Map<String, dynamic> json) {
    allNum = json['allNum'];
    winNum = json['winNum'];
    loseNum = json['loseNum'];
    approachlNum = json['approachlNum'];
    confirmNum = json['confirmNum'];
    offerNum = json['offerNum'];
    contractNum = json['contractNum'];
    if (json['opportunityList'] != null) {
      opportunityList = new List<BusinessModel>();
      json['opportunityList'].forEach((v) {
        opportunityList.add(new BusinessModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allNum'] = this.allNum;
    data['winNum'] = this.winNum;
    data['loseNum'] = this.loseNum;
    data['approachlNum'] = this.approachlNum;
    data['confirmNum'] = this.confirmNum;
    data['offerNum'] = this.offerNum;
    data['contractNum'] = this.contractNum;
    if (this.opportunityList != null) {
      data['opportunityList'] =
          this.opportunityList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Business{
  String client;
  String oppoName;
  String amount;
  String issueDate;
  String followStatus;
  String access_token;
  String remarks;
  String owners;
  String ownersDept;
  List productData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client'] = this.client;
    data['oppoName'] = this.oppoName;
    data['amount'] = this.amount;
    data['issueDate'] = this.issueDate;
    data['followStatus'] = this.followStatus;
    data['access_token'] = this.access_token;
    data['remarks'] = this.remarks;
    data['owners'] = this.owners;
    data['ownersDept'] = this.ownersDept;
    data['productData'] = this.productData;

    return data;
  }

  Business.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    oppoName = json['oppoName'];
    amount = json['amount'];
    issueDate = json['issueDate'];
    followStatus = json['followStatus'];
    access_token = json['access_token'];
    remarks = json['remarks'];
    owners = json['owners'];
    ownersDept = json['ownersDept'];
    productData = json['productData'];
  }
}