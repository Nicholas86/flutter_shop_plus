import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index/widgets/index_page.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'package:provider/provider.dart';
import 'provide/child_category.dart';
import 'provide/child_goods_list.dart';
import 'provide/detail_info.dart';
import 'provide/cart_info.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/routers.dart';
import 'package:flutter_shop/routers/application.dart';


void main() {
  // Provider.debugCheckInvalidValueType = null;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // 初始化路由
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;

    return MultiProvider(
      providers: [ // 全局注册状态管理器, 所有widget都可以接收到值, 包括子widget。 重点
        ChangeNotifierProvider<ChildCategory>(builder: (_) => ChildCategory()), // 分类
        ChangeNotifierProvider<GoodsListProvider>(builder: (_) => GoodsListProvider()), // 商品列表
        ChangeNotifierProvider<DetailProvider>(builder: (_) => DetailProvider()), // 商品详情
        ChangeNotifierProvider<CartProvider>(builder: (_) => CartProvider()), // 购物车
        ChangeNotifierProvider<CurrentIndexProvider>(builder: (_) => CurrentIndexProvider()), // 当前tabBar下标
     ],
      child: Container(
        child: MaterialApp(
          title: '百姓生活+',
          //去掉DEBUG字样
          // debugShowCheckedModeBanner: false,
          //设置主题
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage(),
        ),
      ),
    );

  }
}


