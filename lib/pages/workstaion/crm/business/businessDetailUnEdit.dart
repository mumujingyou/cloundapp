import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';

import 'package:cloundapp/pages/workstaion/crm/common/DepartmentManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addFollow.dart';
import 'package:cloundapp/pages/workstaion/crm/common/followManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/productManager.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';

import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BusinessDetailUnEdit extends StatefulWidget {
  final String id;

  const BusinessDetailUnEdit({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BusinessDetailUnEditState();
  }

}

class BusinessDetailUnEditState extends State<BusinessDetailUnEdit> {

  var nameCon = new TextEditingController();
  var amountCon = new TextEditingController();
  var remarkCon = new TextEditingController();

  int followStatusIndex = 0;
  int followStatus;


  DateTime dateTime;
  String time;
  CustomerModel customer;
  BusinessModel businessModel;
  Department department;
  User user;

  String currentAgreementAmount="";
  String historyAgreementAmount="";

  @override
  void initState() {
    dateTime=DateTime.now();
    // TODO: implement initState
    getDetail();

    Future.delayed(Duration(seconds: 1),()  {
      getSale();
    });
    super.initState();
  }

  getDetail() async {

    BusinessModel businessModel=await CRMAPI.businessDetail(id:widget.id);
    setState(() {
      this.businessModel=businessModel;
      Data.businessModel=businessModel;

      nameCon.text=businessModel.oppoName;
      amountCon.text=businessModel.amount.toString();
      time=businessModel.issueDate;
    });
    businessTypeStr=getBusinessTypeStr(int.parse(businessModel.followStatus));
    followStatus=int.parse(businessModel.followStatus);
    await getDepartmentName();
    await getUserName();
  }

  getSale() async {
   String currentAgreementAmount=await CRMAPI.selectContractMonthlySales(sales: 0,client: businessModel.id);
   setState(() {
     this.currentAgreementAmount=currentAgreementAmount;

   });
   String historyAgreementAmount=await CRMAPI.selectContractMonthlySales(sales: 1,client: businessModel.id);
   setState(() {
     this.historyAgreementAmount=historyAgreementAmount;

   });



  }


  getDepartmentName() async {
    Department department=await CRMAPI.getDepartmentById(deptIds:businessModel.ownersDept.toString());
    setState(() {
      this.department=department;
    });
  }

  getUserName() async {
    User user=await CRMAPI.getUserById(deptId:businessModel.ownersDept.toString(),userId: businessModel.owners);
    setState(() {
      this.user=user;
    });
  }


  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "商机详情", automaticallyImplyLeading: true,),
        body:businessModel==null?Center(child: new CircularProgressIndicator(),): ListView(children: <Widget>[



          turnToRightWidget(name: "产品",function: (){
//            Application.router.navigateTo(context, "${Routes.productManager}?id=${businessModel.id}&type=7001",
//                transition: TransitionType.fadeIn);
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new ProductManager(baseClass: businessModel,);
            }));
          }),

          SizedBox(height: 10,),

          turnToRightWidget(name: "合同", function: () {
            Application.router.navigateTo(context,
                "${Routes.customerAgreementList}?id=${businessModel
                    .client}&owners=${user.id}&isBusiness=true",
                transition: TransitionType.fadeIn);
          }),
          agreementWidget(),


          showFrontInformation("基本信息"),
          importantTextField("商机标题", "请输入商机标题", nameCon,isReadOnly: true),

          importantTextField("预计销售金额", "请输入预计销售金额", amountCon,textInputType: TextInputType.number,isReadOnly:true),
          unimportantText(name:"对应客户",isImportant: true, content:businessModel.clientName),
          unimportantText(name:"销售阶段",isImportant: true, content:businessTypeStr),
          unimportantText(name:"预计签单日期",isImportant: true, content:time),
//
//          //"${Routes.threadDetail}?id=${threadModel.id}"
          showFrontInformation("所属部门"),
          unimportantText(name:"部门",content: department?.deptName??""),
          showFrontInformation("负责人"),
          unimportantText(name:"负责人",content: user?.name??""),
          showFrontInformation("其他信息"),
          turnToRightWidget(name: "更进记录",function: (){
//            Application.router.navigateTo(context, "${Routes.followRecord}?type=4001&source=${threadModel.id}",
//                transition: TransitionType.fadeIn);
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new FollowManager(baseClass: businessModel,);
            }));
          }),

        ],)

    );
  }






  Widget agreementWidget(){
    return Column(
      children: <Widget>[
        Container(padding: EdgeInsets.all(10), color: Style.contentColor,width: double.infinity,child:
        Row(children: <Widget>[
          Expanded(child: item("本月成交","￥$currentAgreementAmount","currentbusiness")),
          Expanded(child: item("历史成交","￥$historyAgreementAmount","futurebusiness")),
        ],),),
        SizedBox(height: 2,)
      ],
    );
  }

  Widget item(String content,String amount,String imageName){
    return Row(children: <Widget>[
      Image.asset(ApplicationUtil.getAssetsImagePath(imageName),scale: 2,),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(content,style: Style.smallStyle,),
        Text(amount,style:Style.smallStyle,),
      ],),
    ],);
  }




}
