import 'dart:ui';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/CircleAvatar.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SelectUser extends StatefulWidget {

  final String deptId;
  final BaseClass baseClass;

  const SelectUser({Key key, this.deptId, this.baseClass}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SelectUserState();
  }
}

class SelectUserState extends State<SelectUser> {
  List<User> lists = [];

  BaseClass baseClass;
  bool isEmpty = false;

  @override
  void initState() {
    baseClass=widget.baseClass;
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
        "选择用户", automaticallyImplyLeading: true,),
      body: lists.length == 0 ? Center(child: Center(
          child: isEmpty
              ? new Text("亲，该部门下还没有用户呢")
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


  String _newValue = "";

  Widget createCustomer(User user) {
    return Column(
      children: <Widget>[
        RadioListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          value: user.name,
          title: Row(
            children: <Widget>[user?.headImgUrl==null?Image.asset("assets/images/head.png",scale: 2.5,):
            createCircleAvatar(path: user?.headImgUrl,),
            Text(user.name,style: Style.style,),
            SizedBox(width: 10,),

            ],),
          groupValue: _newValue,
          onChanged: (value) {
            setState(() {
              _newValue = value;
              goChangeClueOwners(user);
            });
          },
        ),
        Container(height: 1,color:Colors.grey),
      ],
    );
  }

  goChangeClueOwners(User user){
    if(baseClass is ThreadModel){//线索
      ThreadModel threadModel=baseClass as ThreadModel;
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await CRMAPI.goChangeClueOwners(ids: threadModel.id,owners: user.id.toString());
        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.of(context).popUntil(ModalRoute.withName(Routes.threadManager));

          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    }else if(baseClass is CustomerModel){//客户
      CustomerModel customerModel=baseClass as CustomerModel;
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await CRMAPI.customerTransfer(custIds: customerModel.id,owners: user.id.toString());
        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.of(context).popUntil(ModalRoute.withName(Routes.customerManager));
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    }else if(baseClass is BusinessModel){//商机
      BusinessModel businessModel=baseClass as BusinessModel;
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await CRMAPI.changeOwnersOpportunity(ids: businessModel.id,owners: user.id.toString());
        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.of(context).popUntil(ModalRoute.withName(Routes.businessManager));
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    }else if(baseClass is AgreementModel){//商机
      AgreementModel agreement=baseClass as AgreementModel;
      ApplicationUtil.showLoadingBool(context, () async {
        Map result = await CRMAPI.changeOwnersContract(ids: agreement.id,owners: user.id.toString());
        if (result["data"] == true) {
          Fluttertoast.showToast(msg: result["msg"]);
          Navigator.of(context).popUntil(ModalRoute.withName(Routes.agreementManager));
          return true;
        } else {
          Fluttertoast.showToast(msg: result["msg"]);
          return false;
        }
      });
    }


  }


}





