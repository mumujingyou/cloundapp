import 'package:flutter/material.dart';

//加号按钮

Widget getAddButton({Function function}) {
  return GestureDetector(
    child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Text(
          "+",
          style: TextStyle(fontSize: 20),
        ),
        alignment: Alignment.center),
    onTap: function
  );
}

//减号按钮
Widget decreaseBtn({Function function}) {
  return GestureDetector(
      child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Text(
            "-",
            style: TextStyle(fontSize: 20),
          ),
          alignment: Alignment.center),
      onTap: function
  );
}

//商品个数
Widget getGoodCount({TextEditingController controller,Function(String string) onChange}) {

  final length = controller.text.length;
  controller.selection = TextSelection(baseOffset:length , extentOffset:length);//保持光标移动到末尾

  return  Container(
      alignment: Alignment.center,
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey)),
      ),
      child: TextField(
        enabled: true,
        textAlign:TextAlign.center ,
        keyboardType: TextInputType.number,
        controller: controller,
        decoration:
        InputDecoration.collapsed(hintText: "", hasFloatingPlaceholder:false,
        //  filled: false,
        ),
        onChanged:onChange ,
      )
  );
}

//底部三个小控件
Widget getThreeWidget({Function add,Function decrease,TextEditingController controller,Function(String string) onChange}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      decreaseBtn(function: decrease),
      getGoodCount(controller: controller,onChange: onChange),
      getAddButton(function: add),
      SizedBox(
        width: 5,
      ),
    ],
  );
}