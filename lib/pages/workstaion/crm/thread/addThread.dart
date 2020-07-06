import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddThread extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddThreadState();
  }

}


class AddThreadState extends State<AddThread> {

  var nameCon = new TextEditingController();
  var companyCon = new TextEditingController();
  var phoneCon = new TextEditingController();
  var remarkCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("新增线索", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          multiTextField("姓名",nameCon,isImportant: true,hint: "请输入姓名"),
          multiTextField("公司名称",companyCon,isImportant: false,hint: "请输入公司名称"),
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
      Map result = await CRMAPI.addClue(
          clueName: nameCon.text, corporateName: companyCon.text,
          mobilePhone: phoneCon.text, remarks: remarkCon.text,owners: Data.user.id.toString());
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