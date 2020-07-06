import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/CircleAvatar.dart';
import 'package:cloundapp/components/addAndDecreaseBtn.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/ProductModel.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProduct extends StatefulWidget {

  final List<ProductModel> lists;
  final BaseClass baseClass;

  const EditProduct({Key key, this.lists, this.baseClass,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditProductState();
  }

}

class EditProductState extends State<EditProduct> with WidgetsBindingObserver{

  List<ProductModel> lists = [];
  BaseClass baseClass;

  @override
  void initState() {
    lists = widget.lists;
    baseClass=widget.baseClass;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: createAppBar(
        "编辑产品", automaticallyImplyLeading: true,),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(itemCount: lists.length,
                itemBuilder: (context, index) {
                  return createItem(lists[index]);
                }),
          ),
          RoundedRectangleButton(
            name: "保存",
            width: 500,
            height: 50,
            margin: 0,
            circle: 0,
            function:save,)
        ],

      ),

    );
  }

  void save(){
    List<ProModel> list=[];
    String type="";

    if(baseClass is BusinessModel){
      type="7001";
    }else if(baseClass is AgreementModel){
      type="7002";
    }

    for(int i=0;i<lists.length;i++){
      ProductModel productModel=lists[i];
      ProModel proModel=new ProModel(proId: productModel.id,sell: productModel.price,
      amount: productModel.price*productModel.count,count: productModel.count,relationId: productModel.relationId,type: type);
      list.add(proModel);
    }
    ApplicationUtil.showLoadingBool(context, () async {
      Map result = await CRMAPI.addRelateProduct(list: list);
      if (result["data"] == true) {
        //Navigator.of(context).popUntil(ModalRoute.withName(Routes.productManager));

        Navigator.pop(context);
        Fluttertoast.showToast(msg: result["msg"]);

        return true;
      } else {
        Fluttertoast.showToast(msg: result["msg"]);
        return false;
      }
    });
  }


  Widget createItem(ProductModel productModel) {
    var controller = TextEditingController();
    controller.text = productModel.count.toString();
  
    final double bottomInsert = MediaQuery.of(context).viewInsets.bottom;

    if(bottomInsert>=10){
      productModel.count=int.parse(controller.text);
    }


    return Column(
      children: <Widget>[
        Container(
          color: Style.contentColor,
          padding: EdgeInsets.all(10),
          child: Row(children: <Widget>[
            createNetWorkImage(path: productModel.pic),

            SizedBox(width: 10,),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(productModel.proName, style: Style.infoStyle,),
                  Text("产品编号：${productModel.proNo}",
                    style: Style.smallStyle,),
                  Text("销售价格：￥${productModel.price}".toString(),
                    style: Style.smallStyle,),
                  getThreeWidget(
                      add: () {
                        int count = int.parse(controller.text);
                        count++;
                        controller.text = count.toString();
                        productModel.count=count;
                      },
                      decrease: () {
                        if(productModel.count<=1){
                          productModel.count=1;
                          Fluttertoast.showToast(msg: "至少为1");
                          return;
                        }
                        int count = int.parse(controller.text);
                        count--;
                        controller.text = count.toString();
                        productModel.count=count;


                      },
                      onChange: (value){
                        productModel.count=int.parse(value);
                      },
                      controller: controller,


                  ),
                ],),
            ),


          ],),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

}