import 'dart:async';

import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/eventBus/eventBus.dart';
import 'package:cloundapp/model/crm/UndoApplyCountModel.dart';
import 'package:cloundapp/model/hr/AttendanceInfo.dart';
import 'package:cloundapp/model/oa/noticeModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/pluginWarpper/flutterCallAndroid.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class Index extends StatefulWidget {



  const Index({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return IndexState();
  }
}

class IndexState extends State<Index> {
  String threadNumberStr = "0";
  String customerNumberStr = "0";
  String businessNumberStr = "0";
  String agreementNumberStr = "0";


  @override
  void initState() {
    listenConnectNet();

    loadData();
    super.initState();
  }

  Future loadData() async {
    if(Data.isNetUse){
      await getTodayAdd();
      await getUndoApplyCount();
      await getNoticeList();
      await getAttendanceList();

    }else{
      await getNoticeList();
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: createAppBar("首页"),
      body: Column(
        children: <Widget>[
          isConnectWidget(),
          Data.isNetUse==true?Expanded(
            flex: 1,
            child: RefreshIndicator(
              color: Style.themeColor,

              child: ListView(
                children: <Widget>[

                  item(tittleName: "我的待办",
                    color: Data.isLight?Color.fromARGB(255, 165, 217, 255):
                    Color.fromARGB(255, 179, 179, 179),
                    content: undoApplyCountWidget(),),
                  item(tittleName: "今日新增",
                    color: Data.isLight?Style.themeColor:
                    Color.fromARGB(255, 93, 93, 93),
                    content: todayAddWidget(),),
                  item(tittleName: "我的打卡",
                    color: Data.isLight?Color.fromARGB(255, 165, 217, 255):
                    Color.fromARGB(255, 179, 179, 179),
                    content: myAttendanceWidget(),),
                  item(tittleName: "公告信息",
                    color: Data.isLight?Style.themeColor:
                    Color.fromARGB(255, 93, 93, 93),
                    content: noticeWidget(),),
                  RoundedRectangleButton(
                    color: Style.themeColor,
                    name: "测试",
                    function: () {
                      Application.router.navigateTo(context,Routes.test,);
                    },
                  ),

                ],
              ), onRefresh: () async {
              await loadData();
            },
            ),
          ):Expanded(flex: 1,child: Center(child: NetError(onPressed: () async {
        loadData();
      }),),),
        ],
      ),
    );
  }

  getTodayAdd() async {
    String threadNumberStr = await CRMAPI.selectClueNumber();
    setState(() {
      this.threadNumberStr = threadNumberStr;
    });
    String customerNumberStr = await CRMAPI.selectCustomerNumber();

    setState(() {
      this.customerNumberStr = customerNumberStr;
    });
    String businessNumberStr = await CRMAPI.selectOpportunityNumber();
    setState(() {
      this.businessNumberStr = businessNumberStr;
    });
    String agreementNumberStr = await CRMAPI.selectContractNumber();
    setState(() {
      this.agreementNumberStr = agreementNumberStr;
    });
  }

  UndoApplyCountModel undoApplyCountModel;

  getUndoApplyCount() async {
    UndoApplyCountModel undoApplyCountModel = await CRMAPI.undoApplyCount();
    setState(() {
      this.undoApplyCountModel = undoApplyCountModel;
    });
  }

  List<AttendanceLogModel> attendanceLogModelList = [];

  getAttendanceList() async {
    List<AttendanceLogModel> list = await HRAPI.getLastTreeDayLog();
    setState(() {
      this.attendanceLogModelList = list;
    });
  }

  List<NoticeModel> noticeModelList = [];

  getNoticeList() async {
    NoticeListModel noticeListModel = await OAAPI.selectNoticePageList(
      start: 0, length: 5,);
    setState(() {
      noticeModelList = noticeListModel.data;
    });
  }


