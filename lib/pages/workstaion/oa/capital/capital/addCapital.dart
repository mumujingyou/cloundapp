import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/captialModel.dart';
import 'package:cloundapp/model/oa/supplyModel.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddCapital extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCapitalState();
  }

}


class AddCapitalState extends State<AddCapital> {
  var nameCon = new TextEditingController();
  var remarksCon = new TextEditingController();
  var busNoCon = new TextEditingController();

  DateTime startDateTime;
  var amountCon = new TextEditingController();
  var capitalNoCon = new TextEditingController();

  void init() {
    startDateTime = DateTime.now();
    nameCon.text = Data.user.name;

    amountCon.text = "";
    remarksCon.text = "";
  }

  @override
  void initState() {
    init();
    getNumber();
    getSupplyProductList();
    super.initState();
  }


  getNumber() async {
    busNoCon.text = await OAAPI.getNumber(type: "11");
  }


  List<CapitalProduct> list = [];
  CapitalProduct capitalProduct;
  List<String> capitalProductNames = [];
  String capitalProductName = "";

  getSupplyProductList() async {
    List<CapitalProduct> list = await OAAPI.selectAdminCapitalPageList();
    setState(() {
      this.list = list;

      capitalProductNames = List.generate(this.list.length, (i) {
        return this.list[i].capitalName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("新增资产领用", automaticallyImplyLeading: true),
      body: ListView(children: <Widget>[

        showFrontInformation("基本信息"),

        supplyWidget(),


        showFrontInformation("领用资产"),

        createItem(),

        showFrontInformation("备注"),

        remarkContainer(controller: remarksCon, hint: "备注"),

        RoundedRectangleButton(
          name: "保存", width: 0, height: 50, function: save,)

      ],),

    );
  }

  Future save() async {
    CapitalApply capitalApply = CapitalApply(
        amount: 1,
        deptName: Data.user.dept,
        beginDate: DateFormat('yyyy-MM-dd').format(startDateTime),
        busNo: busNoCon.text,
        deptId: Data.user.deptId.toString(),
        priority: "1",
        remarks: remarksCon.text,
        title: "资产领用申请-${nameCon.text}-${busNoCon.text}");

    List<CapitalApplyItem> capitalApplyItems = [];
    CapitalApplyItem suppliesApplyItem = new CapitalApplyItem(
      capitalId: capitalProduct.id,
    capitalName: capitalProduct.capitalName,
    capitalNo: capitalProduct.capitalNo,
    norms: capitalProduct.norms,
    recipient: Data.user.name,
    recipientId: Data.user.id.toString());
    capitalApplyItems.add(suppliesApplyItem);
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await OAAPI.addCapital(
          capitalApply: capitalApply,
          capitalApplyItems: capitalApplyItems
      );

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


  Widget supplyWidget() {
    return Column(children: <Widget>[

      multiTextField("编号", busNoCon, isImportant: true, isReadOnly: true),


      downArrowContainer(isImportant: true,
          name: "申请时间",
          content: "${DateFormat('yyyy-MM-dd').format(startDateTime)}",
          function: () {
            PickHelper.openDateTimePicker(
                context, type: PickerDateTimeType.kYMD,
                value: startDateTime,

                title: "选择时间", onConfirm: (Picker picker, List value) {
              setState(() {
                startDateTime = (picker.adapter as DateTimePickerAdapter).value;
              });
            });
          }),
      multiTextField("领用人", nameCon, isImportant: true, isReadOnly: true),


    ],);
  }


  Widget createItem() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              downArrowContainer(isImportant: true,
                  name: "资产名称", content: capitalProductName ?? "", function: () {
                    PickHelper.openSimpleDataPicker(
                        context, list: capitalProductNames,
                        value: capitalProductName,
                        onConfirm: (picker, List value) {

                          setState(() {
                            capitalProductName = picker.getSelectedValues()[0];
                            capitalProduct = list[value[0]];
                            capitalNoCon.text=capitalProduct.capitalNo;
                            amountCon.text="1";
                          });
                        });
                  }),
              multiTextField("资产编号", capitalNoCon, isReadOnly: true,
                  isImportant: true,),
              multiTextField("领用数量", amountCon, isReadOnly: true,
                  isImportant: true,),

            ],
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }

}


