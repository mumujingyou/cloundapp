import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/circleShape.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/hr/ApplyDetailModel.dart';
import 'package:cloundapp/model/hr/CheckNodeModel.dart';
import 'package:cloundapp/model/oa/captialModel.dart';
import 'package:cloundapp/model/oa/supplyModel.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CapitalDetail extends StatefulWidget {
  final String id;

  const CapitalDetail({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CapitalDetailState();
  }

}


class CapitalDetailState extends State<CapitalDetail> {
  var nameCon = new TextEditingController();
  var busNoCon = new TextEditingController();
  var beginDateCon= new TextEditingController();
  var remarksCon= new TextEditingController();


  @override
  void initState() {
    getDetail();
    super.initState();
  }

  CapitalApply capitalApply;
  List<CapitalApplyItem> capitalApplyItems;
  CapitalApplyDetail capitalApplyDetail;

  getDetail() async {
    CapitalApplyDetail capitalApplyDetail = await OAAPI.capitalApplyDetail(id: widget.id);
    setState(() {
      this.capitalApplyDetail=capitalApplyDetail;
      this.capitalApply = capitalApplyDetail.capitalApply;
      this.capitalApplyItems=capitalApplyDetail.capitalApplyItems;


      nameCon.text=capitalApply.createName;
      beginDateCon.text=capitalApply.beginDate;
      busNoCon.text=capitalApply.busNo;
      remarksCon.text=capitalApply.remarks;

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("资产领用详情", automaticallyImplyLeading: true),
        body: capitalApplyDetail == null ? Center(
          child: CircularProgressIndicator(),) : ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          baseWidget(),
          showFrontInformation("领用物品"),
          items(),
          showFrontInformation("备注"),
          remarkContainer(controller: remarksCon, readOnly: true),
        ],)

    );
  }




  //请假
  Widget baseWidget() {
    return Column(children: <Widget>[
      multiTextField("编号", busNoCon, isImportant: false, isReadOnly: true),
      multiTextField("申请时间",beginDateCon , isImportant: false, isReadOnly: true),
      multiTextField(
          "领用人", nameCon, isImportant: false, isReadOnly: true),
    ],);
  }


  Widget createItem(CapitalApplyItem capitalApplyItem){
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Style.contentColor,
          padding: EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(capitalApplyItem.capitalName,style: Style.infoStyle,),
              Text("资产编号：${capitalApplyItem.capitalNo}",style: Style.style,),
              Text("领用数量：1",style: Style.style,),

            ],
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }


  Widget items(){
    List<Widget> list=List.generate(capitalApplyItems.length, (index){
      return createItem(capitalApplyItems[index]);
    });
    return Container(child: Column(children: list,),);
  }

}


