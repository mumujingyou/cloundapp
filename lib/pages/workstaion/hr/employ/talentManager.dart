import 'package:cloundapp/api/hrapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/netErrorWidget.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/hr/ApplyModel.dart';
import 'package:cloundapp/model/hr/talentModel.dart';
import 'package:cloundapp/pages/workstaion/hr/check/selectUtil/select_group.dart';
import 'package:cloundapp/pages/workstaion/hr/check/selectUtil/select_item.dart';
import 'package:cloundapp/pages/workstaion/hr/status.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:cloundapp/utils/pickerhelper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class TalentManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TalentManagerState();
  }

}

class TalentManagerState extends State<TalentManager> {

  bool isEmpty = false;
  List<TalentModel> tanlentList = [];

  String status = "1";

  TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.grey[500]);

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  TalentManagerState() {
    //固定写法，初始化滚动监听器，加载更多使用
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && tanlentList.length < totalSize) {
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
    tanlentList.clear();
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
    TalentModelList talentModelList = await HRAPI.getMyTalentList(
        start: start, length: pageSize,
        appsta: status);
    setState(() {
      tanlentList.addAll(talentModelList.data);
      totalSize = talentModelList.total;
      if (tanlentList.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({var status}) async {
    setState(() {
      tanlentList.clear();
      isEmpty=false;
    });

    currentPage = -1;
    this.currentPage++;
    int start = currentPage * pageSize;

    TalentModelList talentModelList = await HRAPI.getMyTalentList(
        start: start, length: pageSize,
        appsta: status);
    setState(() {
      tanlentList.clear();
      tanlentList.addAll(talentModelList.data);
      totalSize = talentModelList.total;
      if (tanlentList.length == 0) {
        isEmpty = true;
      }
    });
  }


  String checkType;
  init(){
    tanlentList.clear();
    status = "1";
    currentPage=-1;
    checkType = checkTypeInts[0]; //审批类型
    checkTypeStr = checkTypeStrs[0];

  }

  @override
  void initState() {
    checkTypeStr =checkTypeStrs[0];
    loadMoreData();
    super.initState();
  }


  double width = 0;
  double fontSize = 20;

  @override
  Widget build(BuildContext context) {
    if(width==0){
      width = MediaQuery
          .of(context)
          .size
          .width;
    }
    return Scaffold(
      appBar: createAppBar("我的面试", automaticallyImplyLeading: true),
      body:Data.isNetUse==true? Column(
        children: <Widget>[

          getTypeShape(),
          SizedBox(height: 10,),
          Expanded(
            flex: 1,
            child: tanlentList.length == 0 ? Center(
              child: isEmpty ? Text(Data.emptyListStr) : CircularProgressIndicator(),
            ) : RefreshIndicator(
              child: ListView.builder(
                itemCount: tanlentList.length + 1,
                itemBuilder: (context, index) {
                  if (index == tanlentList.length) {
                    return _buildProgressMoreIndicator();
                  } else {
                    return createItem(tanlentList[index]);
                  }
                },
                controller: _controller, //指明控制器加载更多使用
              ), onRefresh: _pullToRefresh,
            ),
          ),

        ],
      ):Center(child: NetError(onPressed: () async {
        setState(() {
          init();
        });
        loadMoreData();
      }),),

    );
  }

  GlobalKey<SelectGroupState> key = GlobalKey();

  Widget getTypeShape() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectGroup<String>(
            key: key,
            fontSize: fontSize,
            padding: EdgeInsets.symmetric(horizontal: getWidth(), vertical: 15),
            style: SelectStyle.rectangle,
            selectColor: Style.themeColor,
            borderColor: Style.themeColor,
            index: 0,
            items: <SelectItem<String>>[
              SelectItem(label: '已完成', value: "1"),
              SelectItem(label: '未完成', value: "0"),

            ],
            onSingleSelect: (String value) {
              status=value;
              getListBySearch(status: status,);
            },
          ),

        ],
      ),
    );
  }


  double getWidth() {
    return ((width - fontSize * 6) / 4) - 1.5;
  }

  Widget createItem(TalentModel talentModel) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (){
            Application.router.navigateTo(
                context, "${Routes.talentDetail}?id=${talentModel.id}&employ=${Uri.encodeComponent(talentModel.employ??"")}",
                transition: TransitionType.fadeIn,);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            color: Style.contentColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:200,
                      child: Text("${talentModel.name}  ${talentModel.phone}",
                        softWrap: true,overflow: TextOverflow.ellipsis,
                        style: Style.infoStyle,),
                    ),
                    SizedBox(height: 10,),
                    Text("投递时间： ${talentModel?.createTime??""}",
                      style: Style.smallStyle,),
                    SizedBox(height: 10,),
                    Text("面试时间： ${talentModel?.interviewTime??""}",
                      style: Style.smallStyle,),
                    SizedBox(height: 10,),

                    Text("面试职位： ${talentModel?.employ??""}",
                      style: Style.smallStyle,),
                  ],
                ),
                showStatusWidget(talentModel),
              ],),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget showStatusWidget(TalentModel talentModel){
    if(talentModel.status=="2"){
      return  Text("已录用",
        style: Style.greenStyle,);
    }else if(talentModel.status=="3"){
      return  Text("已放弃",
        style: Style.redStyle,);
    }else{
      return  Text(talentModel.flag,
        style: Style.blueStyle,);
    }
  }

  @override
  void deactivate() {
    var bool = ModalRoute
        .of(context)
        .isCurrent;
    if (bool) {
     // status = applyStatusInt[0];
      _pullToRefresh();
    }
    super.deactivate();
  }


}