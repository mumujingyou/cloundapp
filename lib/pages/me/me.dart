import 'dart:io';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/components/CircleAvatar.dart';
import 'package:cloundapp/components/PictureLooking.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/components/mylisttile.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/eventBus/eventBus.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class Me extends StatefulWidget {
  const Me({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MeState();
  }
}


class MeState extends State<Me> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("个人信息"),
      body: ListView(
        children: <Widget>[
          myInfo(),
          Container(
            color: Style.contentColor,
            child: Column(
              children: <Widget>[
                MyListTile(
                  imagePath: "assets/images/changepw.png",
                  tittle: "修改密码",
                  function: () async {
                    Application.router.navigateTo(
                        context, "${Routes.changePassword}",
                        transition: TransitionType.fadeIn);
                  },
                ),
                MyListTile(
                  imagePath: "assets/images/update.png",
                  tittle: "版本更新",
                  function: showUpdate
                ),
                MyListTile(
                  imagePath: "assets/images/aboutus.png",
                  tittle: "关于我们",
                  function: () async {
                    Application.router.navigateTo(
                        context, "${Routes.aboutUs}",
                        transition: TransitionType.fadeIn);
                  },
                ),
                MyListTile(
                  imagePath: "assets/images/zhuxiao.png",
                  tittle: "注销登录",
                  function: () async {
                    showCupertinoAlertDialog();
                  },
                ),
              ],
            ),
          ),

        ],

      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        setState((){
          Data.isLight=!Data.isLight;

          Style.changeIsLight();
          Data.themeEventBus.fire(ThemeEventBus(Data.isLight));
        });

        await API.prefs.setBool("isLight", Data.isLight);
      },child:Data.isLight? Icon(Icons.brightness_2):Icon(Icons.wb_sunny),),
    );
  }

  Future loginOut() async {
    CRMAPI.logout();
    API.prefs.setBool(Data.isLogin, false);
    API.prefs.setString(Data.access_token, null);
    Application.router.navigateTo(
        context, "${Routes.login}",
        transition: TransitionType.fadeIn, clearStack: true);
  }

  String headImgUrl = Data.user?.headImgUrl??"";

  updateHeadImagUrl() async {
    await CRMAPI.getUserInfo();
    setState(() {
      headImgUrl = Data.user?.headImgUrl;
    });
  }

  Widget myInfo() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Style.contentColor),

      height: 150,
      child: Row(
        children: <Widget>[
          Data.user?.headImgUrl == null ? InkWell(onTap:(){
            updateInfo(context);
          },child: createCircleAvatarDefault(),) :
          InkWell(onTap: () {
            updateInfo(context);
          }, child: createCircleAvatar(path: headImgUrl,),),
          SizedBox(width: 20,),
          Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Data.user?.username ?? "", style: Style.infoStyle,),
              SizedBox(height: 10,),

              Text("${Data.user?.dept ?? ""}", style: Style.style,),
              SizedBox(height: 10,),

              Text("${Data.user?.phone ?? ""}", style: Style.style,),

            ],),
        ],
      ),
    );
  }


  void showCupertinoAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("确定注销登录？"),

            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text("确定"),
                onPressed: () {
                  loginOut();
                },
              ),
            ],
          );
        });
  }

  void showUpdate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("提示"),
            content: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Text("当前已是最新版本哦"),
              ],
            ),
          );
        });
  }


  void updateInfo(BuildContext cxt) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(cxt, 0);
                },
                child: Text("取消")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () async {
                    Navigator.of(cxt).pop();
                    var image = await ImagePicker.pickImage(
                        source: ImageSource.camera);
                    if (image != null) {
                      File croppedFile = await ImageCropper.cropImage(
                          sourcePath: image.path,
                          aspectRatioPresets: [CropAspectRatioPreset.square]);
                      String path = await CRMAPI.uploadFile(file: croppedFile);
                      ApplicationUtil.showLoadingBool(context, () async {
                        Map result = await CRMAPI.updateInfo(headImgUrl: path);
                        if (result["data"] == true) {
                          setState(() {
                            headImgUrl = path;
                            Data.user.headImgUrl = headImgUrl;
                          });
                          Fluttertoast.showToast(msg: result["msg"]);
                          return true;
                        } else {
                          Fluttertoast.showToast(msg: result["msg"]);
                          return false;
                        }
                      });
                    }
                  },
                  child: Text('拍照')),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.of(cxt).pop();
                    var image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      File croppedFile = await ImageCropper.cropImage(
                          sourcePath: image.path,
                          aspectRatioPresets: [CropAspectRatioPreset.square]);
                      String path = await CRMAPI.uploadFile(file: croppedFile);
                      ApplicationUtil.showLoadingBool(context, () async {
                        Map result = await CRMAPI.updateInfo(headImgUrl: path);
                        if (result["data"] == true) {
                          setState(() {
                            headImgUrl = path;
                            Data.user.headImgUrl = headImgUrl;
                          });
                          Fluttertoast.showToast(msg: result["msg"]);
                          return true;
                        } else {
                          Fluttertoast.showToast(msg: result["msg"]);
                          return false;
                        }
                      });
                    }
                  },
                  child: Text('从相册中选择')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(cxt).pop();
                    Navigator.of(context).push(NinePicture([headImgUrl], 0));
                  },
                  child: Text('查看照片')),
            ],
          );
          return dialog;
        });
  }





}
