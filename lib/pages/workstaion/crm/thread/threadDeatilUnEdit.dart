import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/followManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThreadDetailUnEdit extends StatefulWidget {
  final String id;

  const ThreadDetailUnEdit({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ThreadDetailUnEditState();
  }

}

class ThreadDetailUnEditState extends State<ThreadDetailUnEdit> {

  var nameCon = new TextEditingController();
  var companyCon = new TextEditingController();
  var phoneCon = new TextEditingController();


  ThreadModel threadModel=null;
  Department department=null;
  User user=null;
  @override
  void initState() {
    // TODO: implement initState
    getThreadDetail();

    super.initState();
  }

  getThreadDetail() async {
    ThreadModel threadModel=await CRMAPI.getClueById(id:widget.id);
    setState(() {
      this.threadModel=threadModel;
      nameCon.text=threadModel.clueName;
      companyCon.text=threadModel.corporateName;
      phoneCon.text=threadModel.mobilePhone;

       connectStatusStr=getConnectStatusStr(threadModel);
    });
    await getDepartmentName();
    await getUserName();
  }


  getDepartmentName() async {
    Department department=await CRMAPI.getDepartmentById(deptIds:threadModel.ownersDept.toString());
    setState(() {
      this.department=department;
    });
  }

  getUserName() async {
    User user=await CRMAPI.getUserById(deptId:threadModel.ownersDept.toString(),userId: threadModel.owners);
    setState(() {
      this.user=user;
    });
  }

  int type=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "线索详情", automaticallyImplyLeading: true,),
        body:threadModel==null?Center(child: new CircularProgressIndicator(),): ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          unimportantText(name:"姓名",content: threadModel?.clueName??""),
          unimportantText(name:"公司名称",content: threadModel?.corporateName??""),
          showFrontInformation("联系信息"),
          unimportantText(name:"电话",content: threadModel?.mobilePhone??""),
          showFrontInformation("跟进状态"),
          unimportantText(name:"联系方式状态",content: connectStatusStr??""),
          showFrontInformation("所属部门"),
          unimportantText(name:"部门",content: department?.deptName??""),
          showFrontInformation("负责人"),
          unimportantText(name:"负责人",content: user?.name??""),
          showFrontInformation("其他信息"),
          turnToRightWidget(name: "更进记录",function: (){
//            Application.router.navigateTo(context, "${Routes.followRecord}",
//                transition: TransitionType.fadeIn);
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new FollowManager(baseClass: threadModel,);
            }));
          }),

        ],)

    );
  }

}
