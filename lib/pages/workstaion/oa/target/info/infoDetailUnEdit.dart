import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/infoModel.dart';
import 'package:cloundapp/model/oa/planModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class InfoDetailUnEdit extends StatefulWidget {
  final String id;

  const InfoDetailUnEdit({Key key, this.id,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InfoDetailUnEditState();
  }

}


class InfoDetailUnEditState extends State<InfoDetailUnEdit> {
  var nameCon = new TextEditingController(); //
  var remarksCon = new TextEditingController(); //
  var planTypeCon = new TextEditingController(); //
  var approvalByCon = new TextEditingController();
  var createTimeCon = new TextEditingController();


  @override
  void initState() {
    getDetail();
    super.initState();
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
      approvalByCon.text=workInfo.approvalBy;
      planTypeCon.text=getPlanTypeStr(workInfo.wpType);



    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("工作报告详情", automaticallyImplyLeading: true),
        body: workInfoDetail == null ? Center(
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
      multiTextField("报告分类", planTypeCon, isImportant: true, isReadOnly: true),
      multiTextField("报告名称", nameCon, isImportant: true, isReadOnly: true),
      multiTextField(
          "创建时间", createTimeCon, isImportant: true, isReadOnly: true),

      multiTextField(
          "评审人", approvalByCon, isImportant: false, isReadOnly: true),

    ],);
  }


  Widget checkProgressWidget() {
    if (wppList == null) return Container();
    List<Widget> listWidget = [];
    for (int i = 0; i < wppList.length; i++) {
      InfoNode infoNode = wppList[i];
      Widget widget = nodeItemWidget(infoNode);
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

  Widget nodeItemWidget(InfoNode infoNode) {
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
            Text(infoNode.title ?? "", style: Style.style,),
            Text(infoNode.opinion ?? "", style: Style.style,),
          ],)
      ],);
  }


}


