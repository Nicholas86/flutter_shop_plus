import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/home/models/detail.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/pages/cart/models/cart.dart';

class CartProvider extends ChangeNotifier {

  String cartString = '[]'; // 数组

  List<Cart> carts = [];

  double allPrice = 0; // 总价

  int allGoodsCount = 0; // 商品总数量

  bool isAllCheck = true; // 全选状态

  // 保存
  save(String goodsId, String goodsName, int count, double price, String images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    cartString = prefs.getString('cartInfo');
    var temp = (cartString == null) ? [] : (json.decode(cartString.toString()));
    List<Map> tempList = (temp as List).cast();

    allPrice = 0.0;
    allGoodsCount = 0;

    bool isHave = false;
    int index = 0;
    // 循环, 判断商品是否重复
    tempList.forEach((item){ // item 是具体兑现
      if (item['goodsId'] == goodsId){
        tempList[index]['count'] = item['count'] + 1;
        carts[index].count++;
        isHave = true;
      }

      // 有商品
      if (item['isCheck']){
        allPrice += (carts[index].price * carts[index].count);
        allGoodsCount += carts[index].count;
      }

      index++;
    });

    // 判断没有相同产品
    if (!isHave){
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'images': images,
        'price': price,
        'goodsName': goodsName,
        'count':count,
        'isCheck': true
      };

      tempList.add(newGoods);

      carts.add(Cart.fromJson(newGoods));

      allPrice += (count * price);
      allGoodsCount += count;
    }

    // 将数组转出字符串
    cartString = json.encode(tempList).toString();

    print('字符串=========: ${cartString}');

    prefs.setString('cartInfo', cartString);
    notifyListeners(); // 通知更新界面
  }

  // 清空
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo'); // 清空缓存
    carts.clear(); // 清空数组
    print('清空完成');
    notifyListeners(); // 通知更新界面
  }

  // 查询
  query() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    carts.clear();
    if (cartString == null){
      carts.clear();
    }else{
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item){
        carts.add(Cart.fromJson(item)); // 加入数组
      });
    }

    notifyListeners(); // 通知更新界面
  }

  // 获取购物车中的商品
  getCartInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    carts = [];

    //判断得到的字符串是否有值，如果不判断会报错
    if(cartString == null){
      carts = [];
    }else{
      List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item){
        if(item['isCheck']){
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        }else{
          isAllCheck = false;
        }
        carts.add(new Cart.fromJson(item));
      });
    }

    print('获取购物车中的商品成功: ${carts.length}个');
    // notifyListeners(); // 因为外部使用FutureBuilder,出现不停打印数据的bug,所以需要注释,不通知
  }

  // 删除单个购物车商品
  deleteGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        delIndex=tempIndex;
      }
      tempIndex++; // 增加标记
    });
    tempList.removeAt(delIndex);

    cartString = json.encode(tempList).toString(); // 将数组转成字符串
    prefs.setString('cartInfo', cartString); // 重新保存到本地

    await getCartInfo(); // 请求数据
  }

  // 单选按钮
  changeCheckState(Cart cart) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if (item['goodsId'] == cart.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList[changeIndex] = cart.toJson(); // 对象转成json字符串
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); // 重新保存到本地

    notifyListeners();
    // await getCartInfo(); // 请求数据
  }

  // 点击全选按钮
  changeAllCheckBtn(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    List<Map> newList= []; // 初始化
    for(var item in tempList){
      var newItem = item; // Dart语言循环时, 禁止改变数组
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString); // 重新保存到本地

    notifyListeners();
  }

  // 商品数量加减
  changeReduceAction(Cart cart, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if (item['goodsId'] == cart.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (todo == 'add'){
      cart.count++;
    }else{
      if (cart.count > 1){
        cart.count--;
      }
    }

    tempList[changeIndex] = cart.toJson();

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); // 重新保存到本地

    notifyListeners();
  }


}



