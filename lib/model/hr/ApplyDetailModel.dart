class ApplyDetailModel {
  String id;
  String applyNo;
  String applyTitle;
  String userName;
  String dept;
  String post;
  String sex;
  String hiredate;
  String applyType;
  String vacateType;
  String reimbType;
  String costType;
  String site;
  String reason;
  String payTime;
  String startTime;
  String endTime;
  double duration;
  double costAmount;
  String costRemark;
  String pic;
  var status;
  String applyTime;

  ApplyDetailModel(
      {this.id,
        this.applyNo,
        this.applyTitle,
        this.userName,
        this.dept,
        this.post,
        this.sex,
        this.hiredate,
        this.applyType,
        this.vacateType,
        this.reimbType,
        this.costType,
        this.site,
        this.reason,
        this.payTime,
        this.startTime,
        this.endTime,
        this.duration,
        this.costAmount,
        this.costRemark,
        this.pic,
        this.status,
        this.applyTime});

  ApplyDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applyNo = json['applyNo'];
    applyTitle = json['applyTitle'];
    userName = json['userName'];
    dept = json['dept'];
    post = json['post'];
    sex = json['sex'];
    hiredate = json['hiredate'];
    applyType = json['applyType'];
    vacateType = json['vacateType'];
    reimbType = json['reimbType'];
    costType = json['costType'];
    site = json['site'];
    reason = json['reason'];
    payTime = json['payTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    duration = json['duration'];
    costAmount = json['costAmount'];
    costRemark = json['costRemark'];
    pic = json['pic'];
    status = json['status'];
    applyTime = json['applyTime'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applyNo'] = this.applyNo;
    data['applyTitle'] = this.applyTitle;
    data['userName'] = this.userName;
    data['dept'] = this.dept;
    data['post'] = this.post;
    data['sex'] = this.sex;
    data['hiredate'] = this.hiredate;
    data['applyType'] = this.applyType;
    data['vacateType'] = this.vacateType;
    data['reimbType'] = this.reimbType;
    data['costType'] = this.costType;
    data['site'] = this.site;
    data['reason'] = this.reason;
    data['payTime'] = this.payTime;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['duration'] = this.duration;
    data['costAmount'] = this.costAmount;
    data['costRemark'] = this.costRemark;
    data['pic'] = this.pic;
    data['status'] = this.status;
    data['applyTime'] = this.applyTime;

    return data;
  }
}