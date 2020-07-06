import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/pages/workstaion/crm/business/addBusiness.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

class CustomerBusinessManager extends StatefulWidget {

  final String id;
  final String owners;
  final bool isCanPop;

  const CustomerBusinessManager({Key key, this.id, this.owners, this.isCanPop=false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomerBusinessManagerState();
  }

}

class CustomerBusinessManagerState extends State<CustomerBusinessManager> {

  bool isEmpty=false;
  List<BusinessModel> lists = [];

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  CustomerBusinessManagerState() {
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
    BusinessList businessList = await CRMAPI.getCustomerBusinessList(start: start,length: pageSize,
        id: widget.id, owners: widget.owners);
    setState(() {
      lists.addAll(businessList.list);
      totalSize = businessList.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    ///getBusinessList();
    loadMoreData();
    super.initState();
  }

  getBusinessList() async {
    BusinessList businessList = await CRMAPI.getCustomerBusinessList(
        id: widget.id, owners: widget.owners);
    setState(() {
      lists = businessList.list;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "商机", automaticallyImplyLeading: true,actions: <Widget>[
        lists.length!=0?Container():
        InkWell(
          onTap: (){
//            Application.router.navigateTo(context, "${Routes.addAgreement}",
//                transition: TransitionType.fadeIn);
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return AddBusiness(isEmpty: false,);
            }));
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
              ? new Text("亲，您还没有消息呢")
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

  Widget createItem(BusinessModel businessModel) {
    return InkWell(
      onTap: (){
        if(widget.isCanPop){
          Navigator.of(context).pop(businessModel);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(color: Style.contentColor,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(businessModel.oppoName, style: TextStyle(fontSize: 20),),
          Text("预计签单日期", style: Style.style,),
          Text(businessModel.issueDate, style: Style.style,),

        ],),),
        SizedBox(height: 2,),
        Container(color: Style.contentColor,
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text("预计签单金额", style: Style.style,),
            Text("￥${businessModel.amount.toString()}", style: Style.style,),

          ],),),
        SizedBox(height: 10,),

      ],
      ),
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