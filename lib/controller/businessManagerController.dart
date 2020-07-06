import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/pages/workstaion/crm/business/businessManager.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_sujian_select/select_group.dart';
import 'listViewController.dart';
class BusinessManagerController extends ListViewController {
  BusinessManagerController({state}) : super(state);

  int followStatus;
  String searchStr="";
  int type;
  int typeIndex;


  GlobalKey<SearchBarDemoPageState> searchKey=new GlobalKey();

  BusinessListModel businessListModel;

  @override
  void init(){
    super.init();
    type = 1;
    typeIndex = 0;
    appBarName = businesses[typeIndex]; //标题类型

  }


  /**
   * 下拉刷新,必须异步async不然会报错
   */
  Future pullToRefresh() async {
    super.init();
    searchStr=null;
    loadMoreData();
    searchKey.currentState.clear();
  }



  //下拉加载列表数据
  @override
  Future loadMoreData() async {
    super.loadMoreData();
    this.currentPage++;
    int start = currentPage * pageSize;
    BusinessListModel businessListModel = await CRMAPI.selectOpportunity(
        type: type, start: start, length: pageSize, oppoName: searchStr,followStatus: followStatus);
    this.businessListModel=businessListModel;
    (state as BusinessManagerState).businessListModel=businessListModel;


    state.setState(() {
      lists.addAll(businessListModel.opportunityList);
      totalSize = businessListModel.allNum;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch() async {
    super.getListBySearch();
    int start = currentPage * pageSize;
    BusinessListModel businessListModel = await CRMAPI.selectOpportunity(
        type: type,
        start: start,
        length: pageSize,
        followStatus: followStatus,
        oppoName: searchStr);
    this.businessListModel=businessListModel;
    (state as BusinessManagerState).businessListModel=businessListModel;

    state.setState(() {
      lists.clear();
      lists.addAll(businessListModel.opportunityList);
      if (followStatus == 6021) {
        totalSize = businessListModel.approachlNum;
      } else if (followStatus == 6022) {
        totalSize = businessListModel.confirmNum;
      } else if (followStatus == 6023) {
        totalSize = businessListModel.offerNum;
      } else if (followStatus == 6024) {
        totalSize = businessListModel.contractNum;
      } else if (followStatus == 6025) {
        totalSize = businessListModel.winNum;
      } else if (followStatus == 6026) {
        totalSize = businessListModel.loseNum;
      } else {
        totalSize = businessListModel.allNum;
      }
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
      typeIndex = value[0];
      businessStr = picker.getSelectedValues()[0];
      appBarName = businessStr;
      type = getBusinessInt(businessStr);
    });
    getListBySearch();
    searchKey.currentState.clear();
  }


  void search(String value){
    searchStr = value;
    getListBySearch();
  }

  double height = 500;
  double containerHeight(int result) {
    if (result == 0) return height;
    return result / businessListModel?.allNum * height;
  }




}