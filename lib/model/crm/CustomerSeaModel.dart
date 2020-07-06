class CustomerSeaModel {
  String id;
  String seasName;
  String dept;
  String member;
  String deptName;
  String memberName;
  int rule;
  int noDeal;
  int exceedNum;
  String turnTime;
  int remindNum;
  String remindTime;
  int limitStatus;
  int limitNum;
  int maxNum;
  int robNum;
  int delFlag;
  String tenantId;

  CustomerSeaModel(
      {this.id,
        this.seasName,
        this.dept,
        this.member,
        this.deptName,
        this.memberName,
        this.rule,
        this.noDeal,
        this.exceedNum,
        this.turnTime,
        this.remindNum,
        this.remindTime,
        this.limitStatus,
        this.limitNum,
        this.maxNum,
        this.robNum,
        this.delFlag,
        this.tenantId});

  CustomerSeaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seasName = json['seasName'];
    dept = json['dept'];
    member = json['member'];
    deptName = json['deptName'];
    memberName = json['memberName'];
    rule = json['rule'];
    noDeal = json['noDeal'];
    exceedNum = json['exceedNum'];
    turnTime = json['turnTime'];
    remindNum = json['remindNum'];
    remindTime = json['remindTime'];
    limitStatus = json['limitStatus'];
    limitNum = json['limitNum'];
    maxNum = json['maxNum'];
    robNum = json['robNum'];
    delFlag = json['delFlag'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seasName'] = this.seasName;
    data['dept'] = this.dept;
    data['member'] = this.member;
    data['deptName'] = this.deptName;
    data['memberName'] = this.memberName;
    data['rule'] = this.rule;
    data['noDeal'] = this.noDeal;
    data['exceedNum'] = this.exceedNum;
    data['turnTime'] = this.turnTime;
    data['remindNum'] = this.remindNum;
    data['remindTime'] = this.remindTime;
    data['limitStatus'] = this.limitStatus;
    data['limitNum'] = this.limitNum;
    data['maxNum'] = this.maxNum;
    data['robNum'] = this.robNum;
    data['delFlag'] = this.delFlag;
    data['tenantId'] = this.tenantId;
    return data;
  }
}


class CustomerSeaList{
  int total;
  List<CustomerSeaModel> list;
  CustomerSeaList(this.total,this.list);
}