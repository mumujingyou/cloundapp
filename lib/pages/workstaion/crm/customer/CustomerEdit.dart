import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/DepartmentManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addFollow.dart';
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

class CustomerEdit extends StatefulWidget {
  final String id;

  const CustomerEdit({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CustomerEditState();
  }

}

class CustomerEditState extends State<CustomerEdit> {

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
            "客户编辑", automaticallyImplyLeading: true,),
        body:customerModel==null?Center(child: new CircularProgressIndicator(),): ListView(children: <Widget>[



          showFrontInformation("基本信息"),
          multiTextField("姓名",nameCon,isImportant: true,hint: "请输入姓名"),
          multiTextField("公司名称",companyCon,isImportant: false,hint: "请输入公司名称"),
          downArrowContainer(name: "客户类型", content: customerTypeStr??"", function: () {
            PickHelper.openSimpleDataPicker(
                context, list: customerTypeList, value: customerTypeList[index], onConfirm: (picker, List value) {

              setState(() {
                index=value[0];
                customerTypeStr=picker.getSelectedValues()[0];
              });
            });
          }),
          showFrontInformation("联系信息"),
          multiTextField("电话",phoneCon,isImportant: true,hint: "请输入电话",textInputType: TextInputType.phone),

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




  Future save() async {

    if(ApplicationUtil.isChinaPhoneLegal(phoneCon.text)==false){
      Fluttertoast.showToast(msg:"电话号码不正确");
      return;
    }

    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.editCustomer(customerName:nameCon.text,corporateName:companyCon.text,
          phone: phoneCon.text,customerType: getCustomerTypeInt(customerTypeStr).toString(),id: widget.id,
          dept: department.deptId.toString(),owners: user.id.toString(),scale: "1041");
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
