import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart_info.dart';
import 'package:flutter_shop/pages/cart/models/cart.dart';
import 'package:flutter_shop/pages/cart/views/item.dart';
import 'package:flutter_shop/pages/cart/views/bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          title: Text(
            '购物车'
          ),
        ),
        body: FutureBuilder(
          future: _getCartInfo(context),
            builder: (context, snapshot){
              if (snapshot.hasData){
                List carts = Provider.of<CartProvider>(context).carts;

                return Stack(
                  children: <Widget>[
                    _listView(carts),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Bottom(),
                    ),
                  ],
                );

              }else {
                return CircularProgressIndicator();
              }
            },
        ),
    );
  }

  Widget _listView(List carts){
    return ListView.builder(
      itemCount: carts.length,
      itemBuilder: (context, index){
        return Item(carts[index]);
      },
    );
  }

  Future<String> _getCartInfo(BuildContext context, ) async{
    await Provider.of<CartProvider>(context).getCartInfo();
    return 'end';
  }
}