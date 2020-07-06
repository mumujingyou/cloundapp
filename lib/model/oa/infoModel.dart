class WorkInfoListModel {
  int total;
  List<WorkInfo> data;

  WorkInfoListModel({this.total, this.data});

  WorkInfoListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<WorkInfo>();
      json['data'].forEach((v) {
        data.add(new WorkInfo.fromJson(v));
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

class WorkInfo {//工作报告
  String id;
  String busNo;
  String priority;
  String wpType;
  String parentId;
  String parentTitle;
  String title;
  String deptId;
  String deptName;
  String participant;
  String approvalId;
  String approvalBy;
  String content;
  String opinion;
  String status;
  String createName;
  String createBy;
  String createTime;
  String tenantId;

  WorkInfo(
      {this.id,
        this.busNo,
        this.priority,
        this.wpType,
        this.parentId,
        this.parentTitle,
        this.title,
        this.deptId,
        this.deptName,
        this.participant,
        this.approvalId,
        this.approvalBy,
        this.content,
        this.opinion,
        this.status,
        this.createName,
        this.createBy,
        this.createTime,
        this.tenantId});

  WorkInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busNo = json['busNo'];
    priority = json['priority'];
    wpType = json['wpType'];
    parentId = json['parentId'];
    parentTitle = json['parentTitle'];
    title = json['title'];
    deptId = json['deptId'];
    deptName = json['deptName'];
    participant = json['participant'];
    approvalId = json['approvalId'];
    approvalBy = json['approvalBy'];
    content = json['content'];
    opinion = json['opinion'];
    status = json['status'];
    createName = json['createName'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['busNo'] = this.busNo;
    data['priority'] = this.priority;
    data['wpType'] = this.wpType;
    data['parentId'] = this.parentId;
    data['parentTitle'] = this.parentTitle;
    data['title'] = this.title;
    data['deptId'] = this.deptId;
    data['deptName'] = this.deptName;
    data['participant'] = this.participant;
    data['approvalId'] = this.approvalId;
    data['approvalBy'] = this.approvalBy;
    data['content'] = this.content;
    data['opinion'] = this.opinion;
    data['status'] = this.status;
    data['createName'] = this.createName;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}

class WorkInfoDetail {
  WorkInfo workInfo;
  List<InfoNode> wppList;
  var workInfoParent;
  var workInfoChildList;

  WorkInfoDetail(
      {this.workInfo,
        this.wppList,
        this.workInfoParent,
        this.workInfoChildList});

  WorkInfoDetail.fromJson(Map<String, dynamic> json) {
    workInfo = json['workInfo'] != null
        ? new WorkInfo.fromJson(json['workInfo'])
        : null;
    if (json['wppList'] != null) {
      wppList = new List<InfoNode>();
      json['wppList'].forEach((v) {
        wppList.add(new InfoNode.fromJson(v));
      });
    }
    workInfoParent = json['workInfoParent'];
    workInfoChildList = json['workInfoChildList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workInfo != null) {
      data['workInfo'] = this.workInfo.toJson();
    }
    if (this.wppList != null) {
      data['wppList'] = this.wppList.map((v) => v.toJson()).toList();
    }
    data['workInfoParent'] = this.workInfoParent;
    data['workInfoChildList'] = this.workInfoChildList;
    return data;
  }
}


class InfoNode {
  String id;
  String wpId;
  String title;
  String opinion;
  String action;
  String actionTime;
  String tenantId;

  InfoNode(
      {this.id,
        this.wpId,
        this.title,
        this.opinion,
        this.action,
        this.actionTime,
        this.tenantId});

  InfoNode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wpId = json['wpId'];
    title = json['title'];
    opinion = json['opinion'];
    action = json['action'];
    actionTime = json['actionTime'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wpId'] = this.wpId;
    data['title'] = this.title;
    data['opinion'] = this.opinion;
    data['action'] = this.action;
    data['actionTime'] = this.actionTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}