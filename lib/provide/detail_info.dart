import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/home/models/detail.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';

class DetailProvider with ChangeNotifier {

  // 商品详情
  Detail detail = null;

  bool isLeft = true;
  bool isRight = false;

  // tabbar的切换方法
  changeLeftAndRight(String changeState){
    if (changeState == 'left'){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //从后台获取商品数据
  getGoodsInfo(String id) async{
    var formData = {
      'goodId': id,
    };

    print('------------- ${formData}');
    // 请求数据
    await request('getGoodDetailById', formData: formData).then((val){
      var response = json.decode(val.toString());
      detail = Detail.fromJson(response);
      notifyListeners();
    });
  }

}