import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
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

class AgreementDetail extends StatefulWidget {
  final String id;
  final String type;

  const AgreementDetail({Key key, this.id, this.type}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AgreementDetailState();
  }

}

class AgreementDetailState extends State<AgreementDetail> {

  var nameCon = new TextEditingController();
  var amountCon = new TextEditingController();
  var remarkCon = new TextEditingController();
  var ourSignerCon = new TextEditingController();
  var customerSignerCon = new TextEditingController();
  int followStatusIndex = 0;
  int followStatus;


  DateTime dateTime;
  String time;
  CustomerModel customer;
  AgreementModel agreementModel;


  @override
  void initState() {
    dateTime=DateTime.now();
    // TODO: implement initState
    getDetail();

    super.initState();
  }

  getDetail() async {

    AgreementModel agreementModel=await CRMAPI.viewContract(id:widget.id);
    setState(() {
      this.agreementModel=agreementModel;
      nameCon.text=agreementModel.contractName;
      amountCon.text=agreementModel.amount.toString();
      ourSignerCon.text=agreementModel.ourSigner.toString();
      customerSignerCon.text=agreementModel.customerSigner.toString();
      time=agreementModel.contractDate;
    });
    agreementTypesStr=getAgreementTypesStr(int.parse(agreementModel.followStatus));
    followStatus=int.parse(agreementModel.followStatus);

  }



  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            "合同详情", automaticallyImplyLeading: true, actions:[
              widget.type=="2"?
          FlatButton(child: Text("更多",style: TextStyle(color: Colors.white,fontSize: 20),), onPressed: () {
            _showDialog(context);
          },):Container(),

        ]),
        body:agreementModel==null?Center(child: new CircularProgressIndicator(),): ListView(children: <Widget>[

          turnToRightWidget(name: "产品",function: (){
//            Application.router.navigateTo(context, "${Routes.productManager}?id=${businessModel.id}&type=7001",
//                transition: TransitionType.fadeIn);
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new ProductManager(baseClass: agreementModel,);
            }));
          }),
          showFrontInformation("基本信息"),
          unimportantText(name:"合同编号",isImportant: false, content:agreementModel.contractNo),
          unimportantText(name:"对应商机",isImportant: false, content:agreementModel.oppoName),
          unimportantText(name:"对应客户",isImportant: false, content:agreementModel.clientName),
          unimportantText(name:"合同标题",isImportant: false, content:agreementModel.contractName),
          unimportantText(name:"合同总金额",isImportant: false, content:agreementModel.amount.toString()),

          unimportantText(name:"我方签约人",isImportant: false, content:agreementModel.ourSigner.toString()),
          unimportantText(name:"客户方签约人",isImportant: false, content:agreementModel.customerSigner.toString()),
          unimportantText(name:"跟进状态",isImportant: false, content:agreementTypesStr),
          unimportantText(name:"签单日期",isImportant: false, content:agreementModel.contractDate),

          showFrontInformation("所属部门"),
          unimportantText(name:"部门",content: agreementModel?.ownersDept??""),
          showFrontInformation("负责人"),
          unimportantText(name:"负责人",content: agreementModel?.owners??""),
          showFrontInformation("其他信息"),
          turnToRightWidget(name: "更进记录",function: (){
//            Application.router.navigateTo(context, "${Routes.followRecord}?type=4001&source=${threadModel.id}",
//                transition: TransitionType.fadeIn);
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new FollowManager(baseClass: agreementModel,);
            }));
          }),

        ],)

    );
  }


  void _showDialog(BuildContext cxt) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(cxt, 0);
                },
                child: Text("取消")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () async {
                    Navigator.of(cxt).pop();
                    Navigator.push(
                        context, new MaterialPageRoute(builder: (BuildContext context) {
                      return new AddFollow(baseClass: agreementModel,);
                    }));

                  },
                  child: Text('写跟进')),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.of(cxt).pop();
                    Application.router.navigateTo(context, "${Routes.agreementEdit}?id=${agreementModel.id}",
                        transition: TransitionType.fadeIn);
                  },
                  child: Text('编辑')),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.of(cxt).pop();
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                      return new DepartmentManager(baseClass: agreementModel,);
                    }));

                  },
                  child: Text('转移给他人')),
            ],
          );
          return dialog;
        });
  }

  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      getDetail();
    }
    super.deactivate();
  }








}
