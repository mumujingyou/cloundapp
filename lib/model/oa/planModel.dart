class PlanModelList {
  int total;
  List<WorkPlan> data;

  PlanModelList({this.total, this.data});

  PlanModelList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<WorkPlan>();
      json['data'].forEach((v) {
        data.add(new WorkPlan.fromJson(v));
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

class WorkPlan {
  String id;
  String busNo;
  String priority;
  String wpType;
  String parentId;
  String parentTitle;
  String title;
  String deptId;
  String deptName;
  String beginDate;
  String endDate;
  String participant;
  String approvalId;
  String approvalBy;
  String executeId;
  String executeBy;
  String content;
  String opinion;
  String status;
  String createName;
  String createBy;
  String createTime;
  String tenantId;

  WorkPlan(
      {this.id,
        this.busNo,
        this.priority,
        this.wpType,
        this.parentId,
        this.parentTitle,
        this.title,
        this.deptId,
        this.deptName,
        this.beginDate,
        this.endDate,
        this.participant,
        this.approvalId,
        this.approvalBy,
        this.executeId,
        this.executeBy,
        this.content,
        this.opinion,
        this.status,
        this.createName,
        this.createBy,
        this.createTime,
        this.tenantId});

  WorkPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busNo = json['busNo'];
    priority = json['priority'];
    wpType = json['wpType'];
    parentId = json['parentId'];
    parentTitle = json['parentTitle'];
    title = json['title'];
    deptId = json['deptId'];
    deptName = json['deptName'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    participant = json['participant'];
    approvalId = json['approvalId'];
    approvalBy = json['approvalBy'];
    executeId = json['executeId'];
    executeBy = json['executeBy'];
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
    data['beginDate'] = this.beginDate;
    data['endDate'] = this.endDate;
    data['participant'] = this.participant;
    data['approvalId'] = this.approvalId;
    data['approvalBy'] = this.approvalBy;
    data['executeId'] = this.executeId;
    data['executeBy'] = this.executeBy;
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



class WorkPlanDetail {
  WorkPlan workPlan;
  List<PlanNode> wppList;
  var workPlanParent;
  var workPlanChildList;

  WorkPlanDetail(
      {this.workPlan,
        this.wppList,
        this.workPlanParent,
        this.workPlanChildList});

  WorkPlanDetail.fromJson(Map<String, dynamic> json) {
    workPlan = json['workPlan'] != null
        ? new WorkPlan.fromJson(json['workPlan'])
        : null;
    if (json['wppList'] != null) {
      wppList = new List<PlanNode>();
      json['wppList'].forEach((v) {
        wppList.add(new PlanNode.fromJson(v));
      });
    }
    workPlanParent = json['workPlanParent'];
    workPlanChildList = json['workPlanChildList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workPlan != null) {
      data['workPlan'] = this.workPlan.toJson();
    }
    if (this.wppList != null) {
      data['wppList'] = this.wppList.map((v) => v.toJson()).toList();
    }
    data['workPlanParent'] = this.workPlanParent;
    data['workPlanChildList'] = this.workPlanChildList;
    return data;
  }
}



class PlanNode {
  String id;
  String wpId;
  String title;
  String opinion;
  String action;
  String actionTime;
  String tenantId;

  PlanNode(
      {this.id,
        this.wpId,
        this.title,
        this.opinion,
        this.action,
        this.actionTime,
        this.tenantId});

  PlanNode.fromJson(Map<String, dynamic> json) {
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