import 'dart:convert';
import 'dart:io';

import 'package:cloundapp/api/api.dart';
import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/Agreenment.dart';
import 'package:cloundapp/model/crm/BusinessModel.dart';
import 'package:cloundapp/model/crm/CustomerAgreement/AgreementModel.dart';
import 'package:cloundapp/model/crm/CustomerModel.dart';
import 'package:cloundapp/model/crm/CustomerSeaModel.dart';
import 'package:cloundapp/model/crm/Department.dart';
import 'package:cloundapp/model/crm/FollowModel.dart';
import 'package:cloundapp/model/crm/ProductModel.dart';
import 'package:cloundapp/model/crm/ProductTypeModel.dart';
import 'package:cloundapp/model/crm/ThreadModel.dart';
import 'package:cloundapp/model/crm/UndoApplyCountModel.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:dio/dio.dart';

class CRMAPI {



  static const String userInfoUrl = address + "api-u/users/app/userInfo";
  static const String getPageListThreadUrl = address + "api-c/clue/getPageList";
  static const String loginUrl = address + "sys/login";
  static const String logoutUrl = address + "sys/logout";
  static const String refresh_tokenUrl = address + "sys/refresh_token";

  static const String deleteThreadURl = address + "api-c/clue/remove";
  static const String getClueByIdUrl = address + "api-c/clue/getClueById";
  static const String findByDeptIdsUrl = address + "api-u/dept/findByDeptIds";
  static const String getAppUserListFilterUrl = address +
      "api-u/users/getAppUserListFilter";
  static const String editAllClueUrl = address + "api-c/clue/editAllClue";
  static const String addAllClueUrl = address + "api-c/clue/addAllClue";
  static const String getDepartmentListUrl = address + "api-u/dept/list";
  static const String getFollowListUrl = address + "api-c/follow/pageList";
  static const String saveFollowUrl = address + "api-c/follow/saveFollow";
  static const String goTurnToCustUrl = address + "api-c/clue/goTurnToCust";
  static const String getUserListByPageUrl = address +
      "api-u/users/getUserListByPage";
  static const String getAllUserListFilterUrl = address +
      "api-u/users/getAllUserListFilter";
  static const String goChangeClueOwnersUrl = address +
      "api-c/clue/goChangeClueOwners";


  //编号获取
  static const String getNumberUrl = address + "api-c/getNumber";//其他编号
  static const String getContractualNoUrl = address + "api-c/contract/getContractual";//合同编号
  static const String getNumberUploadUrl = address + "api-u/getNumber";//其他编号


  //客户线索
  static const String selectCustomerUrl = address + "api-c/customer/select";
  static const String addCustomerUrl = address + "api-c/customer/save";
  static const String deleteCustomerUrl = address + "api-c/customer/delete";
  static const String customerDetailUrl = address + "api-c/customer/view";
  static const String editCustomerUrl = address + "api-c/customer/edit";
  static const String listForCustomerUrl = address +
      "api-c/opportunity/listForCustomer"; //客户下的商机
  static const String contractlistForCustomerUrl = address +
      "api-c/contract/listForCustomer"; //客户下的合同
  static const String customerTransferUrl = address + "api-c/customer/transfer";
  static const String customerTurnSeaUrl = address + "api-c/customer/turnSea";
  static const String selectOpportunityMonthlySalesUrl = address +
      "api-c/opportunity/selectOpportunityMonthlySales";
  static const String selectContractMonthlySalesUrl = address +
      "api-c/contract/selectContractMonthlySales";
  static const String getUserHighRuleUrl = address +
      "api-c/highRule/getUserHighRule";


