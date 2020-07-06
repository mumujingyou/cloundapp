import 'dart:io';

import 'package:cloundapp/data/data.dart';
import 'package:cloundapp/model/crm/UserModel.dart';
import 'package:cloundapp/routes/application.dart';
import 'package:cloundapp/routes/routes.dart';
import 'package:cloundapp/utils/application_util.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String address = "http://192.168.0.163:8080/";

class API {

  static String access_token;
  static String refresh_token;
  static const String formdata = "application/x-www-form-urlencoded";
  static const String json = "application/json";

  static var httpHeaders = {
    'Authorization': 'Bearer ${access_token}',
  };


  static SharedPreferences prefs = null;

  static Future<SharedPreferences> getSharedPreferences() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    return prefs;
  }

  static Dio dio;

  static getDio({String contentType =formdata}) {
    if (dio == null) {
      dio = new Dio();
      dio.options.headers = httpHeaders;
      dio.options.connectTimeout=5000;
      dio.options.receiveTimeout=5000;
    }
    dio.options.contentType =
        ContentType.parse(contentType).toString();
    print(httpHeaders);

    return dio;
  }

  static Future onError(DioError e) async {
    print("error--------------------------");
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      Fluttertoast.showToast(msg: "连接超时");

    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      Fluttertoast.showToast(msg: "请求超时");

    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      Fluttertoast.showToast(msg: "响应超时");

    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      if (e?.response?.statusCode == 401) {
        Fluttertoast.showToast(msg: "登录过期，请重新登录");
        Application.router.navigateTo(
            Application.navigatorKey.currentState.overlay.context,
            "${Routes.login}",
            transition: TransitionType.fadeIn, clearStack: true);
        API.dio = null;
      }
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      Fluttertoast.showToast(msg: "请求取消");

    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
      Fluttertoast.showToast(msg: "网络异常，请检查网络设置");
      Data.isNetUse=false;
    }
  }


//返回值是bool值
  static Future<Map<String, dynamic>> requestBool({var formData, String url,
    String contentType = formdata}) async {
    Response response;
    try {
      print(formData);
      print(url);
      response =
      await getDio(contentType: contentType).post(url, data: formData);
      print(response.data);
      Data.isNetUse=true;

      if (response.data["code"] == 0) {
        return {"msg": response.data["msg"], "data": true};
      } else {
        return {"msg": response.data["msg"], "data": false};
      }
    } catch (e) {
      onError(e);

      print('error:::${e.toString()}');
      return {"msg": "操作失败", "data": false};
    }
  }

//返回值是字符串
  static Future<String> requestString({String url, var formData,
    String contentType = formdata}) async {
    Response response;
    try {
      print(formData);
      print(url);
      response =
      await getDio(contentType: contentType).post(url, data: formData);
      print(response.data);
      Data.isNetUse=true;

      if (response.data["code"] == 0) {
        return response.data["data"].toString();
      } else {
        return "0";
      }
    } catch (e) {
      onError(e);

      print('error:::${e.toString()}');
      return "0";
    }
  }


  static Future<Response> requestResponseByCode(
      {String url, var formData, String contentType =
          formdata}) async {
    Response response;
    try {
      print(formData);
      print(url);
      response =
      await getDio(contentType: contentType).post(url, data: formData);
      print(response.data);
      Data.isNetUse=true;

      if (response.data["code"] == 0) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      onError(e);

      print('error:::${e.toString()}');
      return null;
    }
  }

//返回值Response
  static Future<Response> requestResponse(
      {String url, var formData, contentType =
          formdata}) async {
    Response response;
    try {
      print(formData);
      print(url);
      response =
      await getDio(contentType: contentType).post(url, data: formData);
      print(response.data);
      Data.isNetUse=true;

      return response;
    } catch (e) {
      onError(e);
      print('error:::${e.toString()}');
      return null;
    }
  }


  //get请求
  static Future<Response> get({String url, var formData, contentType =
      formdata}) async {
    Response response;
    try {
      print(formData);
      print(url);
      response = await getDio(contentType: contentType).get(
          url, queryParameters: formData);
      print(response.data);
      Data.isNetUse=true;

      return response;
    } catch (e) {
      print('error:::${e.toString()}');
      return null;
    }
  }

}




