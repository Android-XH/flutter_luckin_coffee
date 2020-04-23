import 'dart:async';

import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_luckin_coffee/components/a_button/index.dart';
import 'package:flutter_luckin_coffee/utils/LogUtil.dart';
import 'package:flutter_luckin_coffee/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMail extends StatefulWidget {
  LoginMail({Key key}) : super(key: key);

  _LoginMailState createState() => _LoginMailState();
}

class _LoginMailState extends State<LoginMail> {
  static Map phone = {"value": null, "verify": true};
  static Map code = {"value": null, "verify": true};

  SharedPreferences prefs;

  /// 开始倒计时 时间
  int startTime;

  /// 当前倒计时 时间
  int countDownTime = 0;

  /// 总倒计时时长
  final int speed = 60;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      startTime = prefs.getInt('startTime');

      int nowTime = G.getTime();

      if (startTime != null && startTime > 0) {
        if (nowTime - startTime > 60) {
          prefs.remove('startTime');
        } else {
          countDown();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  /// 获取验证码
  getEmailCode() async {
    try {
      var res =
          await G.req.verificationCode.getMailCode(mobile: phone['value']);
      if (res.data == null) return;
      G.toast('获取验证码成功');
      startTime = G.getTime();
      countDown();
    } catch (e) {
      G.toast('获取验证码失败');
    }
  }

  /// 倒计时
  countDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      int nowTime = G.getTime();
      int result = speed - (nowTime - startTime);
      if (result < 0) {
        prefs.remove('startTime');
        _timer?.cancel();
      }

      setState(() {
        countDownTime = result;
      });
    });
  }

  /// 登录
  login() async {
    if (!phone['verify'] || phone['value'] == null) {
      return G.toast('输入手机号有误');
    }
    if (!code['verify'] || code['value'] == null) {
      return G.toast('验证码不正确');
    }

    /// 登录前移除user， 不然登录会提示token错误
    prefs.remove('user');

    try {
      var res = await G.req.user
          .register(mobile: phone['value'], code: code['value']);
      Map<String, dynamic>  data = res.data;
      if(data['errno']==0){
        Map json = data['data'];
        G.user.init(json);
        await G.toast('登录成功');
        G.pushNamed('/mine');
      }
    } catch (e) {
      LogUtil.e("登录异常"+e.toString());
    }
  }

  getUserDetail(String token) async {
    var res = await G.req.user.detail();

    var data = res.data;

    Map json = data['data']['userInfo'];
    json['token'] = token;

    G.user.init(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppbar(context: context, borderBottom: false),
      body: Container(
        color: hex('#fff'),
        padding: EdgeInsets.only(left: 35, right: 35, top: 87),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 40),
              width: 65,
              height: 65,
              child: Image.asset(
                'lib/assets/images/icon_logo.png',
                fit: BoxFit.cover,
              ),
            ),

            /// 输入手机号
            Container(
              height: 55,
              decoration: BoxDecoration(border: G.borderBottom()),
              child: TextField(
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    hintText: '请输入手机号',
                    hintStyle: TextStyle(
                      fontSize: 14,
                    )),
                onChanged: (e) {
                  setState(() {
                    phone['value'] = e;
                    phone['verify'] = true;
                  });
                },
              ),
            ),

            /// 验证码
            Container(
              height: 55,
              decoration: BoxDecoration(border: G.borderBottom()),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: '请输入验证码',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          )),
                      onChanged: (e) {
                        setState(() {
                          code['value'] = e;
                          code['verify'] = e.length == 6 ? true : false;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: rgba(242, 242, 242, 1)))),
                  ),
                  buildGetEmailCode()
                ],
              ),
            ),

            /// 确认
            Container(
              margin: EdgeInsets.only(top: 20),
              child: AButton.normal(
                  width: 300,
                  child: Text('登录/注册', style: TextStyle(fontSize: 18)),
                  bgColor: rgba(30, 96, 249, 1),
                  borderRadius: BorderRadius.circular(47.0),
                  color: hex('#fff'),
                  onPressed: () => login()),
            ),

            /// 协议
//            Container(
//            margin: EdgeInsets.only(top: 10),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center ,
//              children: <Widget>[
//                Text('点击确定，即表示以阅读并同意', style: TextStyle(
//                  fontSize: 12,
//                  color: rgba(153, 153, 153, 1)
//                ),),
//                InkWell(
//                  child: Text('《注册会员服务条款》', style: TextStyle(
//                    color: rgba(85, 122, 157, 1),
//                    fontSize: 12
//                  ),),
//                  onTap: () => Navigator.pushNamed(context, '/user_agreement'),
//                )
//            ],),
//          )
          ],
        ),
      ),
    );
  }

  /// 获取验证码
  Container buildGetEmailCode() {
    return Container(
      child: AButton.normal(
          child: Text(countDownTime <= 0
              ? "获取验证码"
              : countDownTime < 10 ? '0$countDownTime' : '$countDownTime'),
          color: phone['verify'] && phone['value'] != null
              ? rgba(85, 122, 157, 1)
              : rgba(166, 166, 166, 1),
          onPressed: () {
            if (countDownTime > 0) return;
            getEmailCode();
          }),
    );
  }
}
