import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() {
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePassword> {
  var curentPassWord = new TextEditingController();
  var newPassWord = new TextEditingController();
  var anginNewPassWord = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:createAppBar("修改密码",automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            createTextField(curentPassWord, "请输入当前密码"),
            createTextField(newPassWord, "请输入新密码"),
            createTextField(anginNewPassWord, "请再次输入新密码"),
            RoundedRectangleButton(
              color: Style.themeColor,
              name: "保存",
              function: onLogin,
            )
          ],
        ),
      ),
    );
  }

  Widget createTextField(TextEditingController controller, String hint) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Style.contentColor),
          child: TextField(

            enableInteractiveSelection: false,//是否显示粘贴，复制，剪切
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
              controller: controller,
              obscureText: true),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }


  Future onLogin() async {

    if(isCanChange()==false){
      return;
    }


      ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.updatePW(oldPW:curentPassWord.text,
          newPW: newPassWord.text);
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





  bool isCanChange() {
    if (newPassWord.text != anginNewPassWord.text) {
      Fluttertoast.showToast(msg: "两次输入新密码不一致，请重新输入");
      return false;
    }
    return true;
  }
}
