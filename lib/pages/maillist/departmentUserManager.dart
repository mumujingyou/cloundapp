import 'dart:ui';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/CircleAvatar.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DepartmentUserManager extends StatefulWidget {

  final String deptId;

  const DepartmentUserManager({Key key, this.deptId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DepartmentUserManagerState();
  }
}

class DepartmentUserManagerState extends State<DepartmentUserManager> {
  List<User> lists = [];
  bool isEmpty = false;

  @override
  void initState() {
    getUserList();
    super.initState();
  }


  getUserList() async {
    List<User> list=await CRMAPI.getAllUserListFilter(deptId: widget.deptId);
    setState(() {
      this.lists=list;
      if(lists.length==0){
        isEmpty=true;
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
        "用户", automaticallyImplyLeading: true,),
      body: lists.length == 0 ? Center(child: Center(
          child: isEmpty
              ? new Text(Data.emptyListStr)
              : new CircularProgressIndicator()),) : ListView(children: getListView(),),

    );
  }

  List<Widget> getListView() {
    List<Widget> list = [];
    for (int i=0;i<lists.length;i++) {
    list.add(createCustomer(lists[i]));
    }
    return list;
  }



  Widget createCustomer(User user) {
  return Column(
    children: <Widget>[
      InkWell(
        onTap: (){
          _showDialog(context,user);
        },
        child: Container(
          color: Style.contentColor,
          padding: EdgeInsets.all(5),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Row(children: <Widget>[
              user?.headImgUrl==null?createCircleAvatarDefault():
              createCircleAvatar(path: user?.headImgUrl),
              SizedBox(width: 5,),
              Column(
                children: <Widget>[
                  Text(user.name??"",style: Style.infoStyle,),
                ],
              ),
            ],),
            Text(user.phone,style: Style.style,)
          ],),
        ),
      ),
      Divider(height: 1,color: Colors.grey,)
    ],
  );
  }


  void _showDialog(BuildContext cxt,User user) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(cxt, 0);
                },
                child: Text("取消")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(cxt).pop();
                    _launchPhone(user);
                  },
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Icon(Icons.phone,),
                    Text("呼叫 ${user.phone}",style: Style.redStyle,),
                  ],)),
            ],
          );
          return dialog;
        });
  }

  _launchPhone(User user) async {
    String url = 'tel:${user.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }






}





