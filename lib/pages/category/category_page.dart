import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/pages/category/category.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provide/child_category.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // CategoryBigListModel listCategory = CategoryBigListModel([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(), // 左侧
            Column(
              children: <Widget>[
                RightCategoryNav(), // 右侧
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 左侧导航
class LeftCategoryNav extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LeftCategoryNavState();
  }
}

class LeftCategoryNavState extends State<LeftCategoryNav> {

  // 左侧数据
  List list = [];
  var list_index = 0; // 选中的索引

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration( // 右侧的灰色线
        border: Border(
          right: BorderSide( // 边框
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
          itemCount: list.length,
        itemBuilder: (context, index){
            return _leftInkWell(index);
        },
      ),
    );
  }


  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (list_index == index) ? true : false;
    return InkWell(
      onTap:(){
        print('点击分类');

        // 记录选中索引
        setState(() {
          list_index = index;
        });

        var data = list[index] as Data;
        var childList = data.bxMallSubDto;
        // 发送值
        Provider.of<ChildCategory>(context, listen: true).getChildCategory(childList, data.mallCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100), // 高、可自己调试
        padding: EdgeInsets.only(left: 10.0, top: 20.0), // 内边距
        decoration: BoxDecoration( // 盒子
          color: isClick ? (Color.fromRGBO(236, 236, 236, 1.0)) : (Colors.white), // 选中状态
          border: Border( // 设置边框
            bottom: BorderSide( // 底边框、宽为1
              width: 1,
              color: Colors.black26
            )
          )
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  // 获取数据
  void _getCategory() async {
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      print('${category.message}');
      // 发送值
      Provider.of<ChildCategory>(context, listen: true).getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

}

// 右侧导航
class RightCategoryNav extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RightCategoryNavState();
  }
}

class RightCategoryNavState extends State<RightCategoryNav> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 获取状态管理器里的值
    final child_category = Provider.of<ChildCategory>(context);
    final List list = child_category.childCategoryList;

    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570),
      decoration: BoxDecoration( // 右侧的灰色线
          color: Colors.white,
          border: Border(
              bottom: BorderSide( // 边框
                  width: 1,
                  color: Colors.black12
              )
          )
      ),
      child: ListView.builder( // 表视图
        scrollDirection: Axis.horizontal, // 横向
        itemCount: list.length, // 个数
        itemBuilder: (context, index){
          return _rightInkWell(list[index]);
        },
      ),
    );
  }

  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: (){
        print('点击${item}');
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

}
