import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/DepartmentManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addFollow.dart';
import 'package:cloundapp/pages/workstaion/crm/common/followManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/pages/workstaion/crm/thread/transformToCumstomer.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ThreadEdit extends StatefulWidget {
  final String id;

  const ThreadEdit({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ThreadEditState();
  }

}

class ThreadEditState extends State<ThreadEdit> {

  var nameCon = new TextEditingController();
  var companyCon = new TextEditingController();
  var phoneCon = new TextEditingController();


  ThreadModel threadModel;
  Department department;
  User user;
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


  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "线索编辑", automaticallyImplyLeading: true, ),
        body:threadModel==null?Center(child: new CircularProgressIndicator(),): ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          multiTextField("姓名",nameCon,isImportant: true,hint: "请输入姓名"),
          multiTextField("公司名称",companyCon,isImportant: false,hint: "请输入公司名称"),

          showFrontInformation("联系信息"),
          multiTextField("电话",phoneCon,isImportant: true,hint: "请输入电话",textInputType: TextInputType.phone),

          showFrontInformation("跟进状态"),
          downArrowContainer(name: "联系方式状态", content: connectStatusStr??"", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: connectStatusList, value: connectStatusList[index], onConfirm: (picker, List value) {


              setState(() {
                index=value[0];
                connectStatusStr=picker.getSelectedValues()[0];
              });
            });
          }),
          //"${Routes.threadDetail}?id=${threadModel.id}"
          showFrontInformation("所属部门"),

          unimportantText(name:"部门",content: department?.deptName??""),
          showFrontInformation("负责人"),
          unimportantText(name:"负责人",content: user?.name??""),

          SizedBox(height: 20,),
          RoundedRectangleButton(name: "保存", width: 500, height: 50, function: save,)
        ],)

    );
  }


  void save(){

    if(ApplicationUtil.isChinaPhoneLegal(phoneCon.text)==false){
      Fluttertoast.showToast(msg:"电话号码不正确");
      return;
    }

    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.editAllClue(clueName:nameCon.text,corporateName:companyCon.text,
          mobilePhone: phoneCon.text,followStatus: getConnectStatusInt(connectStatusStr),id: widget.id);
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
