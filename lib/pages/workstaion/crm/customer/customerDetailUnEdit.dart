import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

class CustomerDetailUnEdit extends StatefulWidget {
  final String id;

  const CustomerDetailUnEdit({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CustomerDetailUnEditState();
  }

}

class CustomerDetailUnEditState extends State<CustomerDetailUnEdit> {

  var nameCon = new TextEditingController();
  var companyCon = new TextEditingController();
  var phoneCon = new TextEditingController();


  CustomerModel customerModel;
  Department department;
  User user;


  String currentBusinessAmount="";
  String futureBusinessAmount="";
  String currentAgreementAmount="";
  String historyAgreementAmount="";

  @override
  void initState() {
    // TODO: implement initState
    getThreadDetail();

    Future.delayed(Duration(seconds: 1),()  {
      getSale();

    });
    super.initState();
  }

  getThreadDetail() async {

    CustomerModel customerModel=await CRMAPI.customerDetail(id:widget.id);
    setState(() {
      this.customerModel=customerModel;
      Data.customerModel=customerModel;

      nameCon.text=customerModel.customerName;
      companyCon.text=customerModel.corporateName;
      phoneCon.text=customerModel.phone;

      customerTypeStr=getCustomerTypeStr(customerModel.customerType.toString());
    });
    await getDepartmentName();
    await getUserName();
  }

  getSale() async {
   currentBusinessAmount=await CRMAPI.selectOpportunityMonthlySales(sales: 0,client: customerModel.id);
   String futureBusinessAmount=await CRMAPI.selectOpportunityMonthlySales(sales: 1,client: customerModel.id);
   setState(() {
     this.futureBusinessAmount=futureBusinessAmount;

   });
   String currentAgreementAmount=await CRMAPI.selectContractMonthlySales(sales: 0,client: customerModel.id);
   setState(() {
     this.currentAgreementAmount=currentAgreementAmount;

   });
   String historyAgreementAmount=await CRMAPI.selectContractMonthlySales(sales: 1,client: customerModel.id);
   setState(() {
     this.historyAgreementAmount=historyAgreementAmount;

   });



  }


  getDepartmentName() async {
    Department department=await CRMAPI.getDepartmentById(deptIds:customerModel.dept.toString());
    setState(() {
      this.department=department;
    });
  }

  getUserName() async {
    User user=await CRMAPI.getUserById(deptId:customerModel.dept.toString(),userId: customerModel.owners);
    setState(() {
      this.user=user;
    });
  }


  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "客户详情", automaticallyImplyLeading: true,),
        body:customerModel==null?Center(child: new CircularProgressIndicator(),): ListView(children: <Widget>[



          turnToRightWidget(name: "商机",function: (){
            Application.router.navigateTo(context, "${Routes.customerBusinessList}?id=${customerModel?.id}&owners=${user?.id}",
                transition: TransitionType.fadeIn);
          }),
          businessWidget(),

          SizedBox(height: 10,),

          turnToRightWidget(name: "合同",function: (){
            Application.router.navigateTo(context, "${Routes.customerAgreementList}?id=${customerModel?.id}&owners=${user?.id}&isBusiness=false",
                transition: TransitionType.fadeIn);
          }),
          agreementWidget(),


          showFrontInformation("基本信息"),
          unimportantText(name:"姓名",content: nameCon.text),
          unimportantText(name:"公司名称",content: companyCon.text),
          unimportantText(name:"客户类型",content: customerTypeStr),
          showFrontInformation("联系信息"),
          unimportantText(name:"电话",content: phoneCon.text),

          showFrontInformation("所属部门"),
          unimportantText(name:"部门",content: department?.deptName??""),
          showFrontInformation("负责人"),
          unimportantText(name:"负责人",content: user?.name??""),
          showFrontInformation("其他信息"),
          turnToRightWidget(name: "更进记录",function: (){
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new FollowManager(baseClass: customerModel,);
            }));
          }),

          SizedBox(height: 20,),
        ],)

    );
  }

  Widget businessWidget(){
    return Column(
      children: <Widget>[
        Container(padding: EdgeInsets.all(10), color: Style.contentColor,width: double.infinity,child:
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: <Widget>[
          Expanded(child: item("本月预计签单金额","￥$currentBusinessAmount","current")),
          Expanded(child: item("未来预计签单金额","￥$futureBusinessAmount","future")),
        ],),),
        SizedBox(height: 2,)
      ],
    );
  }


  Widget agreementWidget(){
    return Column(
      children: <Widget>[
        Container(padding: EdgeInsets.all(10), color:Style.contentColor,width: double.infinity,child:
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

  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      getThreadDetail();
      Future.delayed(Duration(seconds: 1),()  {
        getSale();

      });
    }
    super.deactivate();
  }



}
