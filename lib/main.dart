import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';
import 'provide/child_category.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ // 全局注册状态管理器
          ChangeNotifierProvider(builder: (_) => ChildCategory()),
        ],
        child: Consumer<ChildCategory>(
            builder:(context, childCategory, _){
              return Container(
                child: MaterialApp(
                  title: '百姓生活+',
                  // debugShowCheckedModeBanner: false, /// debug模式
                  theme: ThemeData( /// 主题
                    primarySwatch: Colors.pink,
                  ),
                  home: IndexPage(),
                ),
              );
            },
        ),
    );
  }
}


