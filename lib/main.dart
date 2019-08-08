import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index/widgets/index_page.dart';
import 'package:provider/provider.dart';
import 'provide/child_category.dart';
import 'provide/child_goods_list.dart';
import 'provide/detail_info.dart';
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

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        // debugShowCheckedModeBanner: false, /// debug模式
        onGenerateRoute: Application.router.generator, // 配置路由
        theme: ThemeData( /// 主题
          primarySwatch: Colors.pink,
        ),
        home: MultiProvider(providers: [ // 管理多个状态
            ChangeNotifierProvider(builder: (_) => ChildCategory()), // 分类
            ChangeNotifierProvider(builder: (_) => GoodsListProvider()), // 商品列表
            ChangeNotifierProvider(builder: (_) => DetailProvider()), // 商品详情
          ],
          child: IndexPage(),
        ),
      ),
    );


    /*
    return MultiProvider(
      providers: [ // 全局注册状态管理器
       ChangeNotifierProvider(builder: (_) => ChildCategory()),
        ChangeNotifierProvider(builder: (_) => GoodsListProvide()),
     ],
      child: Container(
        child: MaterialApp(
          title: 'Test',
          //去掉DEBUG字样
          debugShowCheckedModeBanner: false,
          //设置主题
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage(),
        ),
      ),
    );
    */

  }
}


