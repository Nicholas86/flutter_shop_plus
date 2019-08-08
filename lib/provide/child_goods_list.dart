import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/category/goods.dart';

//ChangeNotifier的混入是不用管理听众
class GoodsListProvider extends ChangeNotifier {

  List<GoodsReal> goodsList = []; //商品列表

  // 更换商品列表
  getGoodsList(List<GoodsReal> list){

    goodsList = list;

    notifyListeners();
  }

  // 获取更多商品列表
  getMoreGoodsList(List<GoodsReal> list){

    goodsList.addAll(list);

    notifyListeners();
  }
}