  Widget item({String tittleName, Color color, Widget content}) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Text(
              tittleName, style: TextStyle(color: Colors.white, fontSize: 20),),
            width: double.infinity,),

          Container(padding: EdgeInsets.all(10),
              child: content,
              decoration: BoxDecoration(color: Style.contentColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)))),
        ],
      ),
    );
  }

  Widget todayAddWidget() {
    if (threadNumberStr == null) return Container(height: 50,);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Text("新增线索：${format(int.parse(threadNumberStr))}",
            style: Style.style,),
          Text("新增客户：${format(int.parse(customerNumberStr))}",
            style: Style.style,),
        ],),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Text("新增商机：${format(int.parse(businessNumberStr))}",
            style: Style.style,),
          Text("新增合同：${format(int.parse(agreementNumberStr))}",
            style: Style.style,),
        ],),

      ],
    );
  }

  Widget undoApplyCountWidget() {
    if (undoApplyCountModel == null) return Container(height: 50,);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Text("待处理面试：${format(undoApplyCountModel.interviewCount)}",
            style: Style.style,),
          Text("待处理审批：${format(undoApplyCountModel.hrApplyCount)}",
            style: Style.style,),
        ],),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Text("待审批合同：${format(undoApplyCountModel.contractCount)}",
            style: Style.style,),
          Text("待审批申请：${format(undoApplyCountModel.oaApplyCount)}",
            style: Style.style,),
        ],),

      ],
    );
  }


  Widget myAttendanceWidget() {
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        itemAttendance("日期", flex: 3),
        itemAttendance("姓名", flex: 3),
        itemAttendance("上班卡", flex: 2),
        itemAttendance("下班卡", flex: 2),
      ],),
      Divider(height: 1, color: Colors.grey,),
      attendanceListWidget(),
    ],);
  }

  Widget attendanceListWidget() {
    if (attendanceLogModelList.length == 0) return Container(height: 50,);
    List<Widget> list = List.generate(attendanceLogModelList.length, (index) {
      return attendanceItemWidget(attendanceLogModelList[index]);
    });
    return Container(child: Column(children: list,),);
  }

  Widget attendanceItemWidget(AttendanceLogModel attendanceLogModel) {


    String firstTime=attendanceLogModel.firstTime?.substring(10);
    String lastTime=attendanceLogModel.lastTime?.substring(10);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          itemAttendance(attendanceLogModel.date ?? "", flex: 3),
          itemAttendance(Data.user.name?? "", flex: 3),

          itemAttendance(firstTime ?? "", flex: 2),
          itemAttendance(lastTime ?? "", flex: 2),


        ],),
        Divider(height: 1, color: Colors.grey,)
      ],),
    );
  }

  Widget itemAttendance(String content, {int flex = 1}) {
    return Expanded(
      flex: flex, child: Text(content, style: Style.midumStyle,),);
  }


  Widget noticeWidget() {
    if (noticeModelList.length == 0) return Container(height: 50,);
    List<Widget> list = List.generate(noticeModelList.length, (index) {
      return noticeItemWidget(noticeModelList[index]);
    });

    return Column(children: list,);
  }

  Widget noticeItemWidget(NoticeModel noticeModel) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "${Routes.noticeDetail}?id=${noticeModel.id}",
            transition: TransitionType.fadeIn);
      },
      child: Container(padding: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(noticeModel.title,
              style: Style.infoStyle,),
            Text(noticeModel.createTime,
              style: Style.style,),
          ],),),
    );
  }


  String format(int number) {
    if (number < 10) {
      return number.toString()+"  ";
    } else if (number < 100) {
      return number.toString()+" ";
    } else {
      return number.toString();
    }
  }

  Widget isConnectWidget() {

    if (Data.isConnect == false) {
      return InkWell(
        onTap: (){
          openSettings();
        },
        child: Container(width: double.infinity,
          height: 40,
          padding: EdgeInsets.all(5),
          color: Data.isLight?Color.fromARGB(255, 255, 237, 237):Color.fromARGB(255, 124, 39, 40),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.error,color: Colors.red,),
                  Text("网络连接不可用",style: TextStyle(fontSize: 15),),
                ],
              ),
              Icon(Icons.keyboard_arrow_right),

            ],
          ),),
      );
    } else {

      return Container();
    }

  }


  StreamSubscription subscription;
  void listenConnectNet(){
    //    //监听CustomEvent事件，刷新UI
    subscription = Data.connectEventBus.on<ConnectEventBus>().listen((event) {
      setState(() {
        Data.isConnect=event.isConnect;
        loadData();
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();//State销毁时，清理注册
    super.dispose();
  }

}
