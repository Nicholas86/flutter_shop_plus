import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRouters(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('error: 跳转到错误页面');
      }
    );

    // 配置路由
    router.define(detailPage, handler: detailHandler);
  }
}