  //商机
  static const String selectOpportunityUrl = address +
      "api-c/opportunity/app/select";
  static const String removeOpportunityUrl = address +
      "api-c/opportunity/remove";
  static const String addOpportunityUrl = address + "api-c/opportunity/add";
  static const String editOpportunityUrl = address + "api-c/opportunity/edit";
  static const String viewOpportunityUrl = address + "api-c/opportunity/view";
  static const String relateProductListUrl = address +
      "api-c/relateProduct/list"; //48	销售中心-关联产品列表查询
  static const String selectproTypeUrl = address +
      "api-c/proType/select"; //产品分类
  static const String selectProProductUrl = address +
      "api-c/proProduct/select"; //产品分页查询
  static const String addRelateProductUrl = address + "api-c/relateProduct/add";
  static const String changeOwnersOpportunityUrl = address +
      "api-c/opportunity/changeOwners";


  //合同
  static const String selectContractUrl = address + "api-c/contract/select";
  static const String removeContractUrl = address + "api-c/contract/remove";
  static const String addContractUrl = address + "api-c/contract/add";
  static const String viewContractUrl = address + "api-c/contract/view";
  static const String editContractUrl = address + "api-c/contract/edit";
  static const String changeOwnersContractUrl = address + "api-c/contract/changeOwners";


  //我的
  static const String updatePWUrl = address + "api-u/users/app/updatePW";
  static const String updateInfoUrl = address + "api-u/users/app/updateInfo";
  static const String uploadFileUrl = address + "api-f/files/upload";


  //首页下的
  static const String selectOpportunityNumberUrl = address +
      "api-c/opportunity/selectOpportunityNumber";
  static const String selectClueNumberUrl = address +
      "api-c/clue/selectClueNumber";
  static const String selectContractNumberUrl = address +
      "api-c/contract/selectContractNumber";
  static const String selectCustomerNumberUrl = address +
      "api-c/customer/selectCustomerNumber";

  static const String undoApplyCountUrl = address +
      "api-u/users/app/undoApplyCount";


  //登录
  static Future<Map<String, dynamic>> login(
      {String username, String password}) async {
    var formData = {
      'username': "$username",
      "password": "$password",
    };
    Response response;
    try {
      Dio dio = Dio();
      dio.options.contentType =
          ContentType.parse(API.formdata).toString();
      //发起POST请求 传入url及表单参数
      response = await dio.post(loginUrl, data: formData);
      API.access_token=response.data["access_token"];
      API.refresh_token=response.data["refresh_token"];

      API.prefs.setString(Data.access_token, API.access_token);
      print(response.data);
      API.httpHeaders = {
        'Authorization': 'Bearer ${response.data["access_token"]}',
      };
      return {"msg": "登录成功", "data": true};
    } catch (e) {
      if(e.response!=null){
        if(e.response.statusCode == 401){
          return {"msg": "用户不存在", "data": false};
        }else if(e.response.statusCode == 400){
          return {"msg": "密码错误", "data": false};
        }
      }else{
        return {"msg": "登录失败", "data": false};

      }
    }
  }


  //注销登陆
  static Future logout() async {
    API.get(url: logoutUrl,);
    API.dio=null;
  }

  //重新刷新refresh_token
  static Future refresh_token() async {
    var formData = {
      'refresh_token':API.refresh_token ,
    };
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse(API.formdata).toString();
    //发起POST请求 传入url及表单参数
    response = await dio.post(refresh_tokenUrl, data: formData);
    print(response.data.toString());
    API.access_token=response.data["access_token"];
    API.refresh_token=response.data["refresh_token"];

    API.httpHeaders = {
      'Authorization': 'Bearer ${response.data["access_token"]}',
    };
    API.dio=null;
  }

  //查询个人信息
  static Future<User> getUserInfo() async {
    Response response= await API.requestResponseByCode(url: userInfoUrl);
    User user=null;
    if(response!=null){
      user = User.fromJson(response.data["data"]);
      if(user!=null){
        API.prefs.setString(Data.phone, user.phone);
        API.prefs.setString(Data.dept, user.dept);
        API.prefs.setString(Data.headImgUrl, user.headImgUrl);
        Data.user = user;
      }
    }else{
      String phone=API.prefs.getString(Data.phone);
      String dept=API.prefs.getString(Data.dept);
      String username=API.prefs.getString(Data.username);
      String password=API.prefs.getString(Data.password);
      if(Data.user==null){//当前没有网络第一次调用，以后不会调用
        Data.user=new User(phone: phone,dept: dept, username: username,password: password);
      }

    }
    return Data.user;
  }

