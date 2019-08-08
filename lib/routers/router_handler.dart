import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/home/widgets/detail_page.dart';

// 相当于控制器
Handler detailHandler = Handler(
  handlerFunc: (BuildContext contex, Map<String, List<String>> params){
    String goodsId = params['id'].first;
    print('index>detail>goodsId: ${goodsId}');
    return DetailsPage(goodsId);
  },
);