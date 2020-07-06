import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

Widget createAppBar(String title,
    {bool automaticallyImplyLeading = false,List<Widget> actions }) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: Text(
      title,
      style: TextStyle(fontSize: Style.appbarFontSize),
    ),
    actions: actions,

    centerTitle: true,
  );
}