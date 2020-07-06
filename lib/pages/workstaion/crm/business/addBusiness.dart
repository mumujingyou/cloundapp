import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/pages/workstaion/crm/customer/customerManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddBusiness extends StatefulWidget {
  final bool isEmpty;

  const AddBusiness({Key key, this.isEmpty = true}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddBusinessState();
  }

}


class AddBusinessState extends State<AddBusiness> {

  var nameCon = new TextEditingController();
  var amountCon = new TextEditingController();
  var remarkCon = new TextEditingController();

  int followStatusIndex = 0;
  int followStatus;

  @override
  void initState() {
    // TODO: implement initState
    followStatus = getBusinessTypeInt(businessTypes[followStatusIndex]);

    dateTime = DateTime.now();
    super.initState();
  }


  DateTime dateTime;
  CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar("新增商机", automaticallyImplyLeading: true),
        body: ListView(children: <Widget>[
          showFrontInformation("基本信息"),
          multiTextField("商机标题", nameCon, isImportant: true, hint: "请输入商机标题"),
          multiTextField(
              "预计销售金额", amountCon, isImportant: true, hint: "请输入预计销售金额",
              textInputType: TextInputType.number),
          getWidget(),
          downArrowContainer(isImportant: true,
              name: "销售阶段",
              content: businessTypes[followStatusIndex] ?? "",
              function: () {
                PickHelper.openSimpleDataPicker(
                    context, list: businessTypes,
                    value: businessTypes[followStatusIndex],
                    onConfirm: (picker, List value) {
                      setState(() {
                        followStatusIndex = value[0]; //第几个
                        followStatus = getBusinessTypeInt(
                            businessTypes[followStatusIndex]);
                      });
                    });
              }),
          downArrowContainer(isImportant: true,
              name: "预计签单日期",
              content: "${ApplicationUtil.getTime(dateTime)}",
              function: () {
                PickHelper.openDateTimePicker(context, title: "选择时间",
                    onConfirm: (Picker picker, List value) {
                      setState(() {
                        dateTime =
                            (picker.adapter as DateTimePickerAdapter).value;
                      });
                    });
              }),
          showFrontInformation("其他信息"),
          multiTextField("备注", remarkCon, isImportant: false, hint: "请输入备注"),
          SizedBox(height: 20,),
          RoundedRectangleButton(
            name: "保存", width: 0, height: 50, function: save,)
        ],)

    );
  }

  Future save() async {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.addOpportunity(
        client: customer.id,
        oppoName: nameCon.text,
        amount: amountCon.text,
        issueDate: ApplicationUtil.getTime(dateTime),
        followStatus: followStatus.toString(),
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


  Widget getWidget() {
    if (widget.isEmpty) {
      return turnToRightWidgetContent(name: "对应客户",
          content: customer?.customerName ?? "",
          isImportant: true,
          function: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (BuildContext context) {
              return new CustomerManager(isCanPop: true,);
            })).then((value) {
              customer = value;
            });
          });
    } else {
      customer=Data.customerModel;

      return unimportantText(name: "对应客户",
          isImportant: true,
          content: customer?.customerName ?? "");
    }
  }


}