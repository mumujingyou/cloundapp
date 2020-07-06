import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/attendanceDialog.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/hr/AttendanceInfo.dart';
import 'package:cloundapp/pluginWarpper/flutterCallAndroid.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:r_calendar/r_calendar.dart';
import 'package:intl/intl.dart';




class Attendance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AttendanceState();
  }
}


class AttendanceState extends State<Attendance> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("我的考勤",automaticallyImplyLeading: true,actions: [
        InkWell(child: Image.asset("assets/images/attendanceicon.png",scale: 2,),
        onTap: attendanceAction,),
      ]),
      body: ListView(
        children: <Widget>[
          attendanceNumber(),
          SizedBox(height: 5,),

          Container(child: RCalendarWidget(
            function: update,//切换月份的时候直接调用这个方法
            controller: controller,
            customWidget:DefaultRCalendarCustomWidget() ,
            firstDate: DateTime(2019, 1, 1), //当前日历的最小日期
//            lastDate: DateTime(2055, 12, 31), //当前日历的最大日期
            lastDate: DateTime.now(),
          ),color: Style.contentColor,),

          SizedBox(height: 5,),
          noticeWidget(),
          showFrontInformation("打卡记录"),
          attendanceRecord(),
        ],
      ),
    );
  }

  update(){
    Future.delayed(Duration(seconds: 1),(){
      updateFun();
    });
  }

  updateFun(){
    getMonthInfo(controller.displayedMonthDate);
    getAttendanceList(controller.displayedMonthDate);
    getAttUploadLogDateList(controller.displayedMonthDate);
  }

  RCalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = RCalendarController.single(
        selectedDate: DateTime.now(), isAutoSelect: true);
    controller.addListener(() {
      getAttUploadLogDateList(controller.selectedDate);
    });
    controller.data=[];
    getMonthInfo(DateTime.now());
    getAttendanceList(DateTime.now());
    getAttUploadLogDateList(DateTime.now());
  }


  AttendanceInfo attendanceInfo=null;
  //  DateFormat('yyyy-MM').format(controller.displayedMonthDate)
  //这个月的统计信息
  getMonthInfo(DateTime dateTime) async {
    AttendanceInfo attendanceInfo=await HRAPI.getAttendanceLogMonthStatistics(
        month:DateFormat('yyyy-MM').format(dateTime));
    setState(() {
      this.attendanceInfo=attendanceInfo;
    });
  }


  List<AttendanceModel> list=[];
  //这个月的考勤信息
  getAttendanceList(DateTime dateTime) async {
    Map map =await HRAPI.getAttendanceLogMonthLis(
        month:DateFormat('yyyy-MM').format(dateTime));//yyyy-MM-dd HH:mm:ss  24小时制
                                                      //yyyy-MM-dd hh:mm:ss  12小时制
    setState(() {
      if(map["data"]){
        AttendanceModelList attendanceModelList=map["msg"];
        this.list=attendanceModelList.data;
        controller.data=getAttendanceStatus();
      }else{
        Fluttertoast.showToast(msg: map["msg"]);
        controller.data=[];

      }
    });
  }

  //点击每一天
  List<AttendanceModel> list2=[];
  getAttUploadLogDateList(DateTime dateTime) async {

    Map map =await HRAPI.getAttUploadLogDateList(
        month:DateFormat('yyyy-MM-dd').format(dateTime));
    setState(() {
      if(map["data"]){
        AttendanceModelList attendanceModelList=map["msg"];
        this.list2=attendanceModelList.data;
      }else{
        Fluttertoast.showToast(msg: map["msg"]);
      }
    });
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  Widget attendanceNumber() {
    return Container(color: Style.contentColor,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        gridItem(name: "迟到", count: attendanceInfo?.lateTimes??0, style: Style.redStyle),
        gridItem(name: "早退", count: attendanceInfo?.earlyLeaveTimes??0, style: Style.redStyle),
        gridItem(name: "旷工", count: attendanceInfo?.absenteeismTimes??0, style: Style.redStyle),
        gridItem(name: "请假", count: attendanceInfo?.leaveTimes??0, style: Style.greenStyle),
      ],
      ),
    );
  }

  Widget gridItem({String name, int count, TextStyle style}) {
    return Column(children: <Widget>[
      Text(count.toString(), style: style,),
      Text(name, style: Style.style,),
    ],);
  }

  Widget noticeWidget(){
    return Container(
      color: Style.contentColor,
      padding: EdgeInsets.all(15),
      child: Row(
          children: <Widget>[
            Row(children: <Widget>[
              Container(width: 10,height: 10,color: Colors.red,),
              SizedBox(width: 10,),
              Text("考勤异常",style: Style.style,),
            ],),
            SizedBox(width: 30,),
            Row(children: <Widget>[
              Container(width: 10,height: 10,color: Colors.green,),
              SizedBox(width: 10,),
              Text("请假",style: Style.style,),
            ],),
          ],
      ),
    );
  }
  
  Widget attendanceRecord(){
    if(list2.length==0) return Container();
    return Container(
      color: Style.contentColor,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(list2.length, (index){
          return followRecordItem(list2[index]);
        }),
      ),
    );
  }
  Widget followRecordItem(AttendanceModel attendanceModel) {
    return Container(
//      height: 210,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 12,),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${attendanceModel.attDate} 打卡成功",
                        style: Style.infoStyle,),
                      SizedBox(height: 10,),
                      Text("打卡来源：GPS打卡",
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
          Positioned(child: ApplicationUtil.getAssetsImage("larm",size: 2),
            left: 0,top: 15,),
        ],
      ),
    );
  }


