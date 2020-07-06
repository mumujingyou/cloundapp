import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTaskState();
  }

}


class AddTaskState extends State<AddTask> {
  var nameCon = new TextEditingController();
  var remarksCon = new TextEditingController();
  var abWorkCon = new TextEditingController();
  var acWorkCon = new TextEditingController();


  DateTime startDateTime;
  DateTime endDateTime;


  void init() {
    startDateTime = DateTime.now();
    endDateTime = DateTime.now();

    taskTypeStr = taskTypeStrs[0];
    type = taskTypeInts[0];
  }

  @override
  void initState() {
    init();
    getNumber();
    getAllUser();
    super.initState();
  }

  String missionNo;
  String resultsNo;

  getNumber() async {
    missionNo = await OAAPI.getNumber(type: "8");
    resultsNo = await OAAPI.getNumber(type: "9");
  }


  List<User> userList = [];
  List<String> userNameList = [];

  getAllUser() async {
    List<User> userList = await CRMAPI.getAllUserListFilter(deptId: "");
    setState(() {
      this.userList = userList;
    });
    setState(() {
      userNameList = List.generate(userList.length, (index) {
        return userList[index].name;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("新增工作任务", automaticallyImplyLeading: true),
      body: ListView(children: <Widget>[

        showFrontInformation("基本信息"),

        planWidget(),
        showFrontInformation("计划内容"),

        remarkContainer(controller: remarksCon, hint: "计划内容"),
        SizedBox(height: 20,),

        RoundedRectangleButton(
          name: "保存", width: 0, height: 50, function: save,)
      ],),

    );
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
        abWork: abWorkCon.text,
        acWork: acWorkCon.text,

        executeBy: executeBy,
        executeId: executeId,

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
  String executeId; //执行人id
  String executeBy; //执行人
  String approvalId; //评审人id
  String approvalBy;


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
      multiTextField("任务名称", nameCon, isImportant: true, hint: "请输入任务名称"),

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


