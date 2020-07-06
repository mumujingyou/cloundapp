import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';




class MyListTile extends StatelessWidget {
  final String tittle;
  final String imagePath;
  final Function function;

  MyListTile({this.tittle, this.imagePath, this.function});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(tittle, style: Style.infoStyle),
        leading: imagePath != null
            ? Image.asset(imagePath, width: 30,)
            : null,
        trailing: new Icon(Icons.keyboard_arrow_right),
        onTap: function,
      ),
      Divider(height: 1.0, color: Colors.grey,),

    ],);
  }
}


//引导控件
Widget frontWidget({String name,Function function}) {
  return InkWell(
    onTap:function,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          height: 50,
          color: Style.contentColor,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name,
                style: Style.style,),
              Icon(Icons.keyboard_arrow_right)
            ],),
        ),
        SizedBox(height: 5,)
      ],
    ),
  );
}
