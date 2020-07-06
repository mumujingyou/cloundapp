import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/CustomerSeaModel.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomersSeaManager extends StatefulWidget {

  final String custId;

  const CustomersSeaManager({Key key, this.custId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomersSeaManagerState();
  }

}

class CustomersSeaManagerState extends State<CustomersSeaManager> {
  List<CustomerSeaModel> lists = [];
  bool isEmpty = false;

  @override
  void initState() {
    // TODO: implement initState

    getCustomerSeaList();
    super.initState();
  }

  Future getCustomerSeaList() async {
    List<CustomerSeaModel> departmentList = await CRMAPI.getUserHighRule();
    setState(() {
      this.lists = departmentList;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
        "选择客户公海", automaticallyImplyLeading: true,),
      body: lists?.length == 0 ? Center(child: Center(
          child: isEmpty
              ? new Text("亲，您还没有公海")
              : new CircularProgressIndicator()),) : ListView(
        children: getListWidgetWidget(),),

    );
  }

  List<Widget> getListWidgetWidget() {
    if (lists.length > 0) {
      return List.generate(lists?.length, (index) {
        return createItem(lists[index]);
      });
    } else {
      return [];
    }
  }

  String _newValue = "";

  Widget createItem(CustomerSeaModel customerSeaModel) {
    return Column(
      children: <Widget>[
        RadioListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          value: customerSeaModel.seasName,
          title: Text(customerSeaModel.seasName, style: Style.style,),
          groupValue: _newValue,
          onChanged: (value) {
            setState(() {
              _newValue = value;
              customerTurnSea(customerSeaModel);
            });
          },
        ),
        Container(height: 1, color: Colors.grey),
      ],
    );
  }

  customerTurnSea(CustomerSeaModel seaModel) {
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.customerTurnSea(seaId: seaModel.id,custId: widget.custId);
      if (result["data"] == true) {
        Fluttertoast.showToast(msg: result["msg"]);
        Navigator.of(context).popUntil(
            ModalRoute.withName(Routes.customerManager));
        return true;
      } else {
        Fluttertoast.showToast(msg: result["msg"]);
        return false;
      }
    });
  }


}