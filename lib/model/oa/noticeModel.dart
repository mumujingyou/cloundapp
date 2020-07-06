class NoticeListModel {
  int total;
  List<NoticeModel> data;

  NoticeListModel({this.total, this.data});

  NoticeListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<NoticeModel>();
      json['data'].forEach((v) {
        data.add(new NoticeModel.fromJson(v));
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

class NoticeModel {
  String id;
  String title;
  String priority;
  String context;
  String noticeType;
  String createBy;
  String createTime;
  String updateTime;
  String createDept;
  String noticeNo;
  String tenantId;
  String status;
  String read;
  String createName;
  String deptName;
  String typeName;

  NoticeModel(
      {this.id,
        this.title,
        this.priority,
        this.context,
        this.noticeType,
        this.createBy,
        this.createTime,
        this.updateTime,
        this.createDept,
        this.noticeNo,
        this.tenantId,
        this.status,
        this.read,
        this.createName,
        this.deptName,
        this.typeName});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priority = json['priority'];
    context = json['context'];
    noticeType = json['noticeType'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createDept = json['createDept'];
    noticeNo = json['noticeNo'];
    tenantId = json['tenantId'];
    status = json['status'];
    read = json['read'];
    createName = json['createName'];
    deptName = json['deptName'];
    typeName = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['priority'] = this.priority;
    data['context'] = this.context;
    data['noticeType'] = this.noticeType;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['createDept'] = this.createDept;
    data['noticeNo'] = this.noticeNo;
    data['tenantId'] = this.tenantId;
    data['status'] = this.status;
    data['read'] = this.read;
    data['createName'] = this.createName;
    data['deptName'] = this.deptName;
    data['typeName'] = this.typeName;
    return data;
  }
}