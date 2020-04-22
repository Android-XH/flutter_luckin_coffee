import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 用户管理相关
class ReqUser {
  final Dio _dio;

  ReqUser(this._dio);

  /// 注册 可用作登录
  Future<Response> register({
    /// 手机号
    @required String mobile,
    /// 验证码
    @required String code,
  }) {
    return _dio.post('doctor/auth/login',
        data: {"mobile": mobile, "code": code});
  }

  /// 获取用户详情
  Future<Response> detail() {
    return _dio.get('doctor/auth/info');
  }

  /// 查看用户资产
  Future<Response> amount({@required String token}) {
    return _dio.post('/user/amount');
  }
}