//  * 10000,正常;10001,旷工;10002,迟到上午;10003,早退上午;10004,迟到下午;
//  * 10005,早退下午;10006,早退;10007,外勤;10008,出差;10009,年假;10010,事假;
//  * 10011,病假;10012,调休假;10013,产假;10014,陪产假;10015,补签;10016,婚假;
//  10017,加班;10018,休息日;10019,其他;
//  * 10020,迟到;10021,旷上午;10022,旷下午;


  List getAttendanceStatus(){
    List list=[];
    for(int i=0;i<this.list?.length;i++){
      AttendanceModel attendanceModel=this.list[i];
      if(attendanceModel.attStatus==10000||attendanceModel.attStatus==10017||
          attendanceModel.attStatus==10019||
          attendanceModel.attStatus==10007||attendanceModel.attStatus==10008){
        Map map={
          "attDate":DateTime.parse(attendanceModel.attDate),
          "status":AttendanceStatus.normal
        };
        list.add(map);
      }else if(attendanceModel.attStatus==10001||attendanceModel.attStatus==10002||
          attendanceModel.attStatus==10003||attendanceModel.attStatus==10004||
          attendanceModel.attStatus==10005||attendanceModel.attStatus==10006||
          attendanceModel.attStatus==10020||attendanceModel.attStatus==10021||
          attendanceModel.attStatus==10022){
        Map map={
          "attDate":DateTime.parse(attendanceModel.attDate),
          "status":AttendanceStatus.exception
        };
        list.add(map);
      }else  if(attendanceModel.attStatus==10010||
          attendanceModel.attStatus==10011||attendanceModel.attStatus==10012||
          attendanceModel.attStatus==10013||attendanceModel.attStatus==10014){
        Map map={
          "attDate":DateTime.parse(attendanceModel.attDate),
          "status":AttendanceStatus.qingjia
        };
        list.add(map);
      }else  if(attendanceModel.attStatus==10018){
        Map map={
          "attDate":DateTime.parse(attendanceModel.attDate),
          "status":AttendanceStatus.xiu
        };
        list.add(map);
      }else{
        Map map={
          "attDate":DateTime.parse(attendanceModel.attDate),
          "status":AttendanceStatus.normal
        };
        list.add(map);
      }
    }
    return list;
  }


  attendanceAction() async {
    List<String> list=await getJingwei();
    String macAddress=await ApplicationUtil.getWifiBSSID();
    String wifiName=await ApplicationUtil.getWifiName();
    Map map=await HRAPI.addAttLogByApp(longitude: list[0],latitude: list[1],macAddress: macAddress,wifiName: wifiName);
//    Map map=await HRAPI.addAttLogByApp(longitude: list[0],latitude: list[1],macAddress: "hhhh",wifiName: wifiName);

    if(map["data"]){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return new AttendanceDialog(
              text: DateFormat('HH:mm').format(DateTime.now()),
            );
          });
      controller.selectedDate=DateTime.now();
      updateFun();
//      close();
    }else{
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return new AttendanceFailDialog(
              text: map["msg"],
            );
          });
    }



  }




}

enum AttendanceStatus{
  normal,
  exception,
  qingjia,
  xiu,
}





















































