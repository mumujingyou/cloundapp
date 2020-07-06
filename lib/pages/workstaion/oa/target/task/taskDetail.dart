import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/model/oa/planModel.dart';
import 'package:cloundapp/model/oa/taskModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class TaskDetail extends StatefulWidget {
  final String id;
  final String status;

  const TaskDetail({Key key, this.id, this.status,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState();
  }

}


class TaskDetailState extends State<TaskDetail> {
  var nameCon = new TextEditingController(); //
  var remarksCon = new TextEditingController(); //
  var typeCon = new TextEditingController(); //
  var executeByCon = new TextEditingController(); //
  var startDateTimeCon = new TextEditingController(); //开始时间
  var endDateTimeCon = new TextEditingController(); //结束时间
  var abWorkCon = new TextEditingController();
  var acWorkCon = new TextEditingController();

  @override
  void initState() {
    getDetail();
    super.initState();
  }


  WorkTaskDetail workTaskDetail;
  WorkTask workTask;
  List<TaskNode> wppList;

  getDetail() async {
    WorkTaskDetail workTaskDetail = await OAAPI.workTaskDetail(id: widget.id);
    setState(() {
      this.workTaskDetail = workTaskDetail;
      workTask = this.workTaskDetail.workTask;
      wppList = this.workTaskDetail.wppList;
      nameCon.text = workTask.title;
      remarksCon.text = workTask.mission;
      abWorkCon.text=workTask.abWork;
      acWorkCon.text=workTask.acWork;
      startDateTimeCon.text=workTask.beginDate;
      endDateTimeCon.text=workTask.endDate;
      typeCon.text=getTaskTypeStr(workTask.wpType);

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("工作计划详情", automaticallyImplyLeading: true,actions: <Widget>[
          widget.status=="1"||widget.status=="4"?
          InkWell(
            onTap: () {
              Application.router.navigateTo(context, "${Routes.taskEdit}?id=${widget.id}",
                  transition: TransitionType.fadeIn);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.edit, size: 35,),
            ),
          ):Container(),

        ]),
        body: workTaskDetail == null ? Center(
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
      multiTextField("任务分类", typeCon, isImportant: false, isReadOnly: true),
      multiTextField("任务名称", nameCon, isImportant: false, isReadOnly: true),
      multiTextField(
          "开始时间", startDateTimeCon, isImportant: false, isReadOnly: true),
      multiTextField(
          "结束时间", endDateTimeCon, isImportant: false, isReadOnly: true),
      multiTextField("预估工作天数", acWorkCon, isImportant: false, isReadOnly: true,),
      multiTextField("实际工作天数", abWorkCon, isImportant: false, isReadOnly: true,),
      multiTextField("执行人", executeByCon, isImportant: false, isReadOnly: true),

    ],);
  }


  Widget checkProgressWidget() {
    if (wppList == null) return Container();
    List<Widget> listWidget = [];
    for (int i = 0; i < wppList.length; i++) {
      TaskNode taskNode = wppList[i];
      Widget widget = nodeItemWidget(taskNode);
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

  Widget nodeItemWidget(TaskNode taskNode) {
    List<String> results = taskNode.title.split("[");

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
            Text(taskNode.opinion ?? "", style: Style.style,),
          ],)
      ],);
  }

  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      getDetail();

    }
    super.deactivate();
  }

}


