import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/pluginWarpper/flutterCallAndroid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


testTokenError() async {
  CRMAPI.logout();
}



class TestSettingsPage extends StatefulWidget {
  TestSettingsPage({Key key}) : super(key: key);
  @override
  _TestSettingsPageState createState() {
    return _TestSettingsPageState();
  }
}
class _TestSettingsPageState extends State<TestSettingsPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter和native通信"),
      ),
      body:Column(
        children: <Widget>[
          FlatButton(
            child: Text("调用native 接口"),
            onPressed: () async{
              await getJingwei();
            },
          ),
          NetError(),
        ],
      ),
    );
  }

}



























































