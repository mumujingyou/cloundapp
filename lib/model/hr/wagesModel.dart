class WagesModelList {

  List<WagesModel> data;

  WagesModelList({this.data});

  WagesModelList.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = new List<WagesModel>();
      json['data'].forEach((v) {
        data.add(new WagesModel.fromJson(v));
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

class WagesModel {
  String id;
  String wagesReportId;
  String userId;
  String name;
  String jobNo;
  String phone;
  String deptId;
  String deptName;
  String hiredate;
  String employment;
  String staff;
  String idNumber;
  var wagesBaseBack;
  var wagesTotalBack;
  var wagesBase;
  var wagesTotal;
  var wagesMode;
  var wagesPip;
  var preTax;
  var afterTax;
  var ownInsurePay;
  var ownFundPay;
  var empInsurePay;
  var empFundPay;
  var workingTime;
  var deduction;
  var wages;
  var month;
  var createTime;
  var tenantId;
  var overtimeHours;
  var overtimePay;
  var sendMonth;
  var sendBy;

  WagesModel(
      {this.id,
        this.wagesReportId,
        this.userId,
        this.name,
        this.jobNo,
        this.phone,
        this.deptId,
        this.deptName,
        this.hiredate,
        this.employment,
        this.staff,
        this.idNumber,
        this.wagesBaseBack,
        this.wagesTotalBack,
        this.wagesBase,
        this.wagesTotal,
        this.wagesMode,
        this.wagesPip,
        this.preTax,
        this.afterTax,
        this.ownInsurePay,
        this.ownFundPay,
        this.empInsurePay,
        this.empFundPay,
        this.workingTime,
        this.deduction,
        this.wages,
        this.month,
        this.createTime,
        this.tenantId,
        this.overtimeHours,
        this.overtimePay,
        this.sendMonth,
        this.sendBy});

  WagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wagesReportId = json['wagesReportId'];
    userId = json['userId'];
    name = json['name'];
    jobNo = json['jobNo'];
    phone = json['phone'];
    deptId = json['deptId'];
    deptName = json['deptName'];
    hiredate = json['hiredate'];
    employment = json['employment'];
    staff = json['staff'];
    idNumber = json['idNumber'];
    wagesBaseBack = json['wagesBaseBack'];
    wagesTotalBack = json['wagesTotalBack'];
    wagesBase = json['wagesBase'];
    wagesTotal = json['wagesTotal'];
    wagesMode = json['wagesMode'];
    wagesPip = json['wagesPip'];
    preTax = json['preTax'];
    afterTax = json['afterTax'];
    ownInsurePay = json['ownInsurePay'];
    ownFundPay = json['ownFundPay'];
    empInsurePay = json['empInsurePay'];
    empFundPay = json['empFundPay'];
    workingTime = json['workingTime'];
    deduction = json['deduction'];
    wages = json['wages'];
    month = json['month'];
    createTime = json['createTime'];
    tenantId = json['tenantId'];
    overtimeHours = json['overtimeHours'];
    overtimePay = json['overtimePay'];
    sendMonth = json['sendMonth'];
    sendBy = json['sendBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wagesReportId'] = this.wagesReportId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['jobNo'] = this.jobNo;
    data['phone'] = this.phone;
    data['deptId'] = this.deptId;
    data['deptName'] = this.deptName;
    data['hiredate'] = this.hiredate;
    data['employment'] = this.employment;
    data['staff'] = this.staff;
    data['idNumber'] = this.idNumber;
    data['wagesBaseBack'] = this.wagesBaseBack;
    data['wagesTotalBack'] = this.wagesTotalBack;
    data['wagesBase'] = this.wagesBase;
    data['wagesTotal'] = this.wagesTotal;
    data['wagesMode'] = this.wagesMode;
    data['wagesPip'] = this.wagesPip;
    data['preTax'] = this.preTax;
    data['afterTax'] = this.afterTax;
    data['ownInsurePay'] = this.ownInsurePay;
    data['ownFundPay'] = this.ownFundPay;
    data['empInsurePay'] = this.empInsurePay;
    data['empFundPay'] = this.empFundPay;
    data['workingTime'] = this.workingTime;
    data['deduction'] = this.deduction;
    data['wages'] = this.wages;
    data['month'] = this.month;
    data['createTime'] = this.createTime;
    data['tenantId'] = this.tenantId;
    data['overtimeHours'] = this.overtimeHours;
    data['overtimePay'] = this.overtimePay;
    data['sendMonth'] = this.sendMonth;
    data['sendBy'] = this.sendBy;
    return data;
  }
}


