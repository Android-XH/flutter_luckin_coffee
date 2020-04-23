import 'package:color_dart/color_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luckin_coffee/components/a_button/index.dart';
import 'package:flutter_luckin_coffee/components/a_row/a_row.dart';
import 'package:flutter_luckin_coffee/utils/Icon.dart';
import 'package:flutter_luckin_coffee/utils/global.dart';
import 'package:flutter_luckin_coffee/jsonserialize/user/user_entity.dart';

class Mine extends StatefulWidget {
  static _MineState _mineState;

  getAppBar() => _mineState.createAppBar();

  Mine() {
    _mineState = _MineState();
  }

  _MineState createState() => _MineState();
}

class _MockHomeState extends State<Mine> {
  AppBar createAppBar() {
    /// 配置appbar
    return AppBar(
      centerTitle: true,
      title: Text(
        "我的",
        style: TextStyle(
            color: rgba(0, 0, 0, 1), fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: rgba(255, 255, 255, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(left: 0, right: 0, top: 0),
          child: Image.asset(
            "lib/assets/images/mock/mine.jpg",
            width: G.screenWidth(),
            height: G.screenHeight(),
            fit: BoxFit.fill,
          ),
        ));
  }
}

class _MineState extends State<Mine> {
  AppBar createAppBar() {
    /// 配置appbar
    return AppBar(
      centerTitle: true,
      title: Text(
        "我的",
        style: TextStyle(
            color: rgba(0, 0, 0, 1), fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: rgba(255, 255, 255, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20, right: 20, top: 0),
        color: rgba(248, 248, 248, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// 头部
            buildUser(),

            ///用户数据
            Container(
              margin: EdgeInsets.only(top: 20),
              child: buildLog(),
            ),

            ///用户名片
            Container(
              margin: EdgeInsets.only(top: 30),
              child: buildCard(),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 15),
              child: new Text(
                '我的记录',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: rgba(35, 37, 39, 1)),
              ),
            ),
            buildHistory(),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 15),
              child: new Text(
                '常用工具',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: rgba(35, 37, 39, 1)),
              ),
            ),
            buildSetting()
          ],
        ),
      ),
    );
  }

  ARow buildUser() {
    UserEntity userData = G.user.data;
    int _good = userData == null ? 100 : userData.userInfo.userLog.good;
    return ARow(
      height: 90,
      color: Colors.transparent,
      padding: EdgeInsets.all(0),
      leftChild: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///用户名，星级，好评
            Row(
              children: <Widget>[
                Container(
                    child: new Text(
                        userData == null ? '用户名' : userData.userInfo.doctorName,
                        style: TextStyle(
                          color: rgba(0, 0, 0, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))),
                Container(
                  margin: EdgeInsets.only(left: 3),
                  child: iconEdit(color: rgba(0, 0, 0, 1), size: 14),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13),
                  child: iconstart(color: rgba(255, 98, 0, 1), size: 14),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  child: new Text(
                      userData == null ? '4.0' : userData.userInfo.userLog.star,
                      style: TextStyle(
                        color: rgba(255, 98, 0, 1),
                        fontSize: 16,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 13),
                  child: new Text(
                    '$_good%好评',
                    style: TextStyle(
                      color: rgba(153, 153, 153, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: new Text(
                        userData == null
                            ? '副主任医师'
                            : userData.userInfo.categoryName,
                        style: TextStyle(
                          color: rgba(51, 51, 51, 1),
                          fontSize: 15,
                        ))),
                Container(
                    margin: EdgeInsets.only(top: 5, left: 10),
                    child: new Text('|',
                        style: TextStyle(
                          color: rgba(51, 51, 51, 1),
                          fontSize: 15,
                        ))),
                Container(
                    margin: EdgeInsets.only(top: 5, left: 10),
                    child: new Text('心理卫生科',
                        style: TextStyle(
                          color: rgba(51, 51, 51, 1),
                          fontSize: 15,
                        ))),
              ],
            )
          ],
        ),
      ),
      rightChild: ClipRRect(
          borderRadius: new BorderRadius.circular(27),
          child: userData == null
              ? Image.asset(
                  'lib/assets/images/mine/mine1.png',
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  userData.userInfo.avatarUrl,
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                )),
    );
  }

  ARow buildLog() {
    return ARow(
      leftChild: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: new Text(
                '599',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: new Text(
                '本月收入/元',
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(0, 0, 0, 0.45),
                ),
              ),
            )
          ],
        ),
      ),
      centerChild: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: new Text(
                '599',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: new Text(
                '问诊数/次',
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(0, 0, 0, 0.45),
                ),
              ),
            )
          ],
        ),
      ),
      rightChild: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: new Text(
                '599',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: new Text(
                '服务人数/人',
                style: TextStyle(
                  fontSize: 14,
                  color: rgba(0, 0, 0, 0.45),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildCard() {
    return Container(
      height: 70,
      decoration: new BoxDecoration(
        color: rgba(51, 103, 243, 1),
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: AButton.normal(
                height: 70,
                bgColor: rgba(51, 103, 243, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'lib/assets/images/mine/icon_my_card.png',
                      width: 28,
                      height: 28,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: new Text(
                        '我的名片',
                        style: TextStyle(
                          color: rgba(255, 255, 255, 1),
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  await G.toast('点击我的名片');
                }
            ),
            flex: 1,
          ),
          Container(
            width: 1,
            height: 25,
            color: rgba(255, 255, 255, 1),
          ),
          Expanded(
            child: AButton.normal(
              height: 70,
              bgColor: rgba(51, 103, 243, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/images/mine/icon_server_setting.png',
                    width: 28,
                    height: 28,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: new Text(
                      '服务设置',
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () async {
                await G.toast('点击服务设置');
              }
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Row buildHistory() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: AButton.normal(
                height: 60,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'lib/assets/images/mine/icon_my_order.png',
                        width: 28,
                        height: 28,
                      ),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      child: new Text(
                        '我的接诊',
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(0, 0, 0, 0.45),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  await G.toast('点击我的接诊');
                })),
        Expanded(
            flex: 1,
            child: AButton.normal(
                height: 60,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'lib/assets/images/mine/icon_recipe_history.png',
                        width: 28,
                        height: 28,
                      ),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      child: new Text(
                        '处方记录',
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(0, 0, 0, 0.45),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  await G.toast('点击处方记录');
                })),
        Expanded(
          flex: 1,
          child: AButton.normal(
              height: 60,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'lib/assets/images/mine/icon_ping.png',
                      width: 28,
                      height: 28,
                    ),
                    margin: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    child: new Text(
                      '我的评价',
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(0, 0, 0, 0.45),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () async {
                await G.toast('点击我的评价');
              }),
        ),
      ],
    );
  }

  Row buildSetting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: AButton.normal(
                height: 60,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'lib/assets/images/mine/icon_question.png',
                        width: 28,
                        height: 28,
                      ),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      child: new Text(
                        '常见问题',
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(0, 0, 0, 0.45),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  await G.toast('点击常见问题');
                })),
        Expanded(
            flex: 1,
            child: AButton.normal(
                height: 60,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'lib/assets/images/mine/icon_question.png',
                        width: 28,
                        height: 28,
                      ),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      child: new Text(
                        '常见问题',
                        style: TextStyle(
                          fontSize: 14,
                          color: rgba(0, 0, 0, 0.45),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  await G.toast('点击常见问题');
                })),
        Expanded(
          flex: 1,
          child: Container(
            color: rgba(0, 0, 0, 0),
          ),
        ),
      ],
    );
  }
}
