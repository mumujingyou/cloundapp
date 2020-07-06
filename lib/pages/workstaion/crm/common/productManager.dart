import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/CircleAvatar.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/ProductModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addProduct.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class ProductManager extends StatefulWidget {

  final String id;
  final String type;
  final BaseClass baseClass;
  const ProductManager({Key key, this.id, this.type, this.baseClass})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductManagerState();
  }

}

class ProductManagerState extends State<ProductManager> {

  BaseClass baseClass;
  bool isEmpty=false;
  List<ProductModel> lists = [];

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  ProductManagerState() {
    //固定写法，初始化滚动监听器，加载更多使用
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && lists.length < totalSize) {
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
    lists.clear();
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
    String id;
    String type;
    if(baseClass is BusinessModel){//商机
      BusinessModel businessModel=baseClass as BusinessModel;
      id=businessModel.id;
      type="7001";
    }else if(baseClass is AgreementModel){//商机
      AgreementModel agreement=baseClass as AgreementModel;
      id=agreement.id;
      type="7002";
    }

    ProductModelList productModelList = await CRMAPI.relateProductList(start: start,length: pageSize,
        relationId:id, type:type);
    setState(() {
      lists.addAll(productModelList.data);
      totalSize = productModelList.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });

  }




  @override
  void initState() {
    // TODO: implement initState
    baseClass=widget.baseClass;
    loadMoreData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "产品", automaticallyImplyLeading: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
//              Application.router.navigateTo(context, "${Routes.addProduct}",
//                  transition: TransitionType.fadeIn);
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                return new AddProduct(baseClass: baseClass,);
              }));
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add, size: 35,),
            ),
          ),
        ],),
      body: lists.length == 0
          ? new Center(
          child: isEmpty
              ? new Text(Data.emptyListStr)
              : new CircularProgressIndicator())
          : new RefreshIndicator(
        color: const Color(0xFF4483f6),
        //下拉刷新
        child: ListView.builder(
          itemCount: lists.length + 1,
          itemBuilder: (context, index) {
            if (index == lists.length) {
              return _buildProgressMoreIndicator();
            } else {
              return createItem(lists[index]);
            }
          },
          controller: _controller, //指明控制器加载更多使用
        ),
        onRefresh: _pullToRefresh,
      ),

    );
  }


  Widget createItem(ProductModel productModel) {
    return Column(
      children: <Widget>[
        Container(
          color: Style.contentColor,
          padding: EdgeInsets.all(10),
          child: Row(children: <Widget>[
            createNetWorkImage(path: productModel.pic),
            SizedBox(width: 10,),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(productModel.proName,style: Style.infoStyle,),
              Text("产品编号：${productModel.proNo}",style: Style.smallStyle,),
              Text("销售价格：￥${productModel.price}".toString(),style: Style.smallStyle,),
              Text("产品数量：${productModel.count.toString()}",style: Style.smallStyle,),

            ],),
          ],),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
      _pullToRefresh();

    }
    super.deactivate();
  }
}