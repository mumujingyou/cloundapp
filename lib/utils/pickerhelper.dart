import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

import 'package:flutter_picker/flutter_picker.dart';

//import 'package:percentage_flutter/config/city.dart';
//
//import 'package:percentage_flutter/kit/util/date_util.dart';



const double _kPickerSheetHeight = 216.0;

const double _kPickerItemHeight = 32.0;



typedef PickerConfirmCityCallback = void Function(

    List<String> stringData, List<int> selecteds);



class PickHelper {

  ///普通简易选择器

  static void openSimpleDataPicker<T>(


      BuildContext context, {

        @required List<T> list,

        String title,

        @required T value,

        PickerDataAdapter adapter,

        @required PickerConfirmCallback onConfirm,

      }) {

    var incomeIndex = 0;

    if (list != null) {

      for (int i = 0; i < list.length; i++) {

        if (list[i] == value) {

          incomeIndex = i;

          break;

        }

      }

    }

    openModalPicker(context,

        adapter: adapter ??

            PickerDataAdapter(

              pickerdata: list,

              isArray: false,

            ),

        onConfirm: onConfirm,

        selecteds: [incomeIndex],

        title: title);

  }



  ///数字选择器

  static void openNumberPicker(

      BuildContext context, {

        String title,

        List<NumberPickerColumn> datas,

        NumberPickerAdapter adapter,

        @required PickerConfirmCallback onConfirm,

      }) {

    openModalPicker(context,

        adapter: adapter ?? NumberPickerAdapter(data: datas ?? []),

        title: title,

        onConfirm: onConfirm);

  }



  ///日期选择器

  static void openDateTimePicker(

      BuildContext context, {

        int type=PickerDateTimeType.kYMDHMS,

        String title,

        DateTime maxValue,

        DateTime minValue,

        DateTime value,

        DateTimePickerAdapter adapter,

        VoidCallback onCancel,

        @required PickerConfirmCallback onConfirm,

      }) {

    openModalPicker(context,

        adapter: adapter ??

            DateTimePickerAdapter(

                type: type,

                isNumberMonth: true,

                yearSuffix: "年",
//
//                maxValue: maxValue ?? DateUtil.after(year: 20),
//
//                minValue: minValue ?? DateUtil.before(year: 100),

                value: value ?? DateTime.now(),

                monthSuffix: "月",

                daySuffix: "日"),

        title: title,

        onCancel: onCancel,

        onConfirm: onConfirm);

  }
//
//
//
//  ///地址选择器
//
//  static void openCityPicker(BuildContext context,
//
//      {String title,
//
//        @required PickerConfirmCityCallback onConfirm,
//
//        String selectCity=""}) {
//
//    var proIndex = 0;
//
//    var cityIndex = 0;
//
//    openModalPicker(context,
//
//        adapter: PickerDataAdapter(
//
//            data: CityData.asMap().keys.map((provincePos) {
//
//              var province = CityData[provincePos];
//
//              List citys = province['city'];
//
//              return PickerItem(
//
//                  text: Text(
//
//                    province['name'],
//
//                  ),
//
//                  value: province['name'],
//
//                  children: citys.asMap().keys.map((cityPos) {
//
//                    var city=citys[cityPos];
//
//                    if(city['name']==selectCity){
//
//                      proIndex=provincePos;
//
//                      cityIndex=cityPos;
//
//                    }
//
//                    return PickerItem(text: Text(city['name']));
//
//                  }).toList());
//
//            }).toList()),
//
//        title: title, onConfirm: (pick, value) {
//
//          var p = CityData[value[0]];
//
//          List citys = p['city'];
//
//          onConfirm([p['name'], citys[value[1]]['name']], value);
//
//        },selecteds: [proIndex,cityIndex]);
//
//  }



  static void openModalPicker(

      BuildContext context, {

        @required PickerAdapter adapter,

        String title,

        List<int> selecteds,

        VoidCallback onCancel,

        @required PickerConfirmCallback onConfirm,

      }) {
    new Picker(

      headercolor:Theme.of(context).scaffoldBackgroundColor ,

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      textStyle: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 20),


      adapter: adapter,

      title: new Text(title ?? ""),

      selecteds: selecteds,

      cancelText: '取消',

      confirmText: '确定',

      cancelTextStyle: TextStyle(fontSize: 16.0),

      confirmTextStyle: TextStyle(fontSize: 16.0),

      textAlign: TextAlign.right,

      itemExtent: _kPickerItemHeight,

      height: _kPickerSheetHeight,


      onConfirm: onConfirm,

      onCancel: onCancel,

    ).showModal(context);

  }

}
