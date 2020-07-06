import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/hr/ApplyDetailModel.dart';
import 'package:cloundapp/model/hr/CheckNodeModel.dart';
import 'package:cloundapp/model/hr/wagesModel.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WagesDetail extends StatefulWidget {
  final String month;
  final WagesModel wagesModel;


  const WagesDetail({Key key, this.month, this.wagesModel,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WagesDetailState();
  }

}


class WagesDetailState extends State<WagesDetail> {

  List<WagesModel> wagesModelList = [];



  var siteCon = new TextEditingController(); //地点
  var durationCon = new TextEditingController(); //时长
  var amountCon = new TextEditingController(); //金额
  var reasonCon = new TextEditingController(); //原因
  var costRemarkCon = new TextEditingController(); //费用说明
  var applyTypeCon = new TextEditingController(); //申请类型
  var vacateTypeCon = new TextEditingController(); //请假类型
  var costTypeCon = new TextEditingController(); //费用类型
  var reimbTypeCon = new TextEditingController(); //报销类型
  var startDateTimeCon = new TextEditingController(); //开始时间
  var endDateTimeCon = new TextEditingController(); //结束时间
  var applyNoCon = new TextEditingController(); //结束时间


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("工资条详情", automaticallyImplyLeading: true),
        body: detailItemWidget(widget.wagesModel),

    );
  }





  //详情
  Widget detailItemWidget(WagesModel wagesModel) {
    return Container(
      child: Column(children: <Widget>[
        unimportantText(name:"最新基本工资基数",width: 200,content:wagesModel.wagesBase.toString()??"" ),
        unimportantText(name:"计薪天数",width: 200,content:wagesModel.wagesPip.toString()??""),
        unimportantText(name:"计薪标准",width: 200,content:wagesModel.wagesMode.toString()??""),
        unimportantText(name:"加班时长",width: 200,content:wagesModel.overtimeHours.toString()??""),
        unimportantText(name:"加班费", width: 200,content:wagesModel.overtimePay.toString()??""),
        unimportantText(name:"税前补发/扣款", width: 200,content:wagesModel.preTax.toString()??""),
        unimportantText(name:"税后补发/扣款",width: 200,content:wagesModel.afterTax.toString()??""),
        unimportantText(name:"个人社保扣款", width: 200,content:wagesModel.ownInsurePay.toString()??""),
        unimportantText(name:"个人公积金扣款", width: 200,content:wagesModel.ownFundPay.toString()??""),
        unimportantText(name:"实发工资", width: 200,content:wagesModel.wages.toString()??""),

        SizedBox(height: 10,),
      ],),
    );
  }


}


