class AttendanceInfo {
  int lateTimes;
  int earlyLeaveTimes;
  int absenteeismTimes;
  int leaveTimes;

  AttendanceInfo(
      {this.lateTimes,
        this.earlyLeaveTimes,
        this.absenteeismTimes,
        this.leaveTimes});

  AttendanceInfo.fromJson(Map<String, dynamic> json) {
    lateTimes = json['lateTimes'];
    earlyLeaveTimes = json['earlyLeaveTimes'];
    absenteeismTimes = json['absenteeismTimes'];
    leaveTimes = json['leaveTimes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lateTimes'] = this.lateTimes;
    data['earlyLeaveTimes'] = this.earlyLeaveTimes;
    data['absenteeismTimes'] = this.absenteeismTimes;
    data['leaveTimes'] = this.leaveTimes;
    return data;
  }
}

class AttendanceModelList {

  List<AttendanceModel> data;

  AttendanceModelList({ this.data});

  AttendanceModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AttendanceModel>();
      json['data'].forEach((v) {
        data.add(new AttendanceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceModel {
  String id;
  String userId;
  String jobNo;
  String attDate;
  String createTime;
  int attStatus;
  String tenantId;
  double workingTime;
  double vacationTime;

  AttendanceModel(
      {this.id,
        this.userId,
        this.jobNo,
        this.attDate,
        this.createTime,
        this.attStatus,
        this.tenantId,
        this.workingTime,
        this.vacationTime});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    jobNo = json['jobNo'];
    attDate = json['attDate'];
    createTime = json['createTime'];
    attStatus = json['attStatus'];
    tenantId = json['tenantId'];
    workingTime = json['workingTime'];
    vacationTime = json['vacationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['jobNo'] = this.jobNo;
    data['attDate'] = this.attDate;
    data['createTime'] = this.createTime;
    data['attStatus'] = this.attStatus;
    data['tenantId'] = this.tenantId;
    data['workingTime'] = this.workingTime;
    data['vacationTime'] = this.vacationTime;
    return data;
  }
}

class AttendanceLogModel {
  String date;
  String appUserName;
  String firstTime;
  String lastTime;

  AttendanceLogModel({this.date, this.appUserName, this.firstTime, this.lastTime});

  AttendanceLogModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    appUserName = json['appUserName'];
    firstTime = json['firstTime'];
    lastTime = json['lastTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['appUserName'] = this.appUserName;
    data['firstTime'] = this.firstTime;
    data['lastTime'] = this.lastTime;
    return data;
  }
}