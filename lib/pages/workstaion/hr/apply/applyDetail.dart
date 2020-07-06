import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/model/hr/ApplyDetailModel.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

class ApplyDetail extends StatefulWidget {
  final String id;

  const ApplyDetail({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ApplyDetailState();
  }

}


class ApplyDetailState extends State<ApplyDetail> {
  var siteCon = new TextEditingController();//地点
  var durationCon = new TextEditingController();//时长
  var amountCon = new TextEditingController();//金额
  var reasonCon = new TextEditingController();//原因
  var costRemarkCon = new TextEditingController();//费用说明
  var applyTypeCon = new TextEditingController();//申请类型
  var vacateTypeCon = new TextEditingController();//请假类型
  var costTypeCon = new TextEditingController();//费用类型
  var reimbTypeCon = new TextEditingController();//报销类型
  var startDateTimeCon = new TextEditingController();//开始时间
  var endDateTimeCon = new TextEditingController();//结束时间
  var payTimeCon = new TextEditingController();//开始时间

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  ApplyDetailModel applyDetailModel;
  String applyType;
  getDetail() async {
    ApplyDetailModel applyDetailModel=await HRAPI.applyDetail(applyId: widget.id);
    setState(() {
      this.applyDetailModel=applyDetailModel;
      applyType=this.applyDetailModel.applyType;

      siteCon.text=this.applyDetailModel.site;
      durationCon.text=this.applyDetailModel.duration.toString()+"天";
      amountCon.text=this.applyDetailModel.costAmount.toString()+"￥";
      reasonCon.text=this.applyDetailModel.reason;
      costRemarkCon.text=this.applyDetailModel.costRemark;
      applyTypeCon.text=this.applyDetailModel.applyType;
      vacateTypeCon.text=this.applyDetailModel.vacateType;
      costTypeCon.text=this.applyDetailModel.costType;
      reimbTypeCon.text=this.applyDetailModel.reimbType;
      startDateTimeCon.text=this.applyDetailModel.startTime;
      endDateTimeCon.text=this.applyDetailModel.endTime;
      payTimeCon.text=this.applyDetailModel.payTime;


    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("申请详情", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[
          multiTextField("申请类型", applyTypeCon, isImportant: true, isReadOnly: true),
          SizedBox(height: 20,),
          getResultWidget(),
        ],)

    );
  }



  //请假
  Widget qingJia() {
    return Column(children: <Widget>[
      multiTextField("请假类型", vacateTypeCon, isImportant: true, isReadOnly: true),
      multiTextField("开始时间", startDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("结束时间", endDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("请假时长", durationCon, isImportant: true, isReadOnly: true),
      multiTextField("请假是由", reasonCon, isImportant: false, isReadOnly: true),

    ],);
  }

  //报销
  Widget baoxiaoWidget() {
    return Column(
      children: <Widget>[
        multiTextField("报销类型", reimbTypeCon, isImportant: true, isReadOnly: true),
        multiTextField("费用类型", costTypeCon, isImportant: true, isReadOnly: true),
        multiTextField("发生时间", payTimeCon, isImportant: true, isReadOnly: true),
        multiTextField("费用金额", amountCon, isImportant: true, isReadOnly: true,),
        multiTextField("报销是由", reasonCon, isImportant: false, isReadOnly: true,),
        multiTextField("费用说明", costRemarkCon, isImportant: false, isReadOnly: true,),



      ],
    );
  }

  //加班
  Widget jiaBan() {
    return Column(children: <Widget>[
      multiTextField("开始时间", startDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("结束时间", endDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("加班时长", durationCon, isImportant: true, isReadOnly: true),
      multiTextField("加班是由", reasonCon, isImportant: false, isReadOnly: true),

    ],);
  }

  //出差
  Widget chuChai() {
    return Column(children: <Widget>[
      multiTextField("开始时间", startDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("结束时间", endDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("出差地点", siteCon, isImportant: true, isReadOnly: true),
      multiTextField("出差是由", reasonCon, isImportant: false, isReadOnly: true),

    ],);
  }


  Widget getResultWidget() {
    if (applyType == applyTypeStrs[0]) {
      return qingJia();
    } else if (applyType == applyTypeStrs[1]) {
      return jiaBan();
    } else if (applyType == applyTypeStrs[2]) {
      return baoxiaoWidget();
    } else if (applyType == applyTypeStrs[3]) {
      return chuChai();
    }
    return Center(child: CircularProgressIndicator(),);
  }





}


