import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart_info.dart';
import 'package:flutter_shop/pages/home/models/detail.dart';
import 'package:flutter_shop/provide/current_index.dart';


class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 从状态管理里面获取商品数据
    GoodInfo goodsInfo = Provider.of<DetailProvider>(context).detail.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    double price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){
              print('左边');
              Provider.of<CurrentIndexProvider>(context).changeCurrentIndex(2);
              Navigator.pop(context);
            },
            child: Container(
              width: ScreenUtil().setWidth(110.0),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35.0,
                color: Colors.red,
              ),
            ),
          ),

          InkWell(
            onTap: () async {
              print('加入购物车');
              await Provider.of<CartProvider>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80.0),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28.0)
                ),
              ),
            ),
          ),

          InkWell(
            onTap: () async {
              print('立即购买');
//              await Provider.of<CartProvider>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80.0),
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28.0)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}