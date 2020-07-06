import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';

import 'package:cloundapp/pages/workstaion/crm/common/DepartmentManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addFollow.dart';
import 'package:cloundapp/pages/workstaion/crm/common/followManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/productManager.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';

import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AgreementEdit extends StatefulWidget {
  final String id;

  const AgreementEdit({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AgreementEditState();
  }

}

class AgreementEditState extends State<AgreementEdit> {

  var nameCon = new TextEditingController();
  var amountCon = new TextEditingController();
  var remarkCon = new TextEditingController();
  var ourSignerCon = new TextEditingController();
  var customerSignerCon = new TextEditingController();
  int followStatusIndex = 0;
  int followStatus;


  String time;
  CustomerModel customer;
  AgreementModel agreementModel;


  @override
  void initState() {
    // TODO: implement initState
    getDetail();

    super.initState();
  }

  getDetail() async {

    AgreementModel agreementModel=await CRMAPI.viewContract(id:widget.id);
    setState(() {
      this.agreementModel=agreementModel;
      nameCon.text=agreementModel.contractName;
      amountCon.text=agreementModel.amount.toString();
      ourSignerCon.text=agreementModel.ourSigner.toString();
      customerSignerCon.text=agreementModel.customerSigner.toString();
      time=agreementModel.contractDate;
    });
    agreementTypesStr=getAgreementTypesStr(int.parse(agreementModel.followStatus));
    followStatus=int.parse(agreementModel.followStatus);

  }



  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "合同编辑", automaticallyImplyLeading: true,),
        body:agreementModel==null?Center(child: new CircularProgressIndicator(),): ListView(children: <Widget>[

          showFrontInformation("基本信息"),
          unimportantText(name:"合同编号",isImportant: true, content:agreementModel.contractNo),
          unimportantText(name:"对应商机",isImportant: true, content:agreementModel.oppoName),
          unimportantText(name:"对应客户",isImportant: true, content:agreementModel.clientName),

          importantTextField("合同标题", "请输入商机标题", nameCon),
          importantTextField("合同总金额", "请输入合同总金额", amountCon,textInputType: TextInputType.number),

          importantTextField("我方签约人", "请输入我方签约让人", ourSignerCon),
          importantTextField("客户方签约人", "请输入客户方签约人", customerSignerCon),

          downArrowContainer(isImportant: true,
              name: "跟进状态", content: agreementTypesStr ?? "", function: () {
                PickHelper.openSimpleDataPicker(
                    context, list: agreementTypes,
                    value: agreementTypes[followStatusIndex],
                    onConfirm: (picker, List value) {

                      setState(() {
                        followStatusIndex = value[0]; //第几个
                        agreementTypesStr=picker.getSelectedValues()[0];
                        followStatus=getAgreementTypesInt(agreementTypesStr);

                      });
                    });
              }),
          downArrowContainer(isImportant: true,
              name: "签单日期", content: time??"", function: () {
                PickHelper.openDateTimePicker(context,title: "选择时间", onConfirm: (Picker picker, List value) {
                  setState(() {
                    time=ApplicationUtil.getTime((picker.adapter as DateTimePickerAdapter).value);
                  });
                },value: DateTime.parse(time));
              }),
//
//          //"${Routes.threadDetail}?id=${threadModel.id}"
          showFrontInformation("所属部门"),
          unimportantText(name:"部门",content: agreementModel?.ownersDept??""),
          showFrontInformation("负责人"),
          unimportantText(name:"负责人",content: agreementModel?.owners??""),

          SizedBox(height: 20,),
          RoundedRectangleButton(name: "保存", width: 500, height: 50, function: save,)
        ],)

    );
  }




  Future save() async {

    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.editContract(
        id: agreementModel.id,
        contractNo: agreementModel.contractNo,
        customerSigner: customerSignerCon.text,
        ourSigner: ourSignerCon.text,
        opportunity: agreementModel.opportunity,
        client:agreementModel.client ,
        contractName: nameCon.text,
        amount: amountCon.text,
        contractDate: time,
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







}
