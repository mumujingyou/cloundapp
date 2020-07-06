import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/components/workDetailWidget.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/hr/CheckNodeModel.dart';
import 'package:cloundapp/model/oa/workModel.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckWorkDetail extends StatefulWidget {
  final String id;
  final String checkType;
  final String type;

  const CheckWorkDetail({Key key, this.id, this.checkType, this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CheckWorkDetailState();
  }

}


class CheckWorkDetailState extends State<CheckWorkDetail> {


  @override
  initState() {
    getNode();
    getWorkDetail();
    super.initState();
  }


  CheckNodeModelList checkNodeModelList;
  List<CheckNodeModel> checkNodeList;
  String applyType;
  WorkDetailModel workDetailModel;


  getWorkDetail() async {
    WorkDetailModel workDetailModel = await getDetail(state: this, id: widget.id, type: widget.type);
    setState(() {
      this.workDetailModel = workDetailModel;
    });
  }

  getNode() async {
    CheckNodeModelList checkNodeModelList = await OAAPI.allProcessNodeInfo(
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
        body: workDetailModel == null ? Center(
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
      color: Style.contentColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(workDetailModel.applyTitle,
                style: Style.style,),
              SizedBox(height: 10,),
              Text(workDetailModel?.createTime ?? "",
                style: Style.style,),

            ],
          ),
          Text(getApplyStatusStr(workDetailModel.status),
            style: Style.greenStyle,),
        ],),
    );
  }


  Widget checkProgressWidget() {
    if (checkNodeList == null) return Container();

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
  return Stack(children: <Widget>[

    Padding(
      padding: EdgeInsets.only(left: 25.0),
      child:Container(
        padding: EdgeInsets.only(left: 16.0,right: 16,top: 0,bottom: 16),
        width: double.infinity,
        child: checkNodeChild(checkNodeModel.busProcessLogs),
      ),
    ),
    Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 10.0,
      child: Container(
        height: double.infinity,
        width: 1.0,
        color: Style.themeColor,
      ),
    ),
    circleShape(),
  ],);
  }

  Widget checkNodeChild(List<BusProcessLogs> busProcessLogs) {
    List<Widget> listWidget = [];
    for (int i = 0; i < busProcessLogs?.length; i++) {
      BusProcessLogs busProcessLog = busProcessLogs[i];
      Widget widget = Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(busProcessLog.approvalInfo ?? "", style: Style.style,),
          Text(busProcessLog.createTime ?? "", style: Style.style,),
          Text(busProcessLog.opinion ?? "", style: Style.style,),

        ],);
      listWidget.add(widget);
      listWidget.add(SizedBox(height: 10,));

    }


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
            color: getApplyStatusStr(workDetailModel.status) == "审批中" ?
            Colors.grey : Style.themeColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 20,),
        Text("审批结束", style: Style.style,),

      ],);
  }
  var opinionCon = new TextEditingController(); //原因

  Widget bottomWidget() {
    if (widget.checkType == "2") { //我的审批
      if (getApplyStatusStr(workDetailModel.status) == "审批中") {
        return Column(
          children: <Widget>[
            showFrontInformation("审批处理"),

            multiTextField("处理意见", opinionCon, isImportant: false, isReadOnly: false),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              ],),
          ],
        );
      } else {
        return Container();
      }
    } else { //抄送我的
      return Container();
    }
  }

  agreeOrDisagree({String status}) {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await OAAPI.approvsalBusProcess(
        busId: workDetailModel.applyId,
        status: status,
        opinion: opinionCon.text,
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
// print('Height is ${context.size.height}');
class HeightReporter extends StatelessWidget {
  final Widget child;

  HeightReporter({this.child});

  @override
  Widget build(BuildContext context) {
//    print('Height is ${context.size.height}');
    return new Expanded(
      flex: 1,
      child: child,
    );
  }

}
