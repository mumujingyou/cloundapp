import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCustomerState();
  }

}


class AddCustomerState extends State<AddCustomer> {

  var nameCon = new TextEditingController();
  var companyCon = new TextEditingController();
  var phoneCon = new TextEditingController();
  var remarkCon = new TextEditingController();

  int customerTypeIndex = 0; //部门索引
  int customerType;

  @override
  void initState() {
    // TODO: implement initState
    customerType=getCustomerTypeInt(customerTypeList[customerTypeIndex]);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("新增客户", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          multiTextField("姓名",nameCon,isImportant: true,hint: "请输入姓名"),
          multiTextField("公司名称",companyCon,isImportant: false,hint: "请输入公司名称"),
          downArrowContainer(
              name: "客户类型", content: customerTypeList[customerTypeIndex] ?? "", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: customerTypeList,
                value: customerTypeList[customerTypeIndex],
                onConfirm: (picker, List value) {

                  setState(() {
                    customerTypeIndex = value[0]; //第几个
                    customerType=getCustomerTypeInt(customerTypeList[customerTypeIndex]);

                  });
                });
          }),
          showFrontInformation("联系信息"),
          multiTextField("电话",phoneCon,isImportant: true,hint: "请输入电话",textInputType: TextInputType.phone),
          showFrontInformation("其他信息"),
          multiTextField("备注",remarkCon,isImportant: false,hint: "请输入备注"),

          SizedBox(height: 20,),
          RoundedRectangleButton(
            name: "保存", width: 0, height: 50, function: save,)
        ],)

    );
  }

  Future save() async {

    if(ApplicationUtil.isChinaPhoneLegal(phoneCon.text)==false){
      Fluttertoast.showToast(msg:"电话号码不正确");
      return;
    }

    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.addCustomer(
          customerType: customerType.toString(),
          customerName: nameCon.text,
          corporateName: companyCon.text,
          phone: phoneCon.text,
          remarks: remarkCon.text,
          owners: Data.user.id.toString(),
          dept: Data.user.deptId.toString());
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