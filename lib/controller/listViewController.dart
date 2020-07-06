import 'package:cloundapp/components/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';


abstract class ListViewController{

  bool isEmpty=false;

  int currentPage = -1; //第一页
  int pageSize = 10; //页容量
  int totalSize = 0; //总条数


  ScrollController controller = new ScrollController();
  List lists=[];

  State state;

  String appBarName="";


  init(){
    currentPage=-1;
    lists.clear();
  }

  ListViewController(this.state) {
    //固定写法，初始化滚动监听器，加载更多使用
    controller.addListener(() {
      var maxScroll = controller.position.maxScrollExtent;
      var pixel = controller.position.pixels;
      if (maxScroll == pixel && lists.length < totalSize) {
        state.setState(() {
          loadMoreText = "正在加载中...";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
        });
        loadMoreData();
      } else {
        state.setState(() {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
        });
      }
    });
  }

  loadMoreData(){

  }


  getListBySearch(){
    state.setState(() {
      lists.clear();
      isEmpty=false;
    });
    currentPage = -1;
    this.currentPage++;
  }

}


String loadMoreText = "没有更多数据";
TextStyle loadMoreTextStyle = new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
/**
 * 加载更多进度条
 */
Widget buildProgressMoreIndicator() {
  return new Padding(
    padding: const EdgeInsets.all(15.0),
    child: new Center(
      child: new Text(loadMoreText, style: loadMoreTextStyle),
    ),
  );
}

//加载更多    必须继承UnSlidableWrapper  否则会出现左滑的情况
class LoadMore extends UnSlidableWrapper{
  @override
  Widget build(BuildContext context) {
    return buildProgressMoreIndicator();
  }
}




