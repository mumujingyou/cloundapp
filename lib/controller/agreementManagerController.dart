import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'listViewController.dart';
class AgreementManagerController extends ListViewController {
  AgreementManagerController({state}) : super(state);

  String searchStr="";
  int type;
  int typeIndex;

  GlobalKey<SearchBarDemoPageState> searchKey=new GlobalKey();


  @override
  void init(){
    super.init();
    type=2;
    typeIndex=0;
    appBarName=agreements[typeIndex];//标题类型
  }


  /**
   * 下拉刷新,必须异步async不然会报错
   */
  Future pullToRefresh() async {
    currentPage = -1;
    lists.clear();
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
    AgreementModelList agreenmentModelList= await CRMAPI.selectContract(start: start,length: pageSize,
      type: type,contractName:searchStr);
    state.setState(() {
      lists.addAll(agreenmentModelList.data);
      totalSize = agreenmentModelList.total;
      if (lists.length == 0) {
        isEmpty = true;

      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({var type,String name}) async {
    state.setState(() {
      lists.clear();
      isEmpty=false;
    });
    currentPage=-1;
    this.currentPage++;
    int start = currentPage * pageSize;
    AgreementModelList agreenmentModelList= await CRMAPI.selectContract(start: start,length: pageSize,
      type: type,contractName:name,);
    state.setState(() {
      lists.addAll(agreenmentModelList.data);
      totalSize = agreenmentModelList.total;
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
      agreementStr=picker.getSelectedValues()[0];
      appBarName=agreementStr;
      type=getAgreementInt(agreementStr);
    });
    getListBySearch(type: type);
    searchKey.currentState.clear();
  }


  void search(String value){
    searchStr=value;
    getListBySearch(type: type,name: value);
  }

}