  //修改信息
  static Future<Map<String, dynamic>> updateInfo({String headImgUrl}) async {
    var name=Data.user.name;
    var sex=Data.user.sex;
    var formData = {
      'name': name,
      "sex": sex,
      "headImgUrl": headImgUrl,
    };
    return await API.requestBool(url: updateInfoUrl,formData: formData,contentType: API.json);
  }


  //文件上传
  static Future<String> uploadFile({File file,}) async {
    String busNo=await getNumberUpload();
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
      "busNo": busNo,
    });
    Response response=await API.requestResponseByCode(url: uploadFileUrl,formData: formData);
    return response.data["data"]["url"];

  }

//  1.商品2.商品类型3.客户分类4.客户5.线索6.联系人7.跟进8.商机9.费用10.商机11.费用报销
  static Future<String> getNumber({var type,}) async {
    var formData = {
      "type": type,
    };
    return await API.requestString(url: getNumberUrl,formData: formData);
  }

  //业务编号
  static Future<String> getNumberUpload({var type=1,}) async {
    var formData = {
      "type": type,
    };
    return await API.requestString(url: getNumberUploadUrl,formData: formData);
  }


  // 合同编号
  static Future<String> getContractualNo() async {
    return await API.requestString(url: getContractualNoUrl);
  }





  //线索列表
  static Future<ThreadList> getPageListThread({int start = 0,
    int length = 10, var type = "0", String clueName, int followStatus}) async {
    var formData = {
      'start': "$start",
      "length": "$length",
      "type": type,
      "clueName": clueName,
      "followStatus": followStatus
    };
    Response response=await API.requestResponse(url: getPageListThreadUrl,formData: formData);
    if(response==null) return null;
    int total = response.data["total"];
    List<dynamic> dynamicList = response.data["data"];
    List<ThreadModel> list = [];

    for (int i = 0; i < dynamicList.length; i++) {
      list.add(ThreadModel.fromJson(dynamicList[i]));
    }
    ThreadList threadList = new ThreadList(total: total, list: list);
    return threadList;
  }


  //删除线索
  static Future<Map<String, dynamic>> deleteThread({String ids}) async {
    var formData = {
      'ids': "$ids",
    };
    return await API.requestBool(formData: formData,url:deleteThreadURl );
  }


  //编辑线索
  static Future<Map<String, dynamic>> editAllClue(
      {int followStatus, String corporateName, String clueName,
        String mobilePhone, String id}) async {
    var formData = {
      "id": id,
      'followStatus': "$followStatus",
      'corporateName': "$corporateName",
      'clueName': "$clueName",
      'mobilePhone': "$mobilePhone",
    };
    return await API.requestBool(formData: formData,url:editAllClueUrl );
  }

  //新增线索
  static Future<Map<String, dynamic>> addClue(
      {String corporateName, String clueName,
        String mobilePhone, String remarks, String owners}) async {
    var formData = {
      'corporateName': "$corporateName",
      'clueName': "$clueName",
      'mobilePhone': "$mobilePhone",
      "remarks": remarks,
      "owners": owners
    };
    return API.requestBool(formData: formData,url: addAllClueUrl);

  }


  //根据id查询线索详情
  static Future<ThreadModel> getClueById({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response= await API.requestResponseByCode(url: getClueByIdUrl,formData: formData);
    return ThreadModel.fromJson(response.data["data"]);
  }


  //根据id查询部门详情
  static Future<Department> getDepartmentById({String deptIds}) async {
    Response response= await API.requestResponseByCode(url: getDepartmentListUrl);
    List<dynamic> dynamicList = response.data["data"];
    for (int i = 0; i < dynamicList.length; i++) {
      Department department = Department.fromJson(dynamicList[i]);
      if (department.deptId.toString() == deptIds) {
        return department;
      }
    }
    return null;
  }

  //部门列表
  static Future<List<Department>> getDepartmentList() async {
    Response response= await API.requestResponseByCode(url: getDepartmentListUrl);
    List<dynamic> dynamicList = response.data["data"];
    List<Department> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      list.add(Department.fromJson(dynamicList[i]));
    }
    return list;
  }


  //跟进列表
  static Future<List<FollowModel>> getFollowList(
      {int start = 0, int length = 20, String type, String source}) async {
    var formData = {
      'start': "$start",
      "length": "$length",
      "type": "$type",
      "source": "$source", //id
    };
    Response response= await API.requestResponseByCode(url: getFollowListUrl,formData: formData);
    List<dynamic> dynamicList = response.data["data"];
    List<FollowModel> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      list.add(FollowModel.fromJson(dynamicList[i]));
    }
    return list;
  }

  //新增跟进
  static Future<Map<String, dynamic>> addFollow(
      {String date, String nextTime, String followNo, String status, String way,
        String type, String remark, String owners, String source, String sourceName, String owner}) async {
    var formData = {
      'date': "$date",
      'nextTime': "$nextTime",
      'followNo': "$followNo",
      'status': "$status",
      'way': "$way",
      'source': "$source",
      'sourceName': "$sourceName",
      'type': "$type",
      "remark": remark,
      "owner": owner
    };
    return await API.requestBool(formData: formData,url:saveFollowUrl );
  }


  //线索转客户
  static Future<Map<String, dynamic>> goTurnToCust(
      {String clueId, String corporateName, String customerName,
        String customerType, String phone, String contactName}) async {
    var formData = {
      'clueId': "$clueId",
      'corporateName': "$corporateName",
      'customerName': "$customerName",
      'customerType': "$customerType",
      "contactName": contactName,
      'phone': "$phone",
    };
    return await API.requestBool(formData: formData,url: goTurnToCustUrl);
  }


  //线索转移给他人
  static Future<Map<String, dynamic>> goChangeClueOwners(
      {String ids, String owners,}) async {
    var formData = {
      "ids": ids,
      'owners': "$owners",
    };
    return await API.requestBool(formData: formData,url: goChangeClueOwnersUrl);
  }


  //根据用户id查询用户详情
  static Future<User> getUserById({String deptId, String userId}) async {
    Response response= await API.requestResponseByCode(url: getAllUserListFilterUrl,);
    List<dynamic> dynamicList = response.data["data"];
    for (int i = 0; i < dynamicList.length; i++) {
      User user = User.fromJson(dynamicList[i]);
      if (user.id.toString() == userId) {
        return user;
      }
    }
    return null;
  }


  //根据部门查找部门下的所有用户
  static Future<List<User>> getAllUserListFilter({String deptId}) async {
    var formData = {
      'deptId': "$deptId",
    };
    Response response= await API.requestResponseByCode(url: getAllUserListFilterUrl,formData: formData);
    List<User> list = [];
    List<dynamic> dynamicList = response.data["data"];
    for (int i = 0; i < dynamicList.length; i++) {
      User user = User.fromJson(dynamicList[i]);
      list.add(user);
    }
    return list;
  }


  //客户列表
  static Future<CustomerList> getCustomerList({int start = 0,
    int length = 10, var type = "0", int customerType}) async {
    var formData = {
      'start': "$start",
      "length": "$length",
      "type": type,
      "customerType": customerType
    };
    Response response= await API.requestResponse(url: selectCustomerUrl,formData: formData);
    int total = response.data["total"];
    List<dynamic> dynamicList = response.data["data"];
    List<CustomerModel> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      list.add(CustomerModel.fromJson(dynamicList[i]));
    }
    CustomerList customerList = new CustomerList(total: total, list: list);
    return customerList;
  }


  //新增线索
  static Future<Map<String, dynamic>> addCustomer(
      {String corporateName, String customerName,
        String phone, String remarks, String owners, String customerType, String dept}) async {
    var formData = {
      'corporateName': "$corporateName",
      'customerName': "$customerName",
      'phone': "$phone",
      "remarks": remarks,
      "owners": owners,
      "customerType": customerType,
      "dept": dept
    };
    return await API.requestBool(formData: formData,url: addCustomerUrl);

  }

  //删除线索
  static Future<Map<String, dynamic>> deleteCustomer({String ids,}) async {
    var formData = {
      'ids': "$ids",
    };
    return await API.requestBool(formData: formData,url: deleteCustomerUrl);
  }

  //根据id查询线索详情
  static Future<CustomerModel> customerDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response= await API.requestResponseByCode(url: customerDetailUrl,formData: formData);
    return CustomerModel.fromJson(response.data["data"]);
  }

  //编辑客户
  static Future<Map<String, dynamic>> editCustomer(
      {int followStatus, String corporateName, String customerName,
        String phone, String id, String customerType, String customerSource, String dept, String owners, String scale}) async {
    var formData = {
      "id": id,
      'corporateName': "$corporateName",
      'customerName': "$customerName",
      'phone': "$phone",
      "customerType": customerType,
      "customerSource": customerSource,
      "dept": dept,
      "owners": owners,
      "scale": scale
    };
    return await API.requestBool(formData: formData,url: editCustomerUrl);

  }

  //客户下的商机列表
  static Future<BusinessList> getCustomerBusinessList({int start = 0,
    int length = 10, String id, String owners}) async {
    var formData = {
      'start': start,
      "length": length,
      "id": id,
      "owners": owners
    };
    Response response= await API.requestResponse(url: listForCustomerUrl,formData: formData);
    int total = response.data["total"];
    List<dynamic> dynamicList = response.data["data"];
    List<BusinessModel> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      list.add(BusinessModel.fromJson(dynamicList[i]));
    }
    BusinessList businessList = new BusinessList(total: total, list: list);
    return businessList;
  }

  //客户下的合同列表
  static Future<AgreementList> getCustomerAgreementList({int start = 0,
    int length = 10, String id, String owners}) async {
    var formData = {
      'start': start,
      "length": length,
      "id": id,
      "owners": owners
    };
    Response response= await API.requestResponse(url: contractlistForCustomerUrl,formData: formData);
    int total = response.data["total"];
    List<dynamic> dynamicList = response.data["data"];
    List<CustomerAgreementModel> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      list.add(CustomerAgreementModel.fromJson(dynamicList[i]));
    }
    AgreementList agreementList = new AgreementList(total: total, list: list);
    return agreementList;



}


  //客户转移给他人
  static Future<Map<String, dynamic>> customerTransfer(
      {String custIds, String owners,}) async {
    var formData = {
      "custIds": custIds,
      'owners': "$owners",
      "opportunity": 0,
      "contract": 0,
    };
    return await API.requestBool(formData: formData,url: customerTransferUrl);
  }


  //客户转移到客户公海
  static Future<Map<String, dynamic>> customerTurnSea(
      {String custId, String seaId,}) async {
    var formData = {
      "custId": custId,
      'seaId': seaId,
    };
    return await API.requestBool(formData: formData,url: customerTurnSeaUrl);
  }

  //客户下的商机金额
  static Future<String> selectOpportunityMonthlySales(
      {var sales, String client}) async {
    var formData = {
      "sales": sales,
      "client": client,
    };
    return await API.requestString(url: selectOpportunityMonthlySalesUrl,formData: formData);
  }

  //客户下的合同金额
  static Future<String> selectContractMonthlySales(
      {var sales, String client}) async {
    var formData = {
      "sales": sales,
      "client": client,
    };
    return await API.requestString(url: selectContractMonthlySalesUrl,formData: formData);
  }


  //客户公海列表
  static Future<List<CustomerSeaModel>> getUserHighRule() async {
    Response response=await API.requestResponse(url: getUserHighRuleUrl);

    List<dynamic> dynamicList = response.data["data"];
    List<CustomerSeaModel> list = [];
    for (int i = 0; i < dynamicList.length; i++) {
      CustomerSeaModel customerSeaModel = CustomerSeaModel.fromJson(
          dynamicList[i]);
      if (customerSeaModel.delFlag == 0) {
        list.add(customerSeaModel);
      }
    }
    return list;
  }

  //商机列表
  static Future<BusinessListModel> selectOpportunity({int start = 0,
    int length = 10, var type, var followStatus, String oppoName}) async {
    var formData = {
      'start': start,
      "length": length,
      "type": type,
      "followStatus": followStatus,
      "oppoName": oppoName,
    };
    Response response=await API.requestResponse(url: selectOpportunityUrl,formData: formData);
    dynamic map = response.data["data"];
    return BusinessListModel.fromJson(map);
  }

  //删除线索
  static Future<Map<String, dynamic>> removeOpportunity({String ids,}) async {
    var formData = {
      'ids': "$ids",
    };
    return await API.requestBool(formData: formData,url: removeOpportunityUrl);

  }

  //新增商机(需要放token)
  static Future<Map<String, dynamic>> addOpportunity(
      {String oppoName, String amount, String issueDate,
        String followStatus, String remarks, String owners, String dept, String client}) async {
    Map<String, dynamic> formData = {
      'client': "$client",
      'oppoName': "$oppoName",
      'amount': "$amount",
      'issueDate': "$issueDate",
      'followStatus': "$followStatus",
      "remarks": remarks,
      "owners": "${Data.user.id}",
      "ownersDept": "${Data.user.deptId}",
      "productData": []
    };
    return await API.requestBool(formData: formData,url: addOpportunityUrl,contentType: API.json);
  }


  //新增商机(需要放token)
  static Future<Map<String, dynamic>> editOpportunity(
      {String id, String oppoName, String amount, String issueDate,
        var followStatus, String remarks, String owners, String dept, String client}) async {
    Map<String, dynamic> formData = {
      'id': "$id",
      'client': "$client",
      'oppoName': "$oppoName",
      'amount': "$amount",
      'issueDate': "$issueDate",
      'followStatus': "$followStatus",
      "remarks": remarks,
      "owners": "${Data.user.id}",
      "ownersDept": "${Data.user.deptId}",
      "productData": []
    };
    return await API.requestBool(formData: formData,url: editOpportunityUrl,contentType: API.json);
  }


  //根据id查询商机详情
  static Future<BusinessModel> businessDetail({String id}) async {
    var formData = {
      'id': "$id",
    };
    Response response= await API.requestResponseByCode(url: viewOpportunityUrl,formData: formData);
    return BusinessModel.fromJson(response.data["data"]);
  }

  //商机合同下的产品列表
  static Future<ProductModelList> relateProductList({int start = 0,
    int length = 10, String relationId, String type}) async {
    var formData = {
      'start': start,
      "length": length,
      "relationId": relationId,
      "type": type
    };
    Response response=await API.requestResponse(url: relateProductListUrl,formData: formData);
    return ProductModelList.fromJson(response.data);
  }

  //商机合同下的产品分类列表
  static Future<ProductTypeListModel> selectProType(
      {int start = 0, int length = 10,}) async {
    var formData = {
      'start': start,
      "length": length,
    };
    Response response=await API.requestResponse(url: selectproTypeUrl,formData: formData);
    return ProductTypeListModel.fromJson(response.data);
  }


  //商机合同下的产品列表
  static Future<ProductModelList> selectProProduct({int start = 0,
    int length = 10, String type}) async {
    var formData = {
      'start': start,
      "length": length,
      "type": type //产品分类id
    };
    Response response=await API.requestResponse(url: selectProProductUrl,formData: formData);
    return ProductModelList.fromJson(response.data);
  }


  //商机转移给他人
  static Future<Map<String, dynamic>> changeOwnersOpportunity(
      {String ids, String owners,}) async {
    var formData = {
      "ids": ids,
      'owners': "$owners",
    };
    return await API.requestBool(formData: formData,url: changeOwnersOpportunityUrl,);

  }


  //新增关联产品(需要放token)
  static Future<Map<String, dynamic>> addRelateProduct({List list}) async {
    return await API.requestBool(formData: list,url: addRelateProductUrl,contentType:API.json );

  }


  //修改密码
  static Future<Map<String, dynamic>> updatePW(
      {String oldPW, String newPW,}) async {
    var formData = {
      "oldPW": oldPW,
      'newPW': "$newPW",
    };
    return await API.requestBool(formData: formData,url: updatePWUrl,);
  }


  //合同列表
  static Future<AgreementModelList> selectContract({int start = 0,
    int length = 10, var type, var followStatus, String contractName}) async {
    var formData = {
      'start': start,
      "length": length,
      "type": type,
      "followStatus": followStatus,
      "contractName": contractName,
    };
    Response response=await API.requestResponse(url: selectContractUrl,formData: formData);
    dynamic map = response.data;
    return AgreementModelList.fromJson(map);
  }

  //删除合同
  static Future<Map<String, dynamic>> removeContract({String ids}) async {
    var formData = {
      "ids": ids,
    };
    return await API.requestBool(formData: formData,url: removeContractUrl,);

  }

  //新增合同(需要放token)
  static Future<Map<String, dynamic>> addContract(
      {String contractName, String amount, String opportunity,
        String followStatus, String remarks,  String contractNo,String owners,
        String dept, String client, String contractDate,String ourSigner,String customerSigner}) async {
    Map<String, dynamic> formData = {
      'ourSigner': "$ourSigner",
      'customerSigner': "$customerSigner",
      'contractNo': "$contractNo",
      'client': "$client",
      'opportunity': "$opportunity",
      'contractDate': "$contractDate",
      'contractName': "$contractName",
      'amount': "$amount",
      'followStatus': "$followStatus",
      "remarks": remarks,
      "owners": "${Data.user.id}",
      "ownersDept": "${Data.user.deptId}",
      "productData": []
    };
    return await API.requestBool(formData: formData,url: addContractUrl,contentType:API.json );

  }


  //根据id查询合同详情
  static Future<AgreementModel> viewContract({String id}) async {
    var formData = {
      'id': "$id",
    };
   Response response= await API.requestResponseByCode(url: viewContractUrl,formData: formData);
    return AgreementModel.fromJson(response.data["data"]);

  }



  //新增合同(需要放token)
  static Future<Map<String, dynamic>> editContract(
      {String contractName, String amount, String opportunity,
        String followStatus, String remarks,  String contractNo,String owners,String id,
        String dept, String client, String contractDate,String ourSigner,String customerSigner}) async {
    Map<String, dynamic> formData = {
      'ourSigner': "$ourSigner",
      'id': "$id",
      'customerSigner': "$customerSigner",
      'contractNo': "$contractNo",
      'client': "$client",
      'opportunity': "$opportunity",
      'contractDate': "$contractDate",
      'contractName': "$contractName",
      'amount': "$amount",
      'followStatus': "$followStatus",
      "remarks": remarks,
      "owners": "${Data.user.id}",
      "ownersDept": "${Data.user.deptId}",
      "productData": []
    };
    return await API.requestBool(formData: formData,url: editContractUrl,contentType:API.json );

  }


  //商机转移给他人
  static Future<Map<String, dynamic>> changeOwnersContract(
      {String ids, String owners,}) async {
    var formData = {
      "ids": ids,
      'owners': "$owners",
    };
    return await API.requestBool(formData: formData,url: changeOwnersContractUrl,);
  }

  static Future<String> selectOpportunityNumber() async {
     return await API.requestString(url: selectOpportunityNumberUrl);
  }

  static Future<String> selectClueNumber() async {
     String result= await API.requestString(url: selectClueNumberUrl);
     return result;
  }

  static Future<String> selectContractNumber() async {
    return await API.requestString(url: selectContractNumberUrl);
  }

  static Future<String> selectCustomerNumber() async {
    return await API.requestString(url: selectCustomerNumberUrl);
  }

  //根据id查询合同详情
  static Future<UndoApplyCountModel> undoApplyCount() async {
    Response response= await API.requestResponseByCode(url: undoApplyCountUrl);
    return UndoApplyCountModel.fromJson(response.data["data"]);

  }

}








