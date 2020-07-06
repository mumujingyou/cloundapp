import 'dart:async';

import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  Timer timer;
  var count = 2;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(children: <Widget>[
        new Container(
          width: double.infinity,
          height: double.infinity,
          color: Style.blueColor,
        ),
        new Positioned(
          top: 30.0,
          right: 10.0,
          child: new FlatButton(
            child: new Text(
              '跳过 $count',
              style: new TextStyle(color: Colors.white),
            ),
            color: Color.fromARGB(55, 0, 0, 0),
            onPressed: () {
              goHomePage();
            },
          ),
        ),
        Align(
          child: Container(width:30,child:
          Text("群新科技 创造未来",textAlign:TextAlign.center ,style:
            TextStyle(color: Colors.white,fontSize: 35),)),
          alignment: new FractionalOffset(0.5, 0.3),
        ),
        Align(
          child: Image.asset(ApplicationUtil.getAssetsImagePath("qunxinlogo"),scale:6,),
          alignment: new FractionalOffset(0.5, 0.95),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Data.isLight=true;
    Data.isConnect=true;
    ApplicationUtil.listenNetChange();

    countDown();
    getUserInfo();
  }


  //倒计时
  void countDown() {
    timer = new Timer(new Duration(seconds: 1), () {
      // 只在倒计时结束时回调
      if (count != 0) {
        setState(() {
          count = count - 1;
          countDown();
        });
      } else {
        timer.cancel();
        goHomePage();
      }
    });
  }

//  跳转主页
  Future goHomePage() async {
    if(ApplicationUtil.connectStateDescription=="无网络"){
//      Fluttertoast.showToast(msg: "请连接网络");
      Data.isConnect=false;
    }

    _isLogin().then((value) {
      if (value == true) {
        Application.router.navigateTo(
            context, "${Routes.mainPage}",
            transition: TransitionType.fadeIn,replace:true);
      } else {

        Application.router.navigateTo(
            context, "${Routes.login}",
            transition: TransitionType.fadeIn,replace: true);
      }
    });
  }



  Future<bool> getUserInfo() async {
    SharedPreferences prefs=await API.getSharedPreferences();
    if(prefs!=null){

      String access_token=prefs.getString(Data.access_token);
      print("-------------$access_token");
      if(access_token!=null){
        API.access_token=access_token;
        User user= await CRMAPI.getUserInfo();
        if(user!=null){
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }

    }else{
      return false;
    }
  }


  //是否已经登录过
  Future<bool> _isLogin() async {

    bool result = API.prefs.getBool("isLogin");
    return result;
  }



}
