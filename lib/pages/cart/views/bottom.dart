import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart_info.dart';
import 'package:flutter_shop/pages/cart/models/cart.dart';

class Bottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _selectAllBtn(context),
          _allPrice(context),
          _goBtn(context),
        ],
      ),
    );
  }

  // 全选按钮
  Widget _selectAllBtn(BuildContext context){

    // 从状态管理器里获取全选
    bool isAllCheck = Provider.of<CartProvider>(context).isAllCheck;

    return Container(
      // color: Colors.black12,
      child: Row(
        children: <Widget>[
          Checkbox(
              value: isAllCheck,
              onChanged: (bool val){
                print('全选按钮');
                Provider.of<CartProvider>(context).changeAllCheckBtn(val);
              },
              activeColor: Colors.pink,
          ),
          Text(
            '全选'
          )
        ],
      ),
    );
  }

  // 合计
  Widget _allPrice(BuildContext context){

    // 从状态管理器里获取总价
    double allPrice = Provider.of<CartProvider>(context).allPrice;

    return Container(
      // color: Colors.blue,
      width: ScreenUtil().setWidth(430.0),
      child: Column(
        children: <Widget>[
          Row(
            // 方便自适应
            mainAxisAlignment: MainAxisAlignment.end, // 子widget的排列方式, 从右往左排列。

            children: <Widget>[

              Container(
                // color: Colors.green,
                child: Text(
                  '合计:',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),

              Container(
                // color: Colors.black,
                child: Text(
                  '¥ ${allPrice}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    color: Colors.red
                  ),
                ),
              )
            ],
          ),

          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight, // 右对齐
            child: Text(
              '满10元免配送费, 预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 结算按钮
  Widget _goBtn(BuildContext context){
    // 从状态管理器里获取总数量
    int allGoodsCount = Provider.of<CartProvider>(context).allGoodsCount;

    return Container(
      // color: Colors.black38,
      width: ScreenUtil().setWidth(160.0),
      padding: EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: (){
          print('结算按钮');
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center, // 居中对齐
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}