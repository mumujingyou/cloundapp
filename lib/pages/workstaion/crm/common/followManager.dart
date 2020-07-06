import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/FollowModel.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addFollow.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
//跟进列表
class FollowManager extends StatefulWidget {


  final BaseClass baseClass;

  const FollowManager({Key key, this.baseClass}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FollowManagerState();
  }

}

class FollowManagerState extends State<FollowManager> {

  List<FollowModel> followList = [];
  String type;
  String source;
  BaseClass baseClass;

  @override
  void initState() {
    baseClass = widget.baseClass;
    super.initState();


    getFollowList();
  }

  //跟进类型 4001、线索 4002、客户 4003、联系人 4004、商机 4005、合同
  getFollowList() async {
    if (baseClass is ThreadModel) {
      ThreadModel threadModel = baseClass as ThreadModel;
      type = "4001";
      source = threadModel.id;
    }else if(baseClass is CustomerModel) {
      CustomerModel customerModel = baseClass as CustomerModel;
      type = "4002";
      source = customerModel.id;
    }else if(baseClass is BusinessModel) {
      BusinessModel businessModel = baseClass as BusinessModel;
      type = "4004";
      source = businessModel.id;
    }else if(baseClass is AgreementModel) {
      AgreementModel agreementModel = baseClass as AgreementModel;
      type = "4005";
      source = agreementModel.id;
    }
    List<FollowModel> followList = await CRMAPI.getFollowList(
        type: type, source: source);
    setState(() {
      this.followList = followList;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
        "跟进记录", automaticallyImplyLeading: true,),
      body: Column(children: <Widget>[
        Expanded(
          flex: 1, child: ListView.builder(itemBuilder: (context,index){
            return followRecordItem(followList[index]);
        },itemCount:followList.length,)),
        RoundedRectangleButton(
          name: "写跟进",
          width: 500,
          height: 50,
          margin: 0,
          circle: 0,
          function: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (BuildContext context) {
              return new AddFollow(baseClass: baseClass,);
            }));
          },)

      ],),

    );
  }

  Widget followRecordItem(FollowModel followModel) {
    return Container(
//      height: 210,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 40,),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(followModel.createTime,
                        style: Style.style,),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Text(followModel.createName,
                            style: Style.style,),
                          SizedBox(width: 20,),
                          Text(getFollowWayStr(followModel),
                            style: Style.style,),

                        ],
                      ),
                      Html(data: followModel.remark,
                        defaultTextStyle: Style.style,),
                      Text("${getStr()} ${followModel.sourceName}",
                        style: Style.style,),
                    ],),
                  decoration: new BoxDecoration(
                    border: new Border.all(
                        color: Style.themeColor, width: 0.5),
                    //color: Colors.white, // 底色
                  ),
                ),
              ),
            ],
          ),
        Positioned(child: Icon(Icons.alarm, color: Style.themeColor,),
        left: 28,top: 15,),
          Positioned(child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: Style.themeColor,
              shape: BoxShape.circle,
            ),
          ),
            left: 35,top: 55,),
        ],
      ),
    );
  }

  String getStr(){
    if(baseClass is ThreadModel){
      return "来自线索";
    }else if(baseClass is CustomerModel){
      return "来自客户";
    }else if(baseClass is BusinessModel){
      return "来自商机";
    }else if(baseClass is AgreementModel){
      return "来自合同";
    }
    return "";
  }


  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      followList.clear();
      getFollowList();
    }
    super.deactivate();
  }


}
