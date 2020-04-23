import 'dart:async';

import 'package:color_dart/HexColor.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luckin_coffee/components/a_button/index.dart';
import 'package:flutter_luckin_coffee/utils/global.dart';

class Launch extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Launch> {
  /// 总倒计时时长
  int _countdownNum = 3;

  Timer _timer;


  @override
  void initState() {
    super.initState();
    countDown();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  /// 倒计时
  countDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        if (_countdownNum > 0) {
          _countdownNum--;
        } else {
          G.pushNamed('/login_mail');
          _timer.cancel();
          _timer = null;
        }
      });
    });
  }

  /// 跳过
  Container buildGetEmailCode() {
    return Container(
      alignment: Alignment.topRight,
      child: AButton.normal(
        color: rgba(112, 128, 144,.45),
          child: Text(
            '跳过 $_countdownNum',
          ),
          onPressed: () {
            G.pushNamed('/login_mail');
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: hex('#fff'),
        padding: EdgeInsets.only(left: 35, right: 35, top: 87),
        child: Column(
          children: <Widget>[
            buildGetEmailCode(),
            Container(
              margin: EdgeInsets.only(top: 40),
              width: 65,
              height: 65,
              child: Image.asset(
                'lib/assets/images/icon_logo.png',
                fit: BoxFit.cover,
              ),
            ),

            //文字显示
            Container(
                height: 55,
                margin: EdgeInsets.only(top: 30),
                child: Center(
                  child: new Text(
                    '怡宁健康互联网医院',
                    style: new TextStyle(
                        fontSize: 22.0,
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
