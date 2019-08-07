import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/category/goods.dart';

//ChangeNotifier的混入是不用管理听众
class ChildGoodsListProvide extends ChangeNotifier {

  List<GoodsReal> goodsList = []; //商品列表

  //商品列表
  getGoodsList(List<GoodsReal> list){

    notifyListeners();
  }

}