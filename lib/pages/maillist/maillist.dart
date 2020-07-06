import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/mylisttile.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/contactModel.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/pages/workstaion/hr/check/selectUtil/select_group.dart';
import 'package:cloundapp/pages/workstaion/hr/check/selectUtil/select_item.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class MailList extends StatefulWidget {

  const MailList({Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return MailListState();
  }
}

class MailListState extends State<MailList> {
  List<BaseContact> lists = [];
  bool isEmpty = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future getDepartmentList() async {
    List<Department> departmentList = await CRMAPI.getDepartmentList();
    setState(() {
      this.lists = departmentList;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  Future getContactTypeList() async {
    List<ContactTypeModel> contactTypeList = await OAAPI.contactsTypeList();
    setState(() {
      this.lists = contactTypeList;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  getListBySearch(){
    setState(() {
      lists.clear();
    });
    if(status=="0"){
      getDepartmentList();
    }else{
      getContactTypeList();
    }
  }

  init(){
   // status="0";
  }

  loadData() async {
    init();
    await getListBySearch();
  }

  @override
  Widget build(BuildContext context) {
    if(width==0){
      width = MediaQuery
          .of(context)
          .size
          .width;
    }

    return Scaffold(
      appBar: createAppBar(
        "通讯录", automaticallyImplyLeading: false,),

      body: Data.isNetUse==true?Column(
        children: <Widget>[

          getTypeShape(),
          SizedBox(height: 10,),
          Expanded(
              flex: 1,
              child: lists?.length == 0 ? Center(child: Center(
                  child: isEmpty
                      ? new Text(Data.emptyListStr)
                      : new CircularProgressIndicator()),) : ListView.builder(itemCount:lists.length,itemBuilder: (context,index){
                        return createItem(lists[index]);
              }),
          ),

        ],
      ):Center(child: NetError(onPressed: () async {
        loadData();
      }),),
    );
  }

  double width = 0;
  double fontSize = 20;
  String status = "0";
  GlobalKey<SelectGroupState> key = GlobalKey();

  double getWidth() {
    return ((width - fontSize * 10) / 4) - 1.5;
  }

  int index=0;
  Widget getTypeShape() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectGroup<String>(
            key: key,
            fontSize: fontSize,
            padding: EdgeInsets.symmetric(horizontal: getWidth(), vertical: 15),
            style: SelectStyle.rectangle,
            selectColor: Style.themeColor,
            borderColor: Style.themeColor,
            index: index,
            items: <SelectItem<String>>[
              SelectItem(label: '内部通讯录', value: "0"),
              SelectItem(label: '外部通讯录', value: "1"),
            ],
            onSingleSelect: (String value) {
              status=value;
              index=int.parse(status);
              print(index);
              getListBySearch();
            },
          ),

        ],
      ),
    );
  }



  Widget createItem(BaseContact baseContact) {
    if(baseContact is Department){
      Department department=baseContact ;
      return MyListTile(
        imagePath: "assets/images/index.png",
        tittle: department.deptName,
        function: () {
          Application.router.navigateTo(context, "${Routes.departmentUserManager}?deptId=${department.deptId}",
              transition: TransitionType.fadeIn);
        },
      );
    }else{
      ContactTypeModel contactTypeModel=baseContact ;
      return MyListTile(
        imagePath: "assets/images/index.png",
        tittle: contactTypeModel.name,
        function: () {
          Application.router.navigateTo(context, "${Routes.contactUserManager}?typeId=${contactTypeModel.id}",
              transition: TransitionType.fadeIn);
        },
      );
    }


  }

}
