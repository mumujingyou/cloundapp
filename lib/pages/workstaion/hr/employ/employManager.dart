import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BaseClass.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/ProductModel.dart';
import 'package:cloundapp/model/hr/employModel.dart';
import 'package:cloundapp/pages/workstaion/crm/common/addProduct.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class EmployManager extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmployManagerState();
  }

}

class EmployManagerState extends State<EmployManager> {

  bool isEmpty=false;
  List<EmployModel> lists = [];

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  EmployManagerState() {
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


  init(){
    currentPage = -1;
    lists.clear();
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

    EmployModelList employModelList = await HRAPI.employList(start: start,length: pageSize);
    setState(() {
      lists.addAll(employModelList.data);
      totalSize = employModelList.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });

  }




  @override
  void initState() {
    // TODO: implement initState
    loadMoreData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: createAppBar(
        "招聘信息", automaticallyImplyLeading: true,),

      body:Data.isNetUse==true? lists.length == 0
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
      ):Center(child: NetError(onPressed: () async {
        setState(() {
          init();
        });
        loadMoreData();
      }),),

    );
  }


  Widget createItem(EmployModel employModel) {


    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          color: Style.contentColor,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
              employModel.urgent=="1"?Text("【紧急】",
                    style: Style.redStyle,):Container(),
                  Text("${employModel.name} ${employModel.number}人",
                    style: Style.infoStyle,),
                ],
              ),
              SizedBox(height: 10,),
              Text("创建时间： ${employModel.createTime??""}",
                style: Style.style,),
              SizedBox(height: 10,),
              Text("聘用形式：正式",
                style: Style.style,),
              SizedBox(height: 10,),

              Text("招聘部门： ${employModel.dept??""}",
                style: Style.style,),
              SizedBox(height: 10,),

              Text("招聘城市： ${employModel.city??""}",
                style: Style.style,),
            ],
          ),
        ),
        SizedBox(height: 20,),
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