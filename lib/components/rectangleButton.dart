import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

//圆角矩形
class RoundedRectangleButton extends StatelessWidget {
  final Function function;
  final String name;
  final double width;
  final double height;
  final double fontSize;
  final Color color;
  final double circle;
  final double margin;

  const RoundedRectangleButton(
      {Key key, this.function, this.name, this.width = 300, this.height = 50, this.fontSize = 20, this.color, this.circle=5, this.margin=10,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.all(margin),
//        padding: EdgeInsets.all(margin),
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circle), color: color??Style.themeColor),
        child: Text(
          name, style: TextStyle(fontSize: fontSize, color: Colors.white),),
      ),
    );
  }
}
