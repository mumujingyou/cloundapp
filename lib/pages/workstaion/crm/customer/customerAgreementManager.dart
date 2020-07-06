import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerAgreement/AgreementModel.dart';
import 'package:cloundapp/pages/workstaion/crm/agreenment/addAgreement.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class CustomerAgreementManager extends StatefulWidget {

  final String id;
  final String owners;
  final String isBusiness;//是否是商机传过来的

  const CustomerAgreementManager({Key key, this.id, this.owners, this.isBusiness="true"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomerAgreementManagerState();
  }

}

class CustomerAgreementManagerState extends State<CustomerAgreementManager> {

  bool isEmpty=false;
  List<CustomerAgreementModel> lists = [];

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  CustomerAgreementManagerState() {
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
    AgreementList agreementList = await CRMAPI.getCustomerAgreementList(start: start,length: pageSize,
        id: widget.id, owners: widget.owners);
    setState(() {
      lists.addAll(agreementList.list);
      totalSize = agreementList.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });

  }


  @override
  void initState() {
    loadMoreData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "合同", automaticallyImplyLeading: true,actions: <Widget>[
          lists.length!=0?Container():
        InkWell(
          onTap: (){

            if(widget.isBusiness=="true"){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return AddAgreement(addAgreementType: AddAgreementType.Business,);
              }));
            }else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return AddAgreement(addAgreementType: AddAgreementType.Customer,);
              }));
            }

          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.add,size: 35,),
          ),
        ),
      ]),
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


  Widget createItem(CustomerAgreementModel agreement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(color: Style.contentColor,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(agreement.contractName, style: TextStyle(fontSize: 20),),
          Text("合同签约日期", style: Style.style,),
          Text(agreement.contractDate, style: Style.style,),

        ],),),
      SizedBox(height: 2,),
      Container(color: Style.contentColor,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text("合同总金额", style: Style.style,),
          Text("￥${agreement.amount.toString()}", style: Style.style,),

        ],),),
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