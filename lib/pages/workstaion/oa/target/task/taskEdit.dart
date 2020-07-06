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
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class TaskEdit extends StatefulWidget {
  final String id;

  const TaskEdit({Key key, this.id,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaskEditState();
  }

}


class TaskEditState extends State<TaskEdit> {
  var nameCon = new TextEditingController();
  var remarksCon = new TextEditingController();
  var abWorkCon = new TextEditingController();
  var acWorkCon = new TextEditingController();
  DateTime startDateTime;
  DateTime endDateTime;


  void init() {
    startDateTime=DateTime.now();
    endDateTime=DateTime.now();


  }

  @override
  void initState() {
    init();
    getAllUser();
    getDetail();
    super.initState();
  }

  String missionNo;
  String resultsNo;

  List<User> userList=[];
  List<String> userNameList=[];
  getAllUser() async {
    List<User> userList=await CRMAPI.getAllUserListFilter(deptId: "");
    setState(() {
      this.userList=userList;
    });
    setState(() {
      userNameList=List.generate(userList.length, (index){
        return userList[index].name;
      });
    });

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
      executeBy=workTask.executeBy;
      executeId=workTask.executeId;
      missionNo=workTask.missionNo;
      resultsNo=workTask.resultsNo;


      startDateTime=DateTime.parse(workTask.beginDate);
      endDateTime=DateTime.parse(workTask.endDate);

      type = workTask.wpType;
      taskTypeStr=getTaskTypeStr(type);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("工作任务详情", automaticallyImplyLeading: true),
      body: ListView(children: <Widget>[

        showFrontInformation("基本信息"),

        planWidget(),
        showFrontInformation("任务内容"),

        decodeHtml(),

        SizedBox(height: 20,),


        RoundedRectangleButton(
          name: "保存", width: 0, height: 50, function: save,)
      ],),

    );
  }


  Widget decodeHtml(){
    if(remarksCon.text.startsWith("<p>")){
      return Container(
        padding: EdgeInsets.all(10),
        color: Style.contentColor,
        child: Html(data: remarksCon.text,
          defaultTextStyle: Style.style,),
      );
    }else{
      return remarkContainer(controller: remarksCon, hint: "计划内容");
    }
  }


  Future save() async {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await OAAPI.saveWorkTask(
          beginDate: DateFormat('yyyy-MM-dd').format(startDateTime),
          endDate: DateFormat('yyyy-MM-dd').format(endDateTime),
          wpType: type,
          title: nameCon.text,
          mission: remarksCon.text,
          missionNo: missionNo,
          resultsNo: resultsNo,
          acWork: acWorkCon.text,
          abWork: abWorkCon.text,

          executeBy: executeBy,
          executeId: executeId,

          id: widget.id
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


  String type;
  String executeId;//执行人id
  String executeBy;//执行人


  Widget planWidget() {
    return Column(children: <Widget>[
      downArrowContainer(isImportant: true,
          name: "任务分类", content: taskTypeStr ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: taskTypeStrs,
                value: taskTypeStr,
                onConfirm: (picker, List value) {

                  setState(() {
                    taskTypeStr = picker.getSelectedValues()[0];
                    type = taskTypeInts[value[0]];
                  });
                });
          }),
      multiTextField("任务名称", nameCon, isImportant: true,hint: "请输入计划名称"),

      downArrowContainer(isImportant: true,
          name: "开始时间",
          content: "${DateFormat('yyyy-MM-dd').format(startDateTime)}",
          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kYMD,
                value: startDateTime,

                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                startDateTime = (picker.adapter as DateTimePickerAdapter).value;
              });
            });
          }),

      downArrowContainer(isImportant: true,
          name: "结束时间",
          content: "${DateFormat('yyyy-MM-dd').format(endDateTime)}",
          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kYMD,
                value: endDateTime,
                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                endDateTime = (picker.adapter as DateTimePickerAdapter).value;
              });
            });
          }),
      multiTextField("预估工作天数", acWorkCon, isImportant: false,
          hint: "请输入预估工作天数",
          textInputType: TextInputType.number),
      multiTextField("实际工作天数", abWorkCon, isImportant: false,
          hint: "请输入实际工作天数",
          textInputType: TextInputType.number),
      downArrowContainer(isImportant: true,
          name: "执行人", content: executeBy ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: userNameList,
                value: executeBy,
                onConfirm: (picker, List value) {
                  setState(() {
                    executeBy = picker.getSelectedValues()[0];
                    executeId = userList[value[0]].id.toString();
                  });
                });
          }),

    ],);
  }


}


