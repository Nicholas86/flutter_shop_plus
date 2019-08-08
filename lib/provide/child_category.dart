import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/category/models/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory extends ChangeNotifier {

  List<BxMallSubDto> childCategoryList = []; //商品列表
  String categoryID; // 分类ID
  int childIndex = 0; // 子类高亮索引
  String subId = ''; // 子类ID
  int page = 1; // 页数
  String noMoreText = ''; // 无数据提示文字

  // 点击左侧导航更换
  getChildCategory(List<BxMallSubDto> list, String id){
    // 每次切换，清空
    childIndex = 0;
    // 页数置1
    page = 1;
    // 提示信息
    noMoreText = '';

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

  // 点击右侧导航更换
  changeChildIndex(int index, String id){
    childIndex = index;
    // 子类ID
    subId = id;
    // 页数置1
    page = 1;
    // 提示信息
    noMoreText = '';

    notifyListeners();
  }

  // 页数增加
  addPage() {
    page++;
  }

  // 改变提示文本
  changeNoMoreText(String text){
    noMoreText = text;
    notifyListeners();
  }
}