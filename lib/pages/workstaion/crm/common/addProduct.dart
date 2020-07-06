import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/CircleAvatar.dart';
import 'package:cloundapp/components/RoundCheckBox.dart';
import 'package:cloundapp/components/myTextField.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/rectangleButton.dart';
import 'package:cloundapp/components/showInfomation.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/ProductModel.dart';
import 'package:cloundapp/model/crm/ProductTypeModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/editProduct.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {

  final String id;
  final String type;
  final BaseClass baseClass;

  const AddProduct({Key key, this.id, this.type, this.baseClass})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddProductState();
  }

}

class AddProductState extends State<AddProduct> {

  BaseClass baseClass;
  bool isEmpty = false;
  List<ProductModel> productList = [];
  List<ProductTypeModel> productTypeList = [];
  String typeStr = "全部";
  String type = "";

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  AddProductState() {
    //固定写法，初始化滚动监听器，加载更多使用
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && productList.length < totalSize) {
        setState(() {
          loadMoreText = "正在加载中...";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
        });
        loadMoreData();
      } else {
        setState(() {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
        });
      }
    });
  }


  /*
   * 下拉刷新,必须异步async不然会报错
   */
  Future _pullToRefresh() async {
    currentPage = -1;
    productList.clear();
    loadMoreData();
    return null;
  }

  /*
   * 加载更多进度条
   */
  Widget _buildProgressMoreIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new Text(loadMoreText, style: loadMoreTextStyle),
      ),
    );
  }

  //下拉加载列表数据
  Future loadMoreData() async {
    this.currentPage++;
    int start = currentPage * pageSize;
    ProductModelList productModelList = await CRMAPI.selectProProduct(
        start: start, length: pageSize,
        type: type);
    setState(() {
      for(int i=0;i<productList.length;i++){
        productList[i]=null;
      }
      productList.addAll(productModelList.data);
      totalSize = productModelList.total;
      if (productList.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({var type,}) async {
    currentPage = -1;
    this.currentPage++;
    int start = currentPage * pageSize;
    ProductModelList productModelList = await CRMAPI.selectProProduct(
      type: type,
      start: start,
      length: pageSize,);
    setState(() {
      for(int i=0;i<productList.length;i++){
        productList[i]=null;
      }
      productList.clear();

      productList.addAll(productModelList.data);
      totalSize = productModelList.total;
      if (productList.length == 0) {
        isEmpty = true;
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    baseClass=widget.baseClass;
    getProductTypeList();
    loadMoreData();
    super.initState();
  }

  getProductTypeList() async {
    ProductTypeListModel productTypeListModel = await CRMAPI.selectProType();
    setState(() {
      productTypeList = productTypeListModel.data;
    });
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "新增产品", automaticallyImplyLeading: true,),
      body:   Column(
        children: <Widget>[
          showFrontInformation("选择分类"),
          downArrowContainer(isImportant: true,
              name: "分类", content: typeStr, function: () {
                List<String> typeList = [];
                typeList.add("全部");
                typeList.addAll(
                    List.generate(productTypeList.length, (index) {
                      return productTypeList[index].typeName;
                    }));

                PickHelper.openSimpleDataPicker(
                    context, list: typeList,
                    value: typeStr,
                    onConfirm: (picker, List value) {

                      setState(() {
                        typeStr = picker.getSelectedValues()[0];
                        if (value[0] == 0) {
                          type = null;
                        } else {
                          type = productTypeList[value[0] - 1].id;

                        }
                        getListBySearch(type: type);
                      });
                    });
              }),
          showFrontInformation("产品列表"),

          Expanded(
            flex: 1,
            child:productList.length == 0? Center(
              child: isEmpty?Text("亲，当前列表是空的"):CircularProgressIndicator(),
            ): RefreshIndicator(
              child: ListView.builder(
                itemCount: productList.length + 1,
                itemBuilder: (context, index) {
                  if (index == productList.length) {
                    return _buildProgressMoreIndicator();
                  } else {
                    return createItem(productList[index]);
                  }
                },
                controller: _controller, //指明控制器加载更多使用
              ), onRefresh: _pullToRefresh,
            ),
          ),
          RoundedRectangleButton(
            name: "下一步",
            width: 500,
            height: 50,
            margin: 0,
            circle: 0,
            function: () {
//            Application.router.navigateTo(context, "${Routes.writeFollow}",
//                transition: TransitionType.fadeIn);
              Navigator.pop(context);

              List<ProductModel> list= selectProduct();
                Navigator.push(
                    context, new MaterialPageRoute(builder: (BuildContext context) {
                  return new EditProduct(lists: list,baseClass: baseClass,);
                }));
            },)
        ],
      ),

    );
  }



  //选择选中的商品
  List<ProductModel> selectProduct() {
    var businessModel;
    if(baseClass is BusinessModel){
      businessModel=baseClass as BusinessModel;
    } else if(baseClass is AgreementModel){
      businessModel=baseClass as AgreementModel;
    }
    List<ProductModel> resultList = [];
    for (int i = 0; i < productList.length; i++) {
      ProductModel productModel = productList[i];
      if (productModel.status) {
        productModel.count=1;
        productModel.relationId=businessModel.id;
        resultList.add(productModel);
      }
    }
    return resultList;
  }

  Widget createItem(ProductModel productModel) {
    return InkWell(
      onTap: (){
        setState(() {
          productModel.status=!productModel.status;
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            color: Style.contentColor,
            padding: EdgeInsets.all(10),
            child: Row(children: <Widget>[
              createNetWorkImage(path: productModel.pic),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Text(productModel.proName, style: Style.infoStyle,),
                Text("产品编号：${productModel.proNo}",
                  style: Style.smallStyle,),
                Text("销售价格：￥${productModel.price}".toString(),
                  style: Style.smallStyle,),
              ],),
              Expanded(child: Container(),),
              Checkbox(
                  activeColor:Style.themeColor,
                  value: productModel?.status,
                  onChanged: (value) {
                   setState(() {
                     productModel.status = value;

                   });
                  }),
            ],),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }





}