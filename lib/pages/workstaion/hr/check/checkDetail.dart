import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/flutterPrint/flutterPrint.dart';
import 'package:cloundapp/model/hr/ApplyDetailModel.dart';
import 'package:cloundapp/model/hr/CheckNodeModel.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckDetail extends StatefulWidget {
  final String id;
  final String checkType;

  const CheckDetail({Key key, this.id, this.checkType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CheckDetailState();
  }

}


class CheckDetailState extends State<CheckDetail> {
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
  var payTimeCon = new TextEditingController(); //结束时间

  @override
  void initState() {
    getDetail();
    getNode();
    super.initState();
  }

  ApplyDetailModel applyDetailModel;
  CheckNodeModelList checkNodeModelList;
  List<CheckNodeModel> checkNodeList;
  String applyType;

  getDetail() async {
    ApplyDetailModel applyDetailModel = await HRAPI.applyDetail(
        applyId: widget.id);
    setState(() {
      this.applyDetailModel = applyDetailModel;
      applyType = this.applyDetailModel.applyType;

      siteCon.text = this.applyDetailModel.site;
      durationCon.text = this.applyDetailModel.duration.toString() + "天";
      amountCon.text = "￥"+this.applyDetailModel.costAmount.toString();
      reasonCon.text = this.applyDetailModel.reason;
      costRemarkCon.text = this.applyDetailModel.costRemark;
      applyTypeCon.text = this.applyDetailModel.applyType;
      vacateTypeCon.text = this.applyDetailModel.vacateType;
      costTypeCon.text = this.applyDetailModel.costType;
      reimbTypeCon.text = this.applyDetailModel.reimbType;
      startDateTimeCon.text = this.applyDetailModel.startTime;
      endDateTimeCon.text = this.applyDetailModel.endTime;
      applyNoCon.text = this.applyDetailModel.applyNo;
      payTimeCon.text=this.applyDetailModel.payTime;
    });
  }


  getNode() async {
    CheckNodeModelList checkNodeModelList = await HRAPI.allProcessNodeInfo(
        busId: widget.id);
    setState(() {
      this.checkNodeModelList = checkNodeModelList;
      checkNodeList = checkNodeModelList.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("审批详情", automaticallyImplyLeading: true),
        body: applyDetailModel == null ? Center(
          child: CircularProgressIndicator(),) : ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          firstWidget(),
          showFrontInformation("申请详情"),
          getResultWidget(),
          showFrontInformation("审批进度"),
          checkProgressWidget(),
          bottomWidget(),
        ],)

    );
  }


  Widget firstWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      color:Style.contentColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(applyDetailModel.applyTitle,
                style: Style.style,),
              SizedBox(height: 10,),
              Text(applyDetailModel?.applyTime ?? "",
                style: Style.style,),

            ],
          ),
          Text(getApplyStatusStr(applyDetailModel.status),
            style: Style.greenStyle,),
        ],),
    );
  }


  //请假
  Widget qingJia() {
    return Column(children: <Widget>[
      multiTextField("申请类型", applyTypeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "请假类型", vacateTypeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "开始时间", startDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "结束时间", endDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("请假时长", durationCon, isImportant: true, isReadOnly: true),
      multiTextField("请假是由", reasonCon, isImportant: false, isReadOnly: true),

    ],);
  }

  //报销
  Widget baoxiaoWidget() {
    return Column(
      children: <Widget>[
        multiTextField(
            "申请类型", applyTypeCon, isImportant: true, isReadOnly: true),
        multiTextField(
            "报销类型", reimbTypeCon, isImportant: true, isReadOnly: true),
        multiTextField(
            "费用类型", costTypeCon, isImportant: true, isReadOnly: true),
        multiTextField(
            "发生时间", payTimeCon, isImportant: true, isReadOnly: true),
        multiTextField("费用金额", amountCon, isImportant: true, isReadOnly: true,),
        multiTextField("报销是由", reasonCon, isImportant: false, isReadOnly: true,),
        multiTextField(
          "费用说明", costRemarkCon, isImportant: false, isReadOnly: true,),
      ],
    );
  }

  //加班
  Widget jiaBan() {
    return Column(children: <Widget>[
      multiTextField("申请类型", applyTypeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "开始时间", startDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "结束时间", endDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("加班时长", durationCon, isImportant: true, isReadOnly: true),
      multiTextField("加班是由", reasonCon, isImportant: false, isReadOnly: true),

    ],);
  }

  //出差
  Widget chuChai() {
    return Column(children: <Widget>[
      multiTextField("申请类型", applyTypeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "开始时间", startDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "结束时间", endDateTimeCon, isImportant: true, isReadOnly: true),
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


  Widget checkProgressWidget() {
    if(checkNodeList==null) return Container();

    List<Widget> listWidget = [];
    for (int i = 0; i < checkNodeList.length; i++) {
      CheckNodeModel checkNodeModel = checkNodeList[i];
      Widget widget = nodeItemWidget(checkNodeModel);
      listWidget.add(widget);
    }

    listWidget.add(endNode());
    return Container(
      color: Style.contentColor,
      padding: EdgeInsets.all(10),
      child: Column(
        children: listWidget,
      ),
    );
  }

  Widget nodeItemWidget(CheckNodeModel checkNodeModel) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(

          children: <Widget>[
            circleShape(),

            Container(width: 1, height: checkNodeModel.busProcessLogs.length*40.0, color: Style.themeColor,),
          ],
        ),
        SizedBox(width: 20,),
        checkNodeChild(checkNodeModel.busProcessLogs),
      ],);
  }

  bool isPass=false;//是否已经审批通过
  Widget checkNodeChild(List<BusProcessLogs> busProcessLogs) {
    List<Widget> listWidget = [];
    for (int i = 0; i < busProcessLogs?.length; i++) {
      BusProcessLogs busProcessLog = busProcessLogs[i];
      if(busProcessLog.approvalBy==Data.user.id.toString()&&busProcessLog.status=="0"){
        isPass=true;
      }
      Widget widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(busProcessLog.approvalInfo??"", style: Style.style,),
          Text(busProcessLog.createTime??"", style: Style.style,),
        ],);
      listWidget.add(widget);
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidget,
    );
  }


  Widget endNode() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color:getApplyStatusStr(applyDetailModel.status) == "审批中"?
            Colors.grey:Style.themeColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 20,),
        Text("审批结束", style: Style.style,),

      ],);
  }

  Widget bottomWidget() {
    if (widget.checkType == "2") { //我的审批
      if (getApplyStatusStr(applyDetailModel.status) == "审批中") {
        if(isPass) return Container();
        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RoundedRectangleButton(
              name: "驳回",
              width: 80,
              height: 40,
              function: () {
                agreeOrDisagree(status: "1");
              },
              color: Colors.red,),
            RoundedRectangleButton(
              name: "通过", width: 80, height: 40, function: () {
              agreeOrDisagree(status: "0");
            },)
          ],);
      }else{
        return Container();

      }
    } else { //抄送我的
      return Container();
    }
  }

  agreeOrDisagree({String status}) {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await HRAPI.approvsalBusProcess(
        busId: applyDetailModel.id,
        status: status,
      );

      if (result["data"] == true) {
        Fluttertoast.showToast(msg: result["msg"]);
        Navigator.pop(context);
        return true;
      } else {
        Fluttertoast.showToast(msg: result["msg"]);
        return false;
      }
    });
  }


}


