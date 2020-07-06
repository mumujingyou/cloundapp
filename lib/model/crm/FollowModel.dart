class FollowModel {
  String start;
  String length;
  var id;
  String type;
  String source;
  String sourceName;
  String way;
  String date;
  String remark;
  String client;
  String nextTime;
  String createBy;
  String createName;
  String principal;
  String delAble;
  String createTime;
  String updateTime;
  String delFlag;
  String followNo;
  String owner;
  String tenantId;
  List fileList;

  FollowModel(
      {this.start,
        this.length,
        this.id,
        this.type,
        this.source,
        this.sourceName,
        this.way,
        this.date,
        this.remark,
        this.client,
        this.nextTime,
        this.createBy,
        this.createName,
        this.principal,
        this.delAble,
        this.createTime,
        this.updateTime,
        this.delFlag,
        this.followNo,
        this.owner,
        this.tenantId,
        this.fileList});

  FollowModel.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    length = json['length'];
    id = json['id'];
    type = json['type'];
    source = json['source'];
    sourceName = json['sourceName'];
    way = json['way'];
    date = json['date'];
    remark = json['remark'];
    client = json['client'];
    nextTime = json['nextTime'];
    createBy = json['createBy'];
    createName = json['createName'];
    principal = json['principal'];
    delAble = json['delAble'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    delFlag = json['delFlag'];
    followNo = json['followNo'];
    owner = json['owner'];
    tenantId = json['tenantId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['length'] = this.length;
    data['id'] = this.id;
    data['type'] = this.type;
    data['source'] = this.source;
    data['sourceName'] = this.sourceName;
    data['way'] = this.way;
    data['date'] = this.date;
    data['remark'] = this.remark;
    data['client'] = this.client;
    data['nextTime'] = this.nextTime;
    data['createBy'] = this.createBy;
    data['createName'] = this.createName;
    data['principal'] = this.principal;
    data['delAble'] = this.delAble;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['delFlag'] = this.delFlag;
    data['followNo'] = this.followNo;
    data['owner'] = this.owner;
    data['tenantId'] = this.tenantId;
    return data;
  }
}