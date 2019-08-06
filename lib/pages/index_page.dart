import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './cart_page.dart';
import './category_page.dart';
import './home_page.dart';
import './index_page.dart';
import './member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {

  // 常量
  final List<BottomNavigationBarItem> bottoms = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        title: Text('分类')
    ),BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: Text('购物车')
    ),BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: Text('会员中心')
    ),
  ];

  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentInex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentInex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 初始化设计尺寸
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    // TODO: implement build
    return Scaffold (
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentInex,
        items: bottoms,
        onTap: (index){
          setState(() {
            currentInex = index;
            currentPage = tabBodies[currentInex];
          });
        },
      ),
      body: currentPage,
    );
  }
}