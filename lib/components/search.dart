import 'package:cloundapp/data/data.dart';
import 'package:flutter/material.dart';
class SearchBarDemoPage extends StatefulWidget {

  final String hint;
  final Function(String) function;

  const SearchBarDemoPage({Key key, this.hint="请输入名字", this.function}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new SearchBarDemoPageState();
}

class SearchBarDemoPageState extends State<SearchBarDemoPage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void clear(){
    setState(() {
      controller.text="";
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Style.contentColor,
      child: Container(
        decoration: new BoxDecoration(
          //背景
          color: Theme.of(context).scaffoldBackgroundColor,
          //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          //设置四周边框
//        border: new Border.all(width: 2, color: color),
        ),
        height: 40,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 5.0,),
            Icon(Icons.search, color: Colors.grey,),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: TextField(
                  textInputAction:TextInputAction.search,
                  controller: controller,
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(top: 0.0),
                      hintText: widget.hint, border: InputBorder.none),
                  onSubmitted: widget.function,
                ),
              ),
            ),
            new IconButton(
              icon: new Icon(Icons.cancel),
              color: Colors.grey,
              iconSize: 18.0,
              onPressed: () {
                if(controller.text.isEmpty){
                  return;
                }
                controller.clear();
                widget.function(null);
              },
            ),
          ],
        ),
      ),
    );
  }

}