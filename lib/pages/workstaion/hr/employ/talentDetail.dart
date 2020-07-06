import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/hr/TalentDetailModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TalentDetail extends StatefulWidget {

  final String id;
  final String employ;

  const TalentDetail({Key key, this.id, this.employ}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TalentDetailState();
  }

}

class TalentDetailState extends State<TalentDetail> {

  @override
  void initState() {
    getDetail();
    grade=talentGradeInts[0];
    super.initState();
  }

  TalentDetailModel talentDetailModel;
  List<TalentNode> talentNodeList;
  getDetail() async {
    TalentDetailModel talentDetailModel=await HRAPI.getTalentDetail(id: widget.id);
    setState(() {
      this.talentDetailModel=talentDetailModel;
      talentNodeList=talentDetailModel.list;
    });
  }

  var remarkCon=TextEditingController();
  String grade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("面试详情", automaticallyImplyLeading: true),
        body: talentDetailModel == null ? Center(
          child: CircularProgressIndicator(),) : ListView(children: <Widget>[
          showFrontInformation("面试详情"),
          talentDetailWidget(),
          showFrontInformation("面试进度"),
          progressWidget(),


          bottomWidget(),
        ],)

    );
  }



  Widget talentDetailWidget() {
    return        Container(
      padding: EdgeInsets.all(10),
      color: Style.contentColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${talentDetailModel.name}  ${talentDetailModel.phone}",
                style: Style.infoStyle,),
              SizedBox(height: 10,),
              Text("投递时间： ${talentDetailModel?.createTime ?? ""}",
                style: Style.style,),
              SizedBox(height: 10,),
              Text("面试时间： ${talentDetailModel?.interviewTime ?? ""}",
                style: Style.style,),
              SizedBox(height: 10,),

              Text("面试职位： ${widget.employ}",
                style: Style.style,),
            ],
          ),
        ],),
    );
  }

  Widget progressWidget() {
    if(talentNodeList==null) return Container();

    List<Widget> listWidget = [];
    for (int i = 0; i < talentNodeList.length; i++) {
      TalentNode talentNode = talentNodeList[i];
      Widget widget = nodeItemWidget(talentNode);
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

  Widget nodeItemWidget(TalentNode talentNode) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            circleShape(),
            Container(width: 1, height:40.0, color: Style.themeColor,),
          ],
        ),
        SizedBox(width: 20,),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${talentNode.rotation??""}：${talentNode.interviewBy}",
              style: Style.style,),
            Row(
              children: <Widget>[
                Text(talentNode.interviewTime??"", style: Style.style,),
                SizedBox(width: 10,),
                nodeStatusWidget(talentNode),
              ],
            ),
          ],),
      ],);
  }


  Widget nodeStatusWidget(TalentNode talentNode){

    TextStyle style;
    if(talentNode.status=="1"){
      style=Style.greenStyle;
    }else if(talentNode.status=="2"){
      style=Style.redStyle;
    }else{
      style=Style.style;
    }

    return Text("【${getTalentResultStr(talentNode.status)}】",style:style ,);
  }

  Widget endNode() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color:talentDetailModel.status=="2"||talentDetailModel.status=="3"?
            Style.themeColor:Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 20,),
        Text("面试结束", style: Style.style,),

      ],);
  }

//// `status`状态 0新建 1面试中 2录用 3.放弃',  最终状态
  Widget bottomWidget() {
    if (talentDetailModel.status=="1") {
      return Column(
        children: <Widget>[

          showFrontInformation("面试反馈"),
          downArrowContainer(isImportant: true,
              name: "综合评价", content: talentGradeStr ?? "", function: () {
                PickHelper.openSimpleDataPicker(
                    context, list: talentGradeStrs,
                    value: talentGradeStr,
                    onConfirm: (picker, List value) {
                      setState(() {
                        talentGradeStr = picker.getSelectedValues()[0];
                        grade = talentGradeInts[value[0]];
                      });
                    });
              }),
          multiTextField("面试点评",remarkCon,isImportant: true,hint: "请输入面试点评"),

          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RoundedRectangleButton(
                name: "驳回",
                width: 80,
                height: 40,
                function: () {
                  agreeOrDisagree(status: "2");
                },
                color: Colors.red,),
              RoundedRectangleButton(
                name: "通过", width: 80, height: 40, function: () {
                agreeOrDisagree(status: "1");
              },)
            ],),
        ],
      );
    } else { //抄送我的
      return Container();
    }
  }

  agreeOrDisagree({String status}) {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await HRAPI.interviewTalent(
        id: talentDetailModel.id,
        status: status,
        remarks: remarkCon.text,
        grade: grade
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