import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/mylisttile.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/selectUser.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class DepartmentManager extends StatefulWidget {

  final BaseClass baseClass;

  const DepartmentManager({Key key,this.baseClass}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DepartmentManagerState();
  }
}

class DepartmentManagerState extends State<DepartmentManager> {

  List<Department> lists=[];
  bool isEmpty=false;
  @override
  void initState() {
    // TODO: implement initState

    getDepartmentList();
    super.initState();
  }

  Future getDepartmentList() async {
    List<Department> departmentList = await CRMAPI.getDepartmentList();
    setState(() {
      this.lists = departmentList;
      if(lists.length==0){
        isEmpty=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
        "选择部门", automaticallyImplyLeading: true,),
      body: lists?.length == 0 ? Center(child: Center(
          child: isEmpty
              ? new Text(Data.emptyListStr)
              : new CircularProgressIndicator()),) : ListView(children: getListWidgetWidget(),),

    );
  }

  List<Widget> getListWidgetWidget(){
    if(lists.length>0){
      return List.generate(lists?.length, (index){return createItem(lists[index]);});
    }else{
      return [];
    }
  }

  Widget createItem(Department department){
   return  MyListTile(
      imagePath: "assets/images/index.png",
      tittle:department.deptName,
      function: ()  {
//        Application.router.navigateTo(context, "${Routes.selectUser}?deptId=${department.deptId}&threadId=${widget.threadId}",
//            transition: TransitionType.inFromRight);

        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          return new SelectUser(baseClass:widget.baseClass ,deptId: department.deptId.toString(),);
        },settings: RouteSettings(name: Routes.selectUser)));
      },
    );
  }

}