import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart_info.dart';
import 'package:flutter_shop/pages/cart/models/cart.dart';

class Count extends StatelessWidget {

  final Cart cart;
  Count(this.cart);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(165.0),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        // color: Colors.red,
       border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
          children: <Widget>[
            _reduceBtn(context),
            _midNum(),
            _addBtn(context),
          ],
      ),
    );
  }

  // 左边 减 按钮
  Widget _reduceBtn(BuildContext context){
    return InkWell(
      onTap: (){
        print('左边 减 按钮');
        Provider.of<CartProvider>(context).changeReduceAction(cart, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45.0),
        height: ScreenUtil().setHeight(45.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Text('-'),
      ),
    );
  }

  Widget _midNum(){
    return Expanded( // 剩余的所有宽度都赋予中间数字
        child: Container(
          // color: Colors.blue,
          child: Text('${cart.count}'),
          alignment: Alignment.center, // 居中显示
        ),
    );
  }

  // 右边 加 按钮
  Widget _addBtn(BuildContext context){
    return InkWell(
      onTap: (){
        print('右边 加 按钮');
        Provider.of<CartProvider>(context).changeReduceAction(cart, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45.0),
        height: ScreenUtil().setHeight(45.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(width: 1, color: Colors.black12)
            )
        ),
        child: Text('+'),
      ),
    );
  }

}