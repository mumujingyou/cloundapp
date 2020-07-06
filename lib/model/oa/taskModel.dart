class WorkTaskListModel {
  int total;
  List<WorkTask> data;

  WorkTaskListModel({this.total, this.data});

  WorkTaskListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<WorkTask>();
      json['data'].forEach((v) {
        data.add(new WorkTask.fromJson(v));
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

class WorkTask {
  String id;
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
  String executeId;
  String executeBy;
  String abWork;
  String acWork;
  String missionNo;
  String mission;
  String resultsNo;
  String results;
  String opinion;
  String status;
  String createName;
  String createBy;
  String createTime;
  String tenantId;

  WorkTask(
      {this.id,
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
        this.executeId,
        this.executeBy,
        this.abWork,
        this.acWork,
        this.missionNo,
        this.mission,
        this.resultsNo,
        this.results,
        this.opinion,
        this.status,
        this.createName,
        this.createBy,
        this.createTime,
        this.tenantId});

  WorkTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    executeId = json['executeId'];
    executeBy = json['executeBy'];
    abWork = json['abWork'];
    acWork = json['acWork'];
    missionNo = json['missionNo'];
    mission = json['mission'];
    resultsNo = json['resultsNo'];
    results = json['results'];
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
    data['executeId'] = this.executeId;
    data['executeBy'] = this.executeBy;
    data['abWork'] = this.abWork;
    data['acWork'] = this.acWork;
    data['missionNo'] = this.missionNo;
    data['mission'] = this.mission;
    data['resultsNo'] = this.resultsNo;
    data['results'] = this.results;
    data['opinion'] = this.opinion;
    data['status'] = this.status;
    data['createName'] = this.createName;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}

class WorkTaskDetail {
  WorkTask workTask;
  List<TaskNode> wppList;
  var workTaskParent;
  var workTaskChildList;

  WorkTaskDetail(
      {this.workTask,
        this.wppList,
        this.workTaskParent,
        this.workTaskChildList});

  WorkTaskDetail.fromJson(Map<String, dynamic> json) {
    workTask = json['workTask'] != null
        ? new WorkTask.fromJson(json['workTask'])
        : null;
    if (json['wppList'] != null) {
      wppList = new List<TaskNode>();
      json['wppList'].forEach((v) {
        wppList.add(new TaskNode.fromJson(v));
      });
    }
    workTaskParent = json['workTaskParent'];
    workTaskChildList = json['workTaskChildList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workTask != null) {
      data['workTask'] = this.workTask.toJson();
    }
    if (this.wppList != null) {
      data['wppList'] = this.wppList.map((v) => v.toJson()).toList();
    }
    data['workTaskParent'] = this.workTaskParent;
    data['workTaskChildList'] = this.workTaskChildList;
    return data;
  }
}


class TaskNode {
  String id;
  String taskId;
  String title;
  String opinion;
  String action;
  String actionTime;
  String tenantId;

  TaskNode(
      {this.id,
        this.taskId,
        this.title,
        this.opinion,
        this.action,
        this.actionTime,
        this.tenantId});

  TaskNode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['taskId'];
    title = json['title'];
    opinion = json['opinion'];
    action = json['action'];
    actionTime = json['actionTime'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['taskId'] = this.taskId;
    data['title'] = this.title;
    data['opinion'] = this.opinion;
    data['action'] = this.action;
    data['actionTime'] = this.actionTime;
    data['tenantId'] = this.tenantId;
    return data;
  }
}