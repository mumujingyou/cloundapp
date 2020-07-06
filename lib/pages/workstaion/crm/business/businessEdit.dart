import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/Department.dart';
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

class BusinessEdit extends StatefulWidget {
  final String id;

  const BusinessEdit({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BusinessEditState();
  }

}

class BusinessEditState extends State<BusinessEdit> {

  var nameCon = new TextEditingController();
  var amountCon = new TextEditingController();
  var remarkCon = new TextEditingController();

  int followStatusIndex = 0;
  int followStatus;


  String time;
  CustomerModel customer;
  BusinessModel businessModel;
  Department department;
  User user;

  String currentAgreementAmount = "";
  String historyAgreementAmount = "";

  @override
  void initState() {
    // TODO: implement initState
    getDetail();

    Future.delayed(Duration(seconds: 1), () {
      getSale();
    });
    super.initState();
  }

  getDetail() async {
    BusinessModel businessModel = await CRMAPI.businessDetail(id: widget.id);
    setState(() {
      this.businessModel = businessModel;
      nameCon.text = businessModel.oppoName;
      amountCon.text = businessModel.amount.toString();
      time = businessModel.issueDate;
    });
    businessTypeStr = getBusinessTypeStr(int.parse(businessModel.followStatus));
    followStatus = int.parse(businessModel.followStatus);
    await getDepartmentName();
    await getUserName();
  }

  getSale() async {
    String currentAgreementAmount = await CRMAPI.selectContractMonthlySales(
        sales: 0, client: businessModel.id);
    setState(() {
      this.currentAgreementAmount = currentAgreementAmount;
    });
    String historyAgreementAmount = await CRMAPI.selectContractMonthlySales(
        sales: 1, client: businessModel.id);
    setState(() {
      this.historyAgreementAmount = historyAgreementAmount;
    });
  }


  getDepartmentName() async {
    Department department = await CRMAPI.getDepartmentById(
        deptIds: businessModel.ownersDept.toString());
    setState(() {
      this.department = department;
    });
  }

  getUserName() async {
    User user = await CRMAPI.getUserById(
        deptId: businessModel.ownersDept.toString(),
        userId: businessModel.owners);
    setState(() {
      this.user = user;
    });
  }


  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "商机编辑", automaticallyImplyLeading: true,),
        body: businessModel == null ? Center(
          child: new CircularProgressIndicator(),) : ListView(
          children: <Widget>[



            showFrontInformation("基本信息"),
            multiTextField("商机标题", nameCon, isImportant: true, hint: "请输入商机标题"),
            multiTextField(
                "预计销售金额", amountCon, isImportant: true, hint: "请输入预计销售金额",textInputType: TextInputType.number),
            turnToRightWidgetContent(name: "对应客户",
                content: customer?.customerName ?? businessModel.clientName,
                isImportant: true,
                function: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                        return new CustomerManager(isCanPop: true,);
                      })).then((value) {
                    customer = value;
                  });
                }),
            downArrowContainer(isImportant: true,
                name: "销售阶段", content: businessTypeStr ?? "", function: () {
                  PickHelper.openSimpleDataPicker(
                      context, list: businessTypes,
                      value: businessTypes[followStatusIndex],
                      onConfirm: (picker, List value) {

                        setState(() {
                          followStatusIndex = value[0]; //第几个
                          businessTypeStr = picker.getSelectedValues()[0];
                          followStatus = getBusinessTypeInt(businessTypeStr);
                        });
                      });
                }),
            downArrowContainer(isImportant: true,
                name: "预计签单日期",
                content: time ?? "",
                function: () {
                  PickHelper.openDateTimePicker(context, title: "选择时间",
                      onConfirm: (Picker picker, List value) {
                        setState(() {
                          time = ApplicationUtil.getTime((picker.adapter as DateTimePickerAdapter).value);
                        });
                      },value: DateTime.parse(time));
                }),
//
//          //"${Routes.threadDetail}?id=${threadModel.id}"
            showFrontInformation("所属部门"),
            unimportantText(name: "部门", content: department?.deptName ?? ""),
            showFrontInformation("负责人"),
            unimportantText(name: "负责人", content: user?.name ?? ""),
            SizedBox(height: 20,),
            RoundedRectangleButton(
              name: "保存", width: 500, height: 50, function: save,)
          ],)

    );
  }




  Future save() async {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.editOpportunity(
        id: widget.id,
        client: customer?.id ?? businessModel.client,
        oppoName: nameCon.text,
        amount: amountCon.text,
        issueDate: time,
        followStatus: followStatus,
        remarks: remarkCon.text,);

      if (result["data"] == true) {
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
