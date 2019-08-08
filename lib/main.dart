import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';
import 'provide/child_category.dart';
import 'provide/child_goods_list.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        // debugShowCheckedModeBanner: false, /// debug模式
        theme: ThemeData( /// 主题
          primarySwatch: Colors.pink,
        ),
        home: MultiProvider(providers: [ // 管理多个状态
            ChangeNotifierProvider(builder: (_) => ChildCategory()), // 分类
            ChangeNotifierProvider(builder: (_) => GoodsListProvider()), // 商品列表
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


