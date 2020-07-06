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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddInfoState();
  }

}


class AddInfoState extends State<AddInfo> {
  var nameCon = new TextEditingController();
  var remarksCon = new TextEditingController();
  var createTimeCon = new TextEditingController();

  DateTime createTime;


  void init() {
    createTime = DateTime.now();
    createTimeCon.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(createTime);
    planTypeStr = planTypeStrs[0];
    planType = planTypeInts[0];
  }

  @override
  void initState() {
    init();
    getNumber();
    getAllUser();
    super.initState();
  }

  String number;

  getNumber() async {
    number = await OAAPI.getNumber(type: "10");
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
      appBar: createAppBar("新增工作报告", automaticallyImplyLeading: true),
      body: ListView(children: <Widget>[

        showFrontInformation("基本信息"),

        planWidget(),
        showFrontInformation("报告内容"),

        remarkContainer(controller: remarksCon, hint: "报告内容"),
        SizedBox(height: 20,),

        RoundedRectangleButton(
          name: "保存", width: 0, height: 50, function: save,)
      ],),

    );
  }

  Future save() async {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await OAAPI.saveWorkInfo(
          createTime: createTimeCon.text,
          wpType: planType,
          title: nameCon.text,
          content: remarksCon.text,
          busNo: number,

          approvalBy: approvalBy,
          approvalId: approvalId
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
  String approvalId; //评审人id
  String approvalBy;


  Widget planWidget() {
    return Column(children: <Widget>[
      downArrowContainer(isImportant: true,
          name: "报告分类", content: planTypeStr ?? "", function: () {
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
      multiTextField("报告名称", nameCon, isImportant: true, hint: "请输入计划名称"),
      multiTextField("创建时间", createTimeCon, isImportant: true,isReadOnly: true),

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


