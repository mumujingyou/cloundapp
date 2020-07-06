import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/model/oa/infoModel.dart';
import 'package:cloundapp/model/oa/planModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class InfoEdit extends StatefulWidget {
  final String id;

  const InfoEdit({Key key, this.id,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InfoEditState();
  }

}


class InfoEditState extends State<InfoEdit> {
  var nameCon = new TextEditingController();
  var remarksCon = new TextEditingController();
  var createTimeCon = new TextEditingController();

  @override
  void initState() {
    getAllUser();
    getDetail();
    super.initState();
  }

  String number;

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


  WorkInfoDetail workInfoDetail;
  WorkInfo workInfo;
  List<InfoNode> wppList;

  getDetail() async {
    WorkInfoDetail workInfoDetail = await OAAPI.workInfoDetail(id: widget.id);
    setState(() {
      this.workInfoDetail = workInfoDetail;
      workInfo = this.workInfoDetail.workInfo;
      wppList = this.workInfoDetail.wppList;

      nameCon.text = workInfo.title;
      remarksCon.text = workInfo.content;
      createTimeCon.text=workInfo.createTime;

      approvalBy=workInfo.approvalBy;
      approvalId=workInfo.approvalId;
      number=workInfo.busNo;


      planType = workInfo.wpType;
      planTypeStr=getPlanTypeStr(planType);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("工作报告详情", automaticallyImplyLeading: true),
      body: ListView(children: <Widget>[

        showFrontInformation("基本信息"),

        detailWidget(),
        showFrontInformation("计划内容"),

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
      return remarkContainer(controller: remarksCon, hint: "报告内容");
    }
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

  String approvalId;//评审人id
  String approvalBy;


  Widget detailWidget() {
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
      multiTextField("报告名称", nameCon, isImportant: true,hint: "请输入计划名称"),

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


