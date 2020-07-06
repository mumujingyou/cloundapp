import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';


Widget unimportantTextField(String name, String hint,
    TextEditingController controller,
    {TextInputType textInputType = TextInputType.text}) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Style.contentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(name, style: Style.textStyle,),
            Container(
              width: Style.textFieldWidth,
              child: TextField(
                keyboardType: textInputType,
                controller: controller,
                decoration:
                InputDecoration(border: InputBorder.none, hintText: hint),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 2,)
    ],
  );
}

Widget importantTextField(String name, String hint,
    TextEditingController controller,
    {TextInputType textInputType = TextInputType
        .text, bool isReadOnly = false}) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Style.contentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(style: TextStyle(fontSize: 18), children: [
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 15)),
                TextSpan(
                    text: name,
                    style: Style.textStyle),

              ]),
              textDirection: TextDirection.ltr,
            ),
            Container(
              width: Style.textFieldWidth,
              child: TextField(
                readOnly: isReadOnly,
                keyboardType: textInputType,
                controller: controller,
                decoration:
                InputDecoration(border: InputBorder.none, hintText: hint),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 2,)
    ],
  );
}

//万能输入框(是否重要   是否可以输入)
Widget multiTextField(String name,
    TextEditingController controller,
    {TextInputType textInputType = TextInputType.text, bool isReadOnly = false,
      double width = Style
          .textFieldWidth, String hint, bool isImportant}) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Style.contentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(style: TextStyle(fontSize: 18), children: [
                TextSpan(
                    text: isImportant ? "*" : "",
                    style: TextStyle(color: Colors.red, fontSize: 15)),
                TextSpan(
                    text: name,
                    style: Style.textStyle),

              ]),
              textDirection: TextDirection.ltr,
            ),
            Container(
              width: width,
              child: TextField(
                maxLines: null,
                readOnly: isReadOnly,
                keyboardType: textInputType,
                controller: controller,
                decoration:
                InputDecoration(border: InputBorder.none, hintText: hint),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 2,)
    ],
  );
}


Widget downArrowContainer(
    {Function function, String content, String name, bool isImportant = false}) {
  return Column(
    children: <Widget>[
      InkWell(
        onTap: function,
        child: Container(
          padding: EdgeInsets.all(10),
          color: Style.contentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(style: TextStyle(fontSize: 18), children: [
                  TextSpan(
                      text: isImportant ? "*" : "",
                      style: TextStyle(color: Colors.red, fontSize: 15)),
                  TextSpan(
                      text: name,
                      style: Style.textStyle),

                ]),
                textDirection: TextDirection.ltr,
              ),
              Container(width: Style.textFieldWidth,
                child: Row(
                  children: <Widget>[
                    Text(content ?? "",
                      style: Style.textStyle,),
                    Expanded(flex: 1, child: Container(),),
                    new Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 2,)

    ],
  );
}


Widget unimportantText(
    {String name, String content, double width = Style
        .textFieldWidth, bool isImportant = false,}) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Style.contentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(style: TextStyle(fontSize: 18), children: [
                TextSpan(
                    text: isImportant ? "*" : "",
                    style: TextStyle(color: Colors.red, fontSize: 15)),
                TextSpan(
                    text: name,
                    style: Style.textStyle),

              ]),
              textDirection: TextDirection.ltr,
            ),
            Container(
              width: width,
              child: TextField(
                readOnly: true,
                decoration:
                InputDecoration(border: InputBorder.none, hintText: content,
                    hintStyle: Style.textStyle),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 2,)
    ],
  );
}


Widget turnToRightWidget({Function function, String name, String content}) {
  return Column(
    children: <Widget>[
      InkWell(
          onTap: function,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Style.contentColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(name, style: Style.textStyle,),
                new Icon(Icons.keyboard_arrow_right),
              ],),
          )
      ),
      SizedBox(height: 2,)

    ],
  );
}


Widget turnToRightWidgetContent(
    {Function function, String name, String content, bool isImportant = false}) {
  return Column(
    children: <Widget>[
      InkWell(
        onTap: function,
        child: Container(
          padding: EdgeInsets.all(10),
          color: Style.contentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(style: TextStyle(fontSize: 18), children: [
                  TextSpan(
                      text: isImportant ? "*" : "",
                      style: TextStyle(color: Colors.red, fontSize: 15)),
                  TextSpan(
                      text: name,
                      style: Style.textStyle),

                ]),
                textDirection: TextDirection.ltr,
              ),
              Container(
                width: Style.textFieldWidth,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(content, style: Style.textStyle,),
                    new Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 2,)
    ],
  );
}

Widget remarkContainer({TextEditingController controller,String hint,bool readOnly=false,double height}){
  return  Container(
      height: height,
      padding: EdgeInsets.all(5),
      color:Style.contentColor,
      child: TextField(
        maxLines: null,
        readOnly: readOnly,
        controller: controller,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: hint,),
      )
  );
}




