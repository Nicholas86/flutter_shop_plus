import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/pages/cart/widgets/cart_page.dart';
import 'package:flutter_shop/pages/category/widgets/category_page.dart';
import 'package:flutter_shop/pages/home/widgets/home_page.dart';
import 'package:flutter_shop/pages/member/widgets/member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
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

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

//  int currentInex = 0;
  var currentPage;

  @override
  Widget build(BuildContext context) {
    // 初始化设计尺寸
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Consumer<CurrentIndexProvider>(
        builder:(context, currentIndexProvider, _){

          int currentIndex = currentIndexProvider.currentIndex;

          return Scaffold (
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: bottoms,
              onTap: (index){
                Provider.of<CurrentIndexProvider>(context).changeCurrentIndex(index);
              },
            ),
            body: IndexedStack(
              index: currentIndex,
              children: tabBodies,
            ),
          );
        });
  }
}
