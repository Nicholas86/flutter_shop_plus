import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart_info.dart';
import 'package:flutter_shop/pages/cart/models/cart.dart';
import 'package:flutter_shop/pages/cart/views/count.dart';

class Item extends StatelessWidget {
  final Cart cart;
  Item(this.cart);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12
          )
        )
      ),
      child: Row(
        children: <Widget>[
          _checkBtn(context, cart),
          _goodsImage(cart),
          _goodsName(cart),
          _goodsPrice(context, cart)
        ],
      ),
    );
  }

  Widget _checkBtn(BuildContext context, Cart cart){
    return Container(
      child: Checkbox(
        value: cart.isCheck, // 是否选中
        onChanged: (bool val){
          print('选中: ${cart.goodsName}');
          cart.isCheck = val; // 改变选中状态
          Provider.of<CartProvider>(context).changeCheckState(cart);
        },
        activeColor: Colors.red,
      ),
    );
  }

  // 商品图片
  Widget _goodsImage(Cart cart){
    return Container(
      width: ScreenUtil().setWidth(150.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.black12
        )
      ),
      child: Image.network(cart.images),
    );
  }

  // 商品名称
  Widget _goodsName(Cart cart){
    return Container(
      // color: Colors.amber,
      width: ScreenUtil().setWidth(300.0),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(cart.goodsName),
          Count(cart),
        ],
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(BuildContext context, Cart cart){
    return Container(
      width: ScreenUtil().setWidth(150.0),
      // color: Colors.red,
      alignment: Alignment.centerRight, // 靠右居中
      child: Column(
        children: <Widget>[
          Text('¥${cart.price}'),
          Container(
            child: InkWell(
              onTap: (){
                print('删除商品: ${cart.goodsName}{');
                Provider.of<CartProvider>(context).deleteGoods(cart.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black12,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

}