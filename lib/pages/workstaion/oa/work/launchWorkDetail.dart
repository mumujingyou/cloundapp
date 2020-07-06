import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/workDetailWidget.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

class LaunchWorkDetail extends StatefulWidget {
  final String id;
  final String type;


  const LaunchWorkDetail({Key key, this.id, this.type}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return LaunchWorkDetailState();
  }

}


class LaunchWorkDetailState extends State<LaunchWorkDetail> {

  @override
  void initState() {
  getDetail(state: this,id: widget.id,type: widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("申请详情", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[
          getResultWidget(),
        ],)

    );
  }

}


