import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/home/models/detail.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';

class DetailProvider with ChangeNotifier {

  // 商品详情
  Detail detail = null;

  //从后台获取商品数据
  getGoodsInfo(String id) {
    var formData = {
      'goodId': id,
    };

    print('------------- ${formData}');
    // 请求数据
    request('getGoodDetailById', formData: formData).then((val){
      var response = json.decode(val.toString());
      print(response);
      detail = Detail.fromJson(response);
      notifyListeners();
    });
  }

}