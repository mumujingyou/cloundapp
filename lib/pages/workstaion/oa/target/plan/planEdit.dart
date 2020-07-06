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
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PlanEdit extends StatefulWidget {
  final String id;

  const PlanEdit({Key key, this.id,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PlanEditState();
  }

}


class PlanEditState extends State<PlanEdit> {
  var nameCon = new TextEditingController();
  var remarksCon = new TextEditingController();

  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();


  @override
  void initState() {
    getAllUser();
    getDetail();
    super.initState();
  }

  String number;

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
      approvalBy = workPlan.approvalBy;
      approvalId = workPlan.approvalId;
      executeBy = workPlan.executeBy;
      executeId = workPlan.executeId;
      number = workPlan.busNo;
      startDateTime = DateTime.parse(workPlan.beginDate);
      endDateTime = DateTime.parse(workPlan.endDate);

      planType = workPlan.wpType;
      planTypeStr = getPlanTypeStr(planType);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("工作计划详情", automaticallyImplyLeading: true),
      body: ListView(children: <Widget>[

        showFrontInformation("基本信息"),

        planWidget(),
        showFrontInformation("计划内容"),

        decodeHtml(),



        SizedBox(height: 20,),


        RoundedRectangleButton(
          name: "保存", width: 0, height: 50, function: save,)
      ],),

    );
  }


  Widget decodeHtml() {
    if (remarksCon.text.startsWith("<p>")) {
      return Container(
        padding: EdgeInsets.all(10),
        color: Style.contentColor,
        child: Html(data: remarksCon.text,
          defaultTextStyle: Style.style,),
      );
    } else {
      return remarkContainer(controller: remarksCon, hint: "计划内容");
    }
  }


  Future save() async {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await OAAPI.saveWorkPlan(
          beginDate: DateFormat('yyyy-MM-dd').format(startDateTime),
          endDate: DateFormat('yyyy-MM-dd').format(endDateTime),
          wpType: planType,
          title: nameCon.text,
          content: remarksCon.text,
          busNo: number,
          executeBy: executeBy,
          executeId: executeId,
          approvalBy: approvalBy,
          approvalId: approvalId,
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


  String planType;
  String executeId; //执行人id
  String executeBy; //执行人
  String approvalId; //评审人id
  String approvalBy;


  Widget planWidget() {
    return Column(children: <Widget>[
      downArrowContainer(isImportant: true,
          name: "计划分类", content: planTypeStr ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: planTypeStrs,
                value: planTypeStr,
                onConfirm: (picker, List value) {
                  setState(() {
                    planTypeStr = picker.getSelectedValues()[0];
                    planType = planTypeInts[value[0]];
                  });
                });
          }),
      multiTextField("计划名称", nameCon, isImportant: true, hint: "请输入计划名称"),

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

      downArrowContainer(isImportant: false,
          name: "评审人", content: approvalBy ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: userNameList,
                value: approvalBy,
                onConfirm: (picker, List value) {
                  setState(() {
                    approvalBy = picker.getSelectedValues()[0];
                    approvalId = userList[value[0]].id.toString();
                  });
                });
          }),

    ],);
  }





}


