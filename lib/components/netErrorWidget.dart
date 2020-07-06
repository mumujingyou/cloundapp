import 'package:cloundapp/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class NetError extends StatefulWidget{
  final Function onPressed;

  const NetError({Key key, this.onPressed}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NetErrorState();
  }

}

class NetErrorState extends State<NetError>{

  bool isPlay=false;

  @override
  Widget build(BuildContext context) {

    return resultWidget();
  }

  Widget resultWidget(){
    if(isPlay){
      return loading();
    }else{
      return  netErrorWidget(onPressed: widget.onPressed);
    }
  }


  Widget loading(){
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20.0,
        animating: true,
      ),
    );
  }


  Widget netErrorWidget({Function onPressed,}){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("网络异常，请检查网络设置",style: TextStyle(color: Colors.grey),),
          SizedBox(height: 10,),
//          HuxingButton(string: "刷新",color: Style.blueColor,fontSize: 15,width: 60,height: 30,function: onPressed,),
          huxingButton(),
        ],
      ),
    );
  }

  Widget huxingButton(){
    return InkWell(child: Container(
      margin: EdgeInsets.only(left: 0, top: 0),
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: 30,
      width: 60,
      //边框设置
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        //设置四周边框
        border: new Border.all(width: 2, color:Style.blueColor ),
      ),
      child: Text("刷新", style: TextStyle(fontSize: 15, color: Style.blueColor),),
    ), onTap: (){
      widget.onPressed();
      setState(() {
        isPlay=true;
      });
      Future.delayed(Duration(seconds: 1),(){
        setState(() {
          isPlay=false;
        });
      });

    });
  }


}





class HuxingButton extends StatelessWidget {

  final double height;
  final double width;
  final Color color;
  final String string;
  final Function function;
  final double fontSize;

  const HuxingButton({Key key, this.height=25, this.width=60, this.color, this.string, this.function, this.fontSize=13}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(
      margin: EdgeInsets.only(left: 0, top: 0),
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: height,
      width: width,
      //边框设置
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        //设置四周边框
        border: new Border.all(width: 2, color: color),
      ),
      child: Text(string, style: TextStyle(fontSize: fontSize, color: color),),
    ), onTap: (){
      function();

    });
  }

}


