import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'dart:io';
import '../config/service_url.dart';
import '../config/httpHeaders.dart';

// 获取首页主题内容
Future request(url,{formData})async{
  try{
    //print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data:formData);
    }
    if(response.statusCode==200){
      // print('response:======>${response.data}');
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}
