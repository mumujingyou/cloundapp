import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/CircleAvatar.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/contactModel.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUserManager extends StatefulWidget {

  final String typeId;

  const ContactUserManager({Key key, this.typeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactUserManagerState();
  }
}

class ContactUserManagerState extends State<ContactUserManager> {
  List<ContactModel> lists = [];
  ContactListModel contactListModel;
  bool isEmpty = false;


  @override
  void initState() {
    getUserList(name: null);
    super.initState();
  }


  getUserList({String name}) async {
    ContactListModel contactListModel = await OAAPI.externalContactsList(
        typeId: widget.typeId, start: 0, length: 100, name: name);
    setState(() {
      this.contactListModel = contactListModel;
      this.lists = contactListModel.data;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
        "用户", automaticallyImplyLeading: true,),
      body: Column(children: <Widget>[
        SearchBarDemoPage(hint: "输入姓名", function: (value) {
          getUserList(name: value);
        },),
        Expanded(
          flex: 1,
          child: lists.length == 0 ? Center(
              child: isEmpty
                  ? new Text(Data.emptyListStr)
                  : new CircularProgressIndicator()) : ListView.builder(
            itemCount: lists.length,
            itemBuilder: (build, index) {
              return createItem(lists[index]);
            },),
        ),
      ],),

    );
  }

  Widget createItem(ContactModel contactModel) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            _showDialog(context, contactModel);
          },
          child: Container(
            color: Style.contentColor,
            padding: EdgeInsets.all(5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[

                  createCircleDefaultHeadImage(content: contactModel.name[0]),
                  SizedBox(width: 5,),
                  Column(
                    children: <Widget>[
                      Text(contactModel.name ?? "",
                        style: Style.infoStyle,),
                    ],
                  ),
                ],),
                Text(contactModel.phone, style: Style.style,)
              ],),
          ),
        ),
        Divider(height: 1, color: Colors.grey,)
      ],
    );
  }


  void _showDialog(BuildContext cxt, ContactModel contactModel) {
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
                    _launchPhone(contactModel);
                  },
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.phone,),
                      Text("呼叫 ${contactModel.phone}",
                        style: Style.redStyle,),
                    ],)),
            ],
          );
          return dialog;
        });
  }

  _launchPhone(ContactModel contactModel) async {
    String url = 'tel:${contactModel.phone}';



    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



}





