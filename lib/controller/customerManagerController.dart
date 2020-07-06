import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/search.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/pages/workstaion/crm/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'listViewController.dart';
class CustomerManagerController extends ListViewController {
  CustomerManagerController({state}) : super(state);

  int customerType;
  int typeIndex;
  int type;
  GlobalKey<SearchBarDemoPageState> searchKey=new GlobalKey();



  @override
  void init(){
    super.init();
    type=2;
    typeIndex=0;
    appBarName=customers[typeIndex];//标题类型

  }


  /**
   * 下拉刷新,必须异步async不然会报错
   */
  Future pullToRefresh() async {
    currentPage = -1;
    lists.clear();
    customerType=null;

    loadMoreData();
    searchKey.currentState.clear();
  }



  //下拉加载列表数据
  @override
  Future loadMoreData() async {
    super.loadMoreData();
    this.currentPage++;
    int start = currentPage * pageSize;
    CustomerList customerList= await CRMAPI.getCustomerList(start: start,length: pageSize,type: type,customerType: customerType);
    state.setState(() {
      lists.addAll(customerList.list);
      totalSize = customerList.total;
      if (lists.length == 0) {
        isEmpty = true;
      }
    });
  }

  //搜索加载列表数据
  Future getListBySearch({var type,int customerType}) async {
    this.customerType=customerType;
    state.setState(() {
      lists.clear();
      isEmpty=false;
    });
    currentPage=-1;
    this.currentPage++;
    int start = currentPage * pageSize;
    CustomerList customerList= await CRMAPI.getCustomerList(start: start,length: pageSize,type: type,customerType:customerType );
    state.setState(() {
      lists.clear();
      lists.addAll(customerList.list);
      totalSize = customerList.total;
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
      currentPage=-1;
      lists.clear();
      loadMoreData();
    }
  }


  void onConfirm(Picker picker, List<int> value){
    state.setState(() {
      typeIndex = value[0];
      typeStr = picker.getSelectedValues()[0];
      appBarName = typeStr;
     type = customerTypeInt(typeStr);
    });
    getListBySearch(type:type);
  }


  void search(String value){
    if(value==null){
     getListBySearch(type: type);
    }else{
      int customerType=getCustomerTypeInt(value);
     getListBySearch(type: type,customerType: customerType);
    }
  }

}