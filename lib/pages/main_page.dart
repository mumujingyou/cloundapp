import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/flutterPrint/flutterPrint.dart';
import 'package:cloundapp/pages/index/index.dart';
import 'package:cloundapp/pages/maillist/maillist.dart';
import 'package:cloundapp/pages/me/me.dart';
import 'package:cloundapp/pages/workstaion/workstation.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MainPage extends StatefulWidget {
  //static BuildContext context;

  @override
  MainPageState createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  static MainPageState instance;

  DateTime lastPopTime;
  int currentIndex = 0;


  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //MainPage.context = context;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          createItem("index", "首页"),
          createItem("workstation", "工作台", scale: 1.2),
          createItem("contract", "通讯录", scale: 1.1),
          createItem("me", "我的", scale: 1.1),

        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;

            if (index == 0) {
              if(isRefreash==true){
                isRefreash=false;
                indexKey.currentState.setState(() {
                  indexKey.currentState.loadData();
                });
              }
            }else if(index==2){
              isRefreash=true;
              mailKey.currentState.loadData();
            }else if(index==3){
              isRefreash=true;
              meKey.currentState.updateHeadImagUrl();
            }else{
              isRefreash=true;
            }
          });
        },
      ),
      body: WillPopScope( //返回键
          child: IndexedStack(
            index: currentIndex,
            children: <Widget>[Index(key:indexKey), WorkStation(), MailList(key: mailKey,), Me(key: meKey,)],
          ),
          onWillPop: _onWillPop),
    );
  }

bool isRefreash=false;
  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      Data.businessModel=null;
      Data.customerModel=null;
    }
    super.deactivate();
  }

  GlobalKey<IndexState> indexKey=new GlobalKey<IndexState>();
  GlobalKey<MeState> meKey=new GlobalKey<MeState>();
  GlobalKey<MailListState> mailKey=new GlobalKey<MailListState>();

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('退出程序?'),
        content: new Text('你确定要退出企业云吗？'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              '取消', style: TextStyle(color: Style.blueColor),),
          ),
          new FlatButton(
            onPressed: () async {
              await SystemChannels.platform
                  .invokeMethod('SystemNavigator.pop');
              return Navigator.of(context).pop(true);
            },
            child: new Text(
                '确认', style: TextStyle(color: Style.blueColor)),
          ),
        ],
      ),
    ) ??
        false;
  }
}


BottomNavigationBarItem createItem(String iconName, String title,
    {double scale = 1}) {
  return BottomNavigationBarItem(
      activeIcon: Image.asset(
        "assets/images/$iconName.png",
        width: 30,
        scale: scale,
      ),
      icon: Image.asset(
        "assets/images/${iconName}off.png",
        width: 30,
        scale: scale,

      ),
      title: Text(title));
}


