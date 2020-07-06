import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/serve/http_serve.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var usernameController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SharedPreferences prefs=await API.getSharedPreferences();
    if(prefs!=null){
      setState(() {
        usernameController.text=API.prefs.getString(Data.username);
        passwordController.text=API.prefs.getString(Data.password);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: createAppBar("登录账号",automaticallyImplyLeading: false),

    body: Container(
        width: double.infinity,
        height: 500,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "请输入账号",
                ),
                controller: usernameController,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(

                decoration: InputDecoration(hintText: "请输入密码"),
                obscureText: true,
                controller: passwordController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedRectangleButton(
              color: Style.themeColor,
              name: "登录",
              function: () {
                onLogin();
              },
            ),

          ],
        ),
      ),
    );
  }





  Future onLogin() async {

    if (usernameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "用户名不能为空哦");
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "密码不能为空哦");
    } else {
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await CRMAPI.login(username:usernameController.text,
            password: passwordController.text);
        if (result["data"]==true) {
          _saveData().then((value) {
            if (value == true) {
              Fluttertoast.showToast(msg: result["msg"]);
              Navigator.pop(context);
              Application.router.navigateTo(context, "${Routes.mainPage}",
                  transition: TransitionType.fadeIn);
              return true;
            }else{
              return false;
            }
          });
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    }
  }
  _saveData() async {
    API.prefs.setString(Data.username, usernameController.text);
    API.prefs.setString(Data.password, passwordController.text);
    API.prefs.setBool(Data.isLogin, true);
    User user= await CRMAPI.getUserInfo();
    if(user!=null){
      return true;
    }else{
      return false;
    }
  }
}
