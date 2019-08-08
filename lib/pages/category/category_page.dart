import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/child_goods_list.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/pages/category/category.dart';
import 'package:flutter_shop/pages/category/goods.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/child_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // CategoryBigListModel listCategory = CategoryBigListModel([]);

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
                CategoryGoodsList(), // 商品列表
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
        // 发送分类数据
        Provider.of<ChildCategory>(context, listen: false).getChildCategory(childList, data.mallCategoryId);

        // 获取商品数据
        _getGoodList(context, categoryId: data.mallCategoryId);
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

  // 获取分类数据
  void _getCategory() async {
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      print('${category.message}');
      // 发送值
      Provider.of<ChildCategory>(context, listen: false).getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
      // 获取商品数据
      _getGoodList(context, categoryId: list[0].mallCategoryId);
    });
  }

  // 获取商品列表数据
  void _getGoodList(context, {String categoryId}) {
    // 获取状态管理器里的值
    final child_category = Provider.of<ChildCategory>(context);
    final String _categoryId = child_category.categoryID;

    var data={
      'categoryId':categoryId == null ? _categoryId : categoryId,
      'categorySubId':'',
      'page':1
    };

    print('获取商品列表参数, data:${data}');

    request('getMallGoods',formData:data ).then((val){
      var data = json.decode(val.toString());
      Goods goods = Goods.fromJson(data);
      if (goods.data == null) {
        // 发送空值
        Provider.of<GoodsListProvider>(context, listen: false).getGoodsList([]);
      } else {
        var goodsReals = goods.data as List;
        // 发送值
        Provider.of<GoodsListProvider>(context, listen: false).getGoodsList(goodsReals);
      }
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
          return _rightInkWell(list[index], index);
        },
      ),
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {

    bool isClick = false;
    isClick = ((Provider.of<ChildCategory>(context).childIndex) == index) ? true : false;

    return InkWell(
      onTap: (){
        // 获取子类索引
        Provider.of<ChildCategory>(context, listen: false).changeChildIndex(index, item.mallSubId);

        // 获取商品列表
        _getGoodList(context, item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? (Colors.red): Colors.black,
          ),
        ),
      ),
    );
  }

  // 获取商品列表数据
  void _getGoodList(context, String categorySubId) {

    var data={
      'categoryId':Provider.of<ChildCategory>(context).categoryID,
      'categorySubId':categorySubId,
      'page':1
    };

    print('获取商品列表参数: ${data}');
    request('getMallGoods',formData:data ).then((val){
      var data = json.decode(val.toString());

      Goods goods = Goods.fromJson(data);
      if (goods.data == null) {
          // 发送空值
        Provider.of<GoodsListProvider>(context, listen: false).getGoodsList([]);
      } else {
        var goodsReals = goods.data as List;
        // 发送值
        Provider.of<GoodsListProvider>(context, listen: false).getGoodsList(goodsReals);
      }
    });
  }

}

// 商品列表
class CategoryGoodsList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryGoodsListState();
  }
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsListProvider>(
        builder:(context, goodsListProvider, _){

          try{
            if (Provider.of<ChildCategory>(context).page == 1){
              // 每次切换, 滑到顶部
              scrollController.jumpTo(0.0);
            }
          }catch(e){
            print('进入页面第一次初始化:${e}');
          }

          // 判断空值, 提示信息
          if (goodsListProvider.goodsList.length == 0){
            return Text(
              '暂时没有数据'
            );
          }

          return Expanded(
              child: Container(
                color: Colors.white,
                width: ScreenUtil().setWidth(570),
                child: EasyRefresh(
                  footer: ClassicalFooter(
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      noMoreText: Provider.of<ChildCategory>(context).noMoreText,
                      infoText: '加载中。。。',
                      loadedText: '加载完成',
                      showInfo: true,
                      loadReadyText: '上拉加载'
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: goodsListProvider.goodsList.length,
                    itemBuilder: (context, index){
                      return _listWidget(goodsListProvider.goodsList, index);
                    },
                  ), 
                    onRefresh: () async{
                      print('下拉刷新');

                    },
                    onLoad:() async{
                      print('上拉加载');
                      _getMoreList();
                    }
                ),
              )
          );

          /*
          return Container(
            color: Colors.red,
            width: ScreenUtil().setWidth(570),
            height: ScreenUtil().setHeight(986),
            child: ListView.builder(
              itemCount: goodsListProvider.goodsList.length,
              itemBuilder: (context, index){
                return _listWidget(goodsListProvider.goodsList, index);
              },
            ),
          );
          */
        }
    );
  }


  Widget _goodsImage(List list, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(
        list[index].image,
      ),
    );
  }

  Widget _goodsName(List list, int index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(270),
      child: Text(
        list[index].goodsName,
        maxLines: 2, // 2行
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  Widget _goodsPrice(List list, int index){
    return Container(
      width: ScreenUtil().setWidth(270),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ¥${list[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30)
            ),
          ),
          Text(
            '¥${list[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(30),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List list, int index) {
    return InkWell(
      onTap: (){
        print('点击:${index}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index),
              ],
            )
          ],
        ),
      ),
    );
  }

  // 获取商品列表数据
  void _getMoreList() {

    // 增加页数
    Provider.of<ChildCategory>(context).addPage();

    var data = {
      'categoryId':Provider.of<ChildCategory>(context).categoryID,
      'categorySubId':Provider.of<ChildCategory>(context).subId,
      'page':Provider.of<ChildCategory>(context).page
    };

    print('获取商品列表参数: ${data}');
    request('getMallGoods',formData:data ).then((val){
      var data = json.decode(val.toString());

      Goods goods = Goods.fromJson(data);
      if (goods.data == null) {
        // 发送提示信息
        Provider.of<ChildCategory>(context, listen: false).changeNoMoreText('没有更多数据');
        // 显示toast信息
        Fluttertoast.showToast(
            msg: "已经到到底了",
            toastLength: Toast.LENGTH_SHORT, // 插件大小
            gravity: ToastGravity.CENTER, // 提示位置
            timeInSecForIos: 1, //
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        var goodsReals = goods.data as List;
        // 发送值
        Provider.of<GoodsListProvider>(context, listen: false).getMoreGoodsList(goodsReals);
      }
    });
  }
}
