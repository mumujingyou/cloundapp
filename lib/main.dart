import 'dart:async';
import 'dart:convert';

import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/eventBus/eventBus.dart';
import 'package:cloundapp/pages/other/SplashPage.dart';
import 'package:cloundapp/pages/other/login_page.dart';
import 'package:cloundapp/pages/other/noPage.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/data.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  errorWidget();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])//强制竖屏显示
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }

}



class MyAppState extends State<MyApp>{


  StreamSubscription subscription;
  @override
  void initState() {

    //创建路由对象
    final router = Router();
    //配置路由集Routes的路由对象
    Routes.configureRoutes(router);
    //指定Application的路由对象
    Application.router = router;

    getIsLight();

//    //监听CustomEvent事件，刷新UI
    subscription = Data.themeEventBus.on<ThemeEventBus>().listen((event) {
      setState(() {

      });
    });
    super.initState();
  }

  //获取是否是光暗模式
  Future getIsLight() async {
    SharedPreferences prefs=await API.getSharedPreferences();
    bool isLight=prefs.getBool("isLight")??true;
    setState(() {
      Data.isLight=isLight;
      Style.changeIsLight();

    });
  }

  @override
  void dispose() {
    subscription.cancel();//State销毁时，清理注册
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '企业云平台',
      theme: Data.isLight?_buildLightTheme():_buildDarkTheme(),
      debugShowCheckedModeBanner: false,//去掉右上角的debug
      //生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
      onGenerateRoute: Application.router.generator,
      navigatorKey: Application.navigatorKey, //设置在这里

      //主页指定为第一个页面
      home: SplashPage(),
    );
  }


  ThemeData _buildLightTheme() {
    Color primaryColor =Style.themeColor;
    ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Style.bgcolor,
    );

  }

  ThemeData _buildDarkTheme() {

    Color darkColor =Color.fromARGB(255, 59, 59, 59);//主题颜色

    ThemeData base = ThemeData.dark();
    CupertinoThemeData cupertinoThemeData=CupertinoThemeData();
    return base.copyWith(

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Style.themeColor,
        foregroundColor: Colors.white
      ),
      dialogTheme: DialogTheme().copyWith(backgroundColor: darkColor),
      accentColor: Style.blueColor,//蓝色
      primaryColor: darkColor,
      scaffoldBackgroundColor: darkColor,
    );
  }
}

//出现错误爆红处理
errorWidget(){
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return NoPage();
  };

}





