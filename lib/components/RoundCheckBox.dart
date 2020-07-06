import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:flutter/material.dart';

class RoundCheckBox extends StatefulWidget {
  final bool value;

  final Function(bool) onChanged;

  RoundCheckBox({Key key, this.onChanged, this.value})
      : super(key: key);

  @override
  RoundCheckBoxState createState() => RoundCheckBoxState();
}

class RoundCheckBoxState extends State<RoundCheckBox> {
  bool value;
  Function(bool) onChanged;

  @override
  void initState() {
    value = widget.value;
    onChanged = widget.onChanged;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            setState(() {
              value = !value;
              onChanged(value);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: value
                ? Icon(
              Icons.check_circle,
              size: 25.0,
              color: Style.themeColor,
            )
                : Icon(
              Icons.panorama_fish_eye,
              size: 25.0,
              color: Colors.grey,
            ),
          )),
    );
  }

  void changeStatus(bool bool) {
    setState(() {
      value = bool;
    });
  }
}


