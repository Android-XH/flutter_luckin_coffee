import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_luckin_coffee/utils/LogUtil.dart';
import 'package:flutter_luckin_coffee/utils/global.dart';

/// 初始化dio
Dio initDio() {
  BaseOptions _baseOptions = BaseOptions(
      //测试域名 https://api.yiningjk.com:9182/
      //生产域名 https://api.yiningjk.com:8280/
      baseUrl: "https://api.yiningjk.com:9182/",
      responseType: ResponseType.json,
      receiveTimeout: 1000 * 5,
      connectTimeout: 1000 * 10);

  Dio dio = Dio(_baseOptions);

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    if (G.user.data != null) {
      options.queryParameters['X-Litemall-Token'] = G.user.data.token;
    }
    return options;
  }, onResponse: (Response response) async {
    // 在返回响应数据之前做一些预处理
    LogUtil.e('服务器返回数据>>> $response');
    var parsedJson = json.decode(response.toString());
    if (parsedJson['errno'] != 0) {
      await G.toast(parsedJson['errmsg']);
      response.data=null;
    }else{
      response.data=parsedJson;
    }
    return response;
  }, onError: (DioError e) async {
    // G.toast(e.message);
    // 当请求失败时做一些预处理
    LogUtil.e(e.toString());
    return e; //continue
  }));

  return dio;
}
