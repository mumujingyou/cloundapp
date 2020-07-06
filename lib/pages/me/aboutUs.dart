import 'dart:async';

import 'package:cloundapp/api/crmapi.dart';
import 'package:cloundapp/components/myappbar.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutUsState();
  }
}

class AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("关于我们",automaticallyImplyLeading: true),

      body: Column(children: <Widget>[
        Expanded(flex:1,child: Image.asset("assets/images/qunxinlogo.png",scale: 3,)),

        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text("""
            广东群信软件科技有限公司，成立于2014年，坐落于海滨城市汕尾，是一家互联网行业解决方案提供商，主要从事系统研发、手机应用，小程序等，我们拥有广泛和成熟的服务体系，群信科技属于双软企业认证资质企业、国家重点扶持企业单位、高新技术企业。
      群信致力于系统研发，从市场调研到产品需求，从产品设计到产品开发 ，从产品测试到产品上线，公司已开发完成项目20余个，目前，群信科技主营产品有HR人事系统、CRM销售管理系统、OA自动化办公系统、ERP进销存管理系统、WMS仓储系统、 TOA传阅管理系统、群信收银系统、群信电子名片、群信智能家居管理系统、群信商城，主要应用于中小型企业，政府机构，事业单位等领域。
            """),
          ),
        ),
      ],),
    );
  }






}
