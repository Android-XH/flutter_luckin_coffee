import 'dart:convert';

import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luckin_coffee/provider/counter_model.dart';
import 'package:flutter_luckin_coffee/provider/order_model.dart';
import 'package:flutter_luckin_coffee/provider/shopping_cart_model.dart';
import 'package:flutter_luckin_coffee/utils/LogUtil.dart';
import 'package:flutter_luckin_coffee/utils/global.dart';
import 'package:flutter_luckin_coffee/routes/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _shoppingCart;

final Router router = Router();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _shoppingCart = prefs.getString('shoppingCart');
  String user = prefs.getString('user');

  LogUtil.init(true);
  if (user != null && user.isNotEmpty) {
    /// 初始化user
    G.user.init(json.decode(user));
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CounterModel()),
        ChangeNotifierProvider.value(value: ShoppingCartModel()),
        ChangeNotifierProvider.value(value: OrderModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ShoppingCartModel _shoppingCartModel =
        Provider.of<ShoppingCartModel>(context);

    if (_shoppingCart != null) {
      Map data = json.decode(_shoppingCart);
      _shoppingCartModel.init(data);
    }

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      navigatorKey: G.navigatorKey,
      title: '怡宁健康互联网医院',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: rgba(0, 0, 0, 0),
          ),
          elevation: 0,
        ),

        // button去除点击后的背景，注意：对appbar中的的button无效
        // buttonTheme: ButtonThemeData(
        //   splashColor: rgba(0, 0, 0, 0),
        //   highlightColor: rgba(0, 0, 0, 0),
        // ),
      ),
      initialRoute: '/',
      onGenerateRoute: router.getRoutes,
    );
  }
}
