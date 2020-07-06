import 'dart:async';

import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/eventBus/eventBus.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/pages/workstaion/crm/business/businessManager.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerBusinessManager.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';


enum AddAgreementType{
  None,
  Customer,
  Business,
}

class AddAgreement extends StatefulWidget {
  final bool isEmpty;
  final AddAgreementType addAgreementType;

  const AddAgreement({Key key, this.isEmpty=true, this.addAgreementType=AddAgreementType.None}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AddAgreementState();
  }

}


class AddAgreementState extends State<AddAgreement> {

  var nameCon = new TextEditingController();
  var amountCon = new TextEditingController();
  var remarkCon = new TextEditingController();
  var ourSignerCon = new TextEditingController();
  var customerSignerCon = new TextEditingController();

  int followStatusIndex = 0;
  int followStatus;


  @override
  void initState() {
    // TODO: implement initState
    followStatus=getAgreementTypesInt(agreementTypes[followStatusIndex]);

    dateTime=DateTime.now();
    getNumber();



    super.initState();
  }

  String contractNo="";
  getNumber() async {
    String ctNo=await CRMAPI.getContractualNo();
    setState(() {
      this.contractNo=ctNo;
    });
  }


  DateTime dateTime;
  BusinessModel businessModel;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: createAppBar("新增合同", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          unimportantText(name:"合同编号",isImportant: true, content:contractNo),
          getWidget(),

          importantTextField("合同标题", "请输入合同标题", nameCon),
          importantTextField("合同总金额", "请输入合同总金额", amountCon,textInputType: TextInputType.number),

          importantTextField("我方签约人", "请输入我方签约约人", ourSignerCon),
          importantTextField("客户方签约人", "请输入客户方签约人", customerSignerCon),







        downArrowContainer(isImportant: true,
            name: "签约日期", content: "${ApplicationUtil.getTime(dateTime)}", function: () {
          PickHelper.openDateTimePicker(context,title: "选择时间", onConfirm: (Picker picker, List value) {
            setState(() {
              dateTime=(picker.adapter as DateTimePickerAdapter).value;

            });
          });
        }),
          downArrowContainer(isImportant: true,
              name: "跟进状态", content: agreementTypes[followStatusIndex] ?? "", function: () {
                PickHelper.openSimpleDataPicker(
                    context, list: agreementTypes,
                    value: agreementTypes[followStatusIndex],
                    onConfirm: (picker, List value) {

                      setState(() {
                        followStatusIndex = value[0]; //第几个
                        followStatus=getAgreementTypesInt(agreementTypes[followStatusIndex]);

                      });
                    });
              }),
          showFrontInformation("其他信息"),
          unimportantTextField("备注", "请输入备注", remarkCon),
          SizedBox(height: 20,),
          RoundedRectangleButton(
            name: "保存", width: 0, height: 50, function: save,)
        ],)

    );
  }

  Future save() async {
    if(businessModel==null){
      Fluttertoast.showToast(msg:"商机不能为空");
      return;
    }
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.addContract(
        contractNo: contractNo,
          customerSigner: customerSignerCon.text,
          ourSigner: ourSignerCon.text,
          opportunity: businessModel?.id,
          client:businessModel?.client ,
          contractName: nameCon.text,
          amount: amountCon.text,
          contractDate: ApplicationUtil.getTime(dateTime),
          followStatus: followStatus.toString(),
          remarks: remarkCon.text,);

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


  Widget getWidget(){
    if(widget.addAgreementType==AddAgreementType.None){
      return Container(child: Column(children: <Widget>[
        turnToRightWidgetContent(name: "对应商机",content: businessModel?.oppoName??"",isImportant: true,function: (){
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return new BusinessManager(isCanPop: true,);
          })).then((value){
            businessModel=value;
          });
        }),
        unimportantText(name:"对应客户",isImportant: true, content: businessModel?.clientName??""),
      ],),);
    }else if(widget.addAgreementType==AddAgreementType.Business){
      businessModel=Data.businessModel;
      return Container(child: Column(children: <Widget>[
        unimportantText(name:"对应商机",isImportant: true, content: businessModel?.oppoName??""),

        unimportantText(name:"对应客户",isImportant: true, content: businessModel?.clientName??""),

      ],),);
    }else if(widget.addAgreementType==AddAgreementType.Customer){
      return Container(child: Column(children: <Widget>[
        turnToRightWidgetContent(name: "对应商机",content: businessModel?.oppoName??"",isImportant: true,function: (){
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return new CustomerBusinessManager(id:Data.customerModel?.id,owners:Data.user.id.toString(),isCanPop: true,);
          })).then((value){
            businessModel=value;
          });
        }),
        unimportantText(name:"对应客户",isImportant: true, content: businessModel?.clientName??""),
      ],),);
    }
    return Container();
  }

}