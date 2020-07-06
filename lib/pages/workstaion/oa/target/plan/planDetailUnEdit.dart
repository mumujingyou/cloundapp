import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/planModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PlanDetailUnEdit extends StatefulWidget {
  final String id;

  const PlanDetailUnEdit({Key key, this.id,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PlanDetailUnEditState();
  }

}


class PlanDetailUnEditState extends State<PlanDetailUnEdit> {
  var nameCon = new TextEditingController(); //
  var remarksCon = new TextEditingController(); //
  var planTypeCon = new TextEditingController(); //
  var executeByCon = new TextEditingController(); //
  var approvalByCon = new TextEditingController();
  var startDateTimeCon = new TextEditingController(); //开始时间
  var endDateTimeCon = new TextEditingController(); //结束时间

  @override
  void initState() {
    getDetail();
    super.initState();
  }


  WorkPlanDetail workPlanDetail;
  WorkPlan workPlan;
  List<PlanNode> wppList;

  getDetail() async {
    WorkPlanDetail workPlanDetail = await OAAPI.workPlan(id: widget.id);
    setState(() {
      this.workPlanDetail = workPlanDetail;
      workPlan = this.workPlanDetail.workPlan;
      wppList = this.workPlanDetail.wppList;
      nameCon.text = workPlan.title;
      remarksCon.text = workPlan.content;
      planTypeCon.text = getPlanTypeStr(workPlan.wpType);
      executeByCon.text = workPlan.executeBy;
      approvalByCon.text = workPlan.approvalBy;
      startDateTimeCon.text = workPlan.beginDate;
      endDateTimeCon.text = workPlan.endDate;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("工作计划详情", automaticallyImplyLeading: true),
        body: workPlanDetail == null ? Center(
          child: CircularProgressIndicator(),) : ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          detailWidget(),
          showFrontInformation("计划内容"),
          // remarkContainer(controller: remarksCon, readOnly: true),
          Container(
            padding: EdgeInsets.all(10),
            color: Style.contentColor,
            child: Html(data: remarksCon.text,
              defaultTextStyle: Style.style,),
          ),
          showFrontInformation("审批进度"),
          checkProgressWidget(),
        ],)

    );
  }


  //基本信息
  Widget detailWidget() {
    return Column(children: <Widget>[
      multiTextField("计划分类", planTypeCon, isImportant: true, isReadOnly: true),
      multiTextField("计划名称", nameCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "开始时间", startDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "结束时间", endDateTimeCon, isImportant: true, isReadOnly: true),
      multiTextField("执行人", executeByCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "审批人", approvalByCon, isImportant: false, isReadOnly: true),

    ],);
  }


  Widget checkProgressWidget() {
    if (wppList == null) return Container();
    List<Widget> listWidget = [];
    for (int i = 0; i < wppList.length; i++) {
      PlanNode planNode = wppList[i];
      Widget widget = nodeItemWidget(planNode);
      listWidget.add(widget);
    }

    return Container(
      color: Style.contentColor,
      padding: EdgeInsets.all(10),
      child: Column(
        children: listWidget,
      ),
    );
  }

  Widget nodeItemWidget(PlanNode planNode) {
    List<String> results = planNode.title.split("[");

    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            circleShape(),
            Container(width: 1,
              height: 40.0,
              color: Style.themeColor,),
          ],
        ),
        SizedBox(width: 20,),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 120,
                  child: Text(results[0] ?? "", style: Style.style,
                    overflow: TextOverflow.ellipsis, softWrap: true,
                  ),
                ),
                Text("[${results[1]}", style: Style.style,),
              ],
            ),
            Text(planNode.opinion ?? "", style: Style.style,),
          ],)
      ],);
  }


}


