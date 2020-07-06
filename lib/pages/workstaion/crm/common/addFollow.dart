import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFollow extends StatefulWidget {
  final BaseClass baseClass;

  const AddFollow({Key key, this.baseClass}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AddFollowState();
  }

}


class AddFollowState extends State<AddFollow> {


  BaseClass baseClass;
  int followWayIndex=0;
  int followWay;
  int followStatusIndex=0;
  int followStatus;
  DateTime dateTime;
  DateTime nexDate;

  @override
  void initState() {
    // TODO: implement initState
    connectStatusStr=connectStatusList[followStatusIndex];
    followWayStr=followWayList[followWayIndex];
    dateTime=DateTime.now();
    nexDate=DateTime.now();
    followStatus=getConnectStatusInt(connectStatusStr);
    followWay=getFollowWayInt(followWayStr);

    baseClass=widget.baseClass;
    getNo();
    super.initState();
  }


  String followNo="";
  getNo() async {
    followNo=await CRMAPI.getNumber(type: 7);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
          "写跟进", automaticallyImplyLeading: true,),
        body: ListView(children: <Widget>[
          showFrontInformation("跟进内容"),
          remarkContainer(),
          showFrontInformation("跟进方式"),
          downArrowContainer(name: "跟进方式", content: followWayStr, function: () {
            PickHelper.openSimpleDataPicker(
                context, list: followWayList, value:followWayList[followWayIndex] , onConfirm: (picker, List value) {

              setState(() {
                followWayIndex=value[0];
                followWayStr=picker.getSelectedValues()[0];
                followWay=getFollowWayInt(followWayStr);
              });
            });
          }),
          showFrontInformation("跟进状态"),
          downArrowContainer(name: "跟进方式状态", content: connectStatusStr, function: () {
            PickHelper.openSimpleDataPicker(
                context, list: connectStatusList, value:connectStatusList[followStatusIndex] , onConfirm: (picker, List value) {

              setState(() {
                followStatusIndex=value[0];
                connectStatusStr=picker.getSelectedValues()[0];
                followStatus=getConnectStatusInt(connectStatusStr);

              });
            });
          }),
          showFrontInformation("下次跟进时间"),
          downArrowContainer(
              name: "下次跟进日期", content: "${ApplicationUtil.getTime(nexDate)}", function: () {
            PickHelper.openDateTimePicker(context,title: "选择时间", onConfirm: (Picker picker, List value) {

              setState(() {
                nexDate=(picker.adapter as DateTimePickerAdapter).value;
                
              });
            });
          }),
          SizedBox(height: 20,),
          RoundedRectangleButton(
            name: "保存", width: 500, height: 50, function:save,)
        ],)
    );
  }

  var remarkCon = new TextEditingController();

  Widget remarkContainer() {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
              height: 200,
              padding: EdgeInsets.all(5),
              color: Style.contentColor,
              child: TextField(
                maxLength: 100,
                maxLines: 7,
                controller: remarkCon,
                decoration:
                InputDecoration(border: InputBorder.none, hintText: "勤跟进，多签单"),
              )
          ),
          Align(

            child:  RoundedRectangleButton(
              fontSize: 15,
              name: "实际跟进时间：${ApplicationUtil.getTime(dateTime)}", width: 250, height: 30, function: () {
              PickHelper.openDateTimePicker(context,title: "选择时间", onConfirm: (Picker picker, List value) {
                setState(() {
                  dateTime=(picker.adapter as DateTimePickerAdapter).value;
                });
              });

            },),
            alignment: new FractionalOffset(0, 1),
          ),
        ],
      ),
    );
  }

  // type跟进类型 4001、线索 4002、客户 4003、联系人 4004、商机 4005、合同
  void save(){

    //String followNo="";
    String source="";
    String sourceName="";
    String owner="";
    String type="";

    if(baseClass is ThreadModel){
      ThreadModel threadModel=baseClass as ThreadModel;
      source=threadModel.id;
      sourceName=threadModel.clueName;
      owner= threadModel.owners;
      type="4001";
    }else if(baseClass is CustomerModel){
      CustomerModel customerModel=baseClass as CustomerModel;
      source=customerModel.id;
      sourceName=customerModel.customerName;
      owner= customerModel.owners;
      type="4002";
    }else if(baseClass is BusinessModel){
      BusinessModel businessModel=baseClass as BusinessModel;
      source=businessModel.id;
      sourceName=businessModel.oppoName;
      owner= businessModel.owners;
      type="4004";
    }else if(baseClass is AgreementModel){
      AgreementModel agreementModel=baseClass as AgreementModel;
      source=agreementModel.id;
      sourceName=agreementModel.contractName;
      owner= agreementModel.ownersid;

      type="4005";
    }

    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.addFollow(date: ApplicationUtil.getTime(dateTime),nextTime: ApplicationUtil.getTime(nexDate),
          followNo:followNo ,status:followStatus.toString() ,
          way:followWay.toString() ,type: type,
          remark: remarkCon.text,source: source,sourceName:sourceName,owner: owner);
      if (result["data"]==true) {
        Fluttertoast.showToast(msg: result["msg"]);
        Navigator.pop(context);
        return true;
      } else {
        Fluttertoast.showToast(msg: result["msg"]);
        return false;
      }
    });

  }



}