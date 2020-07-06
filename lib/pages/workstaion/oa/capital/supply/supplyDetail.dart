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
import 'package:cloundapp/model/oa/supplyModel.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SupplyDetail extends StatefulWidget {
  final String id;

  const SupplyDetail({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SupplyDetailState();
  }

}


class SupplyDetailState extends State<SupplyDetail> {
  var nameCon = new TextEditingController();
  var busNoCon = new TextEditingController();
  var beginDateCon= new TextEditingController();
  var remarksCon= new TextEditingController();


  @override
  void initState() {
    getDetail();
    super.initState();
  }

  SuppliesApply suppliesApply;
  List<SuppliesApplyItem> suppliesApplyItems;
  SupplyApplyDetail supplyApplyDetail;

  getDetail() async {
    SupplyApplyDetail supplyApplyDetail = await OAAPI.suppliesApplyDetail(id: widget.id);
    setState(() {
      this.supplyApplyDetail=supplyApplyDetail;
      this.suppliesApply = supplyApplyDetail.suppliesApply;
      this.suppliesApplyItems=supplyApplyDetail.suppliesApplyItems;


      nameCon.text=suppliesApply.createName;
      beginDateCon.text=suppliesApply.beginDate;
      busNoCon.text=suppliesApply.busNo;
      remarksCon.text=suppliesApply.remarks;

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("用品领用详情", automaticallyImplyLeading: true),
        body: supplyApplyDetail == null ? Center(
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


  Widget createItem(SuppliesApplyItem suppliesApplyItem){
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Style.contentColor,
          padding: EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(suppliesApplyItem.suppliesName,style: Style.infoStyle,),
              Text("库存数量：${suppliesApplyItem.quantity}",style: Style.style,),
              Text("领用数量：${suppliesApplyItem.amount}",style: Style.style,),
              Text("领用备注：${suppliesApplyItem.remarks}",style: Style.style,),
            ],
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }


  Widget items(){
    List<Widget> list=List.generate(suppliesApplyItems.length, (index){
      return createItem(suppliesApplyItems[index]);
    });
    return Container(child: Column(children: list,),);
  }

}


