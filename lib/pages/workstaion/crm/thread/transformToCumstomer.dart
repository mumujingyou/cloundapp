import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransformToCustomer extends StatefulWidget{

  final ThreadModel threadModel;

  const TransformToCustomer({Key key, this.threadModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransformToCustomerState();
  }

}

class TransformToCustomerState extends State<TransformToCustomer>{

  var nameCon = new TextEditingController();
  var companyCon = new TextEditingController();
  var phoneCon = new TextEditingController();
  int customerTypeIndex=0;
  int customerType;
  ThreadModel threadModel;


  @override
  void initState() {
    customerTypeStr=customerTypeList[customerTypeIndex];
    customerType=getCustomerTypeInt(customerTypeStr);
    threadModel=widget.threadModel;

    nameCon.text=threadModel.clueName;
    companyCon.text=threadModel.corporateName;
    phoneCon.text=threadModel.mobilePhone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "转为客户", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          unimportantTextField("姓名", "请输入姓名", nameCon),
          unimportantTextField("公司名称", "请输入公司名称", companyCon),
          showFrontInformation("联系信息"),
          unimportantTextField("电话", "请输入电话", phoneCon,textInputType: TextInputType.phone),
          showFrontInformation("客户类型"),
          downArrowContainer(name: "客户类型", content: customerTypeStr, function: () {
            PickHelper.openSimpleDataPicker(
                context, list: customerTypeList, value:customerTypeList[customerTypeIndex] , onConfirm: (picker, List value) {

              setState(() {
                customerTypeIndex=value[0];
                customerTypeStr=picker.getSelectedValues()[0];
                customerType=getCustomerTypeInt(customerTypeStr);

              });
            });
          }),

          SizedBox(height: 20,),
          RoundedRectangleButton(name: "保存", width: 500, height: 50, function: save,)
        ],)

    );
  }


  void save(){
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.goTurnToCust(clueId: threadModel.id,corporateName: companyCon.text,customerName: nameCon.text,
      contactName: nameCon.text,customerType: customerType.toString(),phone: phoneCon.text,);
      if (result["data"]==true) {
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