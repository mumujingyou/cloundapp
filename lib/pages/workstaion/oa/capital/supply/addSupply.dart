import 'package:cloundapp/api/oaaip.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/oa/supplyModel.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddSupply extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddSupplyState();
  }

}


class AddSupplyState extends State<AddSupply> {
  var nameCon = new TextEditingController();
  var remarksCon = new TextEditingController();
  var busNoCon = new TextEditingController();

  DateTime startDateTime;
  var amountCon = new TextEditingController();
  var productRemarksCon = new TextEditingController();
  var quantityCon = new TextEditingController();

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

  String number;

  getNumber() async {
    busNoCon.text = await OAAPI.getNumber(type: "12");
  }


  List<SupplyProduct> list = [];
  SupplyProduct supplyProduct;
  List<String> supplyProductNames = [];
  String supplyProductName = "";

  getSupplyProductList() async {
    List<SupplyProduct> list = await OAAPI.selectAdminSuppliesPageList();
    setState(() {
      this.list = list;

      supplyProductNames = List.generate(this.list.length, (i) {
        return this.list[i].suppliesName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("新增用品领用", automaticallyImplyLeading: true),
      body: ListView(children: <Widget>[

        showFrontInformation("基本信息"),

        supplyWidget(),


        showFrontInformation("领用用品"),

        createItem(),

        showFrontInformation("备注"),

        remarkContainer(controller: remarksCon, hint: "备注"),

        RoundedRectangleButton(
          name: "保存", width: 0, height: 50, function: save,)

      ],),

    );
  }

  Future save() async {
    SuppliesApply suppliesApply = SuppliesApply(
        amount: 1,
        deptName: Data.user.dept,
        beginDate: DateFormat('yyyy-MM-dd').format(startDateTime),
        busNo: busNoCon.text,
        deptId: Data.user.deptId.toString(),
        priority: "1",
        remarks: remarksCon.text,
        title: "用品领用申请-${nameCon.text}-${busNoCon.text}");

    List<SuppliesApplyItem> suppliesApplyItems = [];
    SuppliesApplyItem suppliesApplyItem = new SuppliesApplyItem(
        amount: int.parse(amountCon.text),
        norms: "",
        remarks: productRemarksCon.text,
        suppliesId: supplyProduct.id,
        id: supplyProduct.id,
        quantity:supplyProduct.quantity,
        suppliesName: supplyProduct.suppliesName);
    suppliesApplyItems.add(suppliesApplyItem);
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await OAAPI.addSupply(
          suppliesApply: suppliesApply,
          suppliesApplyItems: suppliesApplyItems
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
                  name: "用品名称", content: supplyProductName ?? "", function: () {
                    PickHelper.openSimpleDataPicker(
                        context, list: supplyProductNames,
                        value: supplyProductName,
                        onConfirm: (picker, List value) {

                          setState(() {
                            supplyProductName = picker.getSelectedValues()[0];
                            supplyProduct = list[value[0]];
                            quantityCon.text=supplyProduct.quantity.toString();
                            //  vacateType = vacateTypeInts[value[0]];
                          });
                        });
                  }),
              multiTextField("库存数量", quantityCon, isReadOnly: true,
                  isImportant: true, ),
              multiTextField("领用数量", amountCon, isReadOnly: false,
                  isImportant: true, textInputType: TextInputType.number,
                  hint: "请输入数量"),
              multiTextField("领用备注", productRemarksCon, isReadOnly: false,
                  isImportant: false,
                  hint: "请输入备注"),
            ],
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }

}


