import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/DepartmentManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addFollow.dart';
import 'package:cloundapp/pages/workstaion/crm/common/followManager.dart';
import 'package:cloundapp/pages/workstaion/crm/common/productManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessDetail extends StatefulWidget {
  final String id;
  final String type;

  const BusinessDetail({Key key, this.id, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BusinessDetailState();
  }

}

class BusinessDetailState extends State<BusinessDetail> {

  var nameCon = new TextEditingController();
  var amountCon = new TextEditingController();
  var remarkCon = new TextEditingController();
  var clientCon = new TextEditingController();
  var followStatusIndexCon = new TextEditingController();
  var timeCon = new TextEditingController();

  int followStatusIndex = 0;
  int followStatus;


  DateTime dateTime;
  String time;
  CustomerModel customer;
  BusinessModel businessModel;
  Department department;
  User user;

  String currentAgreementAmount = "";
  String historyAgreementAmount = "";

  @override
  void initState() {
    dateTime = DateTime.now();
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
      Data.businessModel = businessModel;

      nameCon.text = businessModel.oppoName;
      amountCon.text = businessModel.amount.toString();
      clientCon.text = businessModel.clientName;
      followStatusIndexCon.text =
          getBusinessTypeStr(int.parse(businessModel.followStatus));
      timeCon.text = businessModel.issueDate;

      time = businessModel.issueDate;
    });
    businessTypeStr = getBusinessTypeStr(int.parse(businessModel.followStatus));
    followStatus = int.parse(businessModel.followStatus);
    await getDepartmentName();
    await getUserName();
  }

  getSale() async {
    String currentAgreementAmount = await CRMAPI.selectContractMonthlySales(
        sales: 0, client: businessModel.client);
    setState(() {
      this.currentAgreementAmount = currentAgreementAmount;
    });
    String historyAgreementAmount = await CRMAPI.selectContractMonthlySales(
        sales: 1, client: businessModel.client);
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
    //传参数
    return Scaffold(
        appBar: createAppBar(
            "商机详情", automaticallyImplyLeading: true, actions: [
          widget.type == "1" ?
          FlatButton(child: Text(
            "更多", style: TextStyle(color: Colors.white, fontSize: 20),),
            onPressed: () {
              _showDialog(context);
            },) : Container(),

        ]),
        body: businessModel == null ? Center(
          child: new CircularProgressIndicator(),) : ListView(
          children: <Widget>[


            turnToRightWidget(name: "产品", function: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
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
            multiTextField("商机标题", nameCon, isImportant: false,
                hint: "请输入商机标题",
                isReadOnly: true),
            multiTextField("预计销售金额", amountCon, isImportant: false,
                hint: "请输入预计销售金额",
                isReadOnly: true),

            multiTextField(
                "对应客户", clientCon, isImportant: false, isReadOnly: true),
            multiTextField("销售阶段", followStatusIndexCon, isImportant: false,
                isReadOnly: true),
            multiTextField(
                "预计签单日期", timeCon, isImportant: false, isReadOnly: true),
//
            showFrontInformation("所属部门"),
            unimportantText(name: "部门", content: department?.deptName ?? ""),
            showFrontInformation("负责人"),
            unimportantText(name: "负责人", content: user?.name ?? ""),
            showFrontInformation("其他信息"),
            turnToRightWidget(name: "更进记录", function: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                    return new FollowManager(baseClass: businessModel,);
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
                        context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                          return new AddFollow(baseClass: businessModel,);
                        }));
                  },
                  child: Text('写跟进')),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.of(cxt).pop();
                    Application.router.navigateTo(context,
                        "${Routes.businessEdit}?id=${businessModel.id}",
                        transition: TransitionType.fadeIn);
                  },
                  child: Text('编辑')),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.of(cxt).pop();
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                          return new DepartmentManager(
                            baseClass: businessModel,);
                        }));
                  },
                  child: Text('转移给他人')),
            ],
          );
          return dialog;
        });
  }


  Widget agreementWidget() {
    return Column(
      children: <Widget>[
        Container(padding: EdgeInsets.all(10),
          color: Style.contentColor,
          width: double.infinity,
          child:
          Row(children: <Widget>[
            Expanded(child: item(
                "本月成交", "￥$currentAgreementAmount", "currentbusiness")),
            Expanded(child: item(
                "历史成交", "￥$historyAgreementAmount", "futurebusiness")),
          ],),),
        SizedBox(height: 2,)
      ],
    );
  }

  Widget item(String content, String amount, String imageName) {
    return Row(children: <Widget>[
      Image.asset(ApplicationUtil.getAssetsImagePath(imageName), scale: 2,),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(content, style: Style.smallStyle,),
        Text(amount, style: Style.smallStyle,),
      ],),
    ],);
  }

  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      getDetail();
      Future.delayed(Duration(seconds: 1), () {
        getSale();
      });
    }
    super.deactivate();
  }


}
