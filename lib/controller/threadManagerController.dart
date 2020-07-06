import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'listViewController.dart';
class ThreadManagerController extends ListViewController {
  ThreadManagerController({state}) : super(state);

  String searchStr="";
  int type;
  int followStatus;
  int typeIndex;
  GlobalKey<SearchBarDemoPageState> searchKey=new GlobalKey();


  @override
  void init(){
    super.init();
    type=1;
    typeIndex=0;
    appBarName=typeList[typeIndex];//标题类型
  }


  /**
   * 下拉刷新,必须异步async不然会报错
   */
  Future pullToRefresh() async {
    currentPage = -1;
    lists.clear();
    followStatus=null;
    searchStr=null;

    loadMoreData();
    searchKey.currentState.clear();

    return null;
  }



  //下拉加载列表数据
  @override
  Future loadMoreData() async {
    super.loadMoreData();
    this.currentPage++;
    int start = currentPage * pageSize;
    ThreadList threadList= await CRMAPI.getPageListThread(start: start,length: pageSize,type: type,clueName:searchStr,
        followStatus: this.followStatus);
    state.setState(() {
      lists.addAll(threadList?.list);
      totalSize = threadList?.total;
      if (lists.length == 0) {
        isEmpty = true;

      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({var type,String clueName,int followStatus}) async {
    this.followStatus=followStatus;
    this.searchStr=clueName;
    state.setState(() {
      lists.clear();
      isEmpty=false;
    });
    currentPage=-1;
    this.currentPage++;
    int start = currentPage * pageSize;
    ThreadList threadList= await CRMAPI.getPageListThread(start: start,length: pageSize,type: type,clueName:clueName,
        followStatus: followStatus);
    state.setState(() {
      lists.clear();
      lists.addAll(threadList.list);
      totalSize = threadList.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  void deactivate() {
    var bool = ModalRoute
        .of(state.context)
        .isCurrent;
    if (bool) {
      currentPage = -1;
      lists.clear();
      loadMoreData();
    }
  }



  void onConfirm(Picker picker, List<int> value){
    state.setState(() {
      typeIndex=value[0];
      typeStr=picker.getSelectedValues()[0];
      appBarName=typeStr;
      type=customerTypeInt(typeStr);
    });
    getListBySearch(type: type);
    searchKey.currentState.clear();
  }


  void search(String value){
    searchStr = value;
    int followStatus = getConnectStatusInt(value);
    if (followStatus == -1) { //通过名字搜索
      getListBySearch(type: type, clueName: value);
    } else { //通过状态搜索
      getListBySearch(type: type, followStatus: followStatus);
    }
  }

}