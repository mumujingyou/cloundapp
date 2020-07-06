import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/infoModel.dart';
import 'package:cloundapp/model/oa/noticeModel.dart';
import 'package:cloundapp/model/oa/planModel.dart';
import 'package:cloundapp/pages/workstaion/oa/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticeDetail extends StatefulWidget {
  final String id;

  const NoticeDetail({Key key, this.id,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NoticeDetailState();
  }

}


class NoticeDetailState extends State<NoticeDetail> {
  var nameCon = new TextEditingController(); //
  var remarksCon = new TextEditingController(); //
  var typeCon = new TextEditingController(); //
  var timeCon = new TextEditingController();
  var departmentCon = new TextEditingController();


  @override
  void initState() {
    getDetail();
    super.initState();
  }


  NoticeModel noticeModel;

  getDetail() async {
    NoticeModel noticeModel = await OAAPI.noticeDetail(id: widget.id);
    setState(() {
      this.noticeModel=noticeModel;
      nameCon.text=noticeModel.title;
      typeCon.text=noticeModel.typeName;
      departmentCon.text=noticeModel.deptName;
      timeCon.text=noticeModel.createTime;
      remarksCon.text=noticeModel.context;

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("信息公告详情", automaticallyImplyLeading: true),
        body: noticeModel == null ? Center(
          child: CircularProgressIndicator(),) : ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          detailWidget(),
          showFrontInformation("公告内容"),
          Container(
            padding: EdgeInsets.all(10),
            color: Style.contentColor,
            child: Html(data: remarksCon.text,
              defaultTextStyle: Style.style,),
          ),

        ],)

    );
  }


  //基本信息
  Widget detailWidget() {
    return Column(children: <Widget>[
      multiTextField("公告分类", typeCon, isImportant: true, isReadOnly: true),
      multiTextField("报告名称", nameCon, isImportant: true, isReadOnly: true),
      multiTextField("发布部门", departmentCon, isImportant: true, isReadOnly: true),
      multiTextField("发布时间", timeCon, isImportant: true, isReadOnly: true),

    ],);
  }



}


