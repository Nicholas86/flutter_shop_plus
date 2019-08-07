import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/category/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory extends ChangeNotifier {

  List<BxMallSubDto> childCategoryList = []; //商品列表
  String categoryID;

  //点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id){

    BxMallSubDto subDto = BxMallSubDto();
    subDto.mallSubId='';
    subDto.mallCategoryId='00';
    subDto.mallSubName = '全部';
    subDto.comments = 'null';
    childCategoryList = [subDto];
    childCategoryList.addAll(list);

    // 分类ID
    categoryID = id;

    notifyListeners();
  }

}