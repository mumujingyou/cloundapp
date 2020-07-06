import 'package:flutter/material.dart';

List<bool> _selecteds = [false, false, true];

Widget createToggleButtons(State state){
  return       ToggleButtons(
    isSelected: _selecteds,
    children: <Widget>[
      Icon(Icons.local_cafe),
      Icon(Icons.fastfood),
      Icon(Icons.cake),
    ],
    onPressed: (index) {
      state.setState(() {
        for(int i=0;i<_selecteds.length;i++){
          _selecteds[i]=false;
          _selecteds[index]=true;
        }
      });
    },
  );
}