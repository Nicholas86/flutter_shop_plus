import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/home/models/detail.dart';

class Top extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DetailProvider>(
        builder:(context, detailProvider, value){
          // Provider.of<DetailProvider>(context).detail;
          GoodInfo goodsInfo = detailProvider.detail.data.goodInfo;

          if (goodsInfo != null){
            return Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _goodsImage(goodsInfo.image1),
                  _goodsName(goodsInfo.goodsName),
                  _goodsNumber(goodsInfo.goodsSerialNumber),
                  _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
                ],
              ),
            );
          }else{
            return Text('正在加载中......');
          }
        });
  }

  // 图片
  Widget _goodsImage(String url){
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  // 名称
  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }

  // 编号
  Widget _goodsNumber(String num){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号: ${num}',
        style: TextStyle(
          color: Colors.black12
        ),
      ),
    );
  }

  // 商品价格方法

  Widget _goodsPrice(presentPrice,oriPrice){

    return  Container(
              width: ScreenUtil().setWidth(730),
              padding: EdgeInsets.only(left:15.0),
              margin: EdgeInsets.only(top:8.0),
              child: Row(
              children: <Widget>[
                    Text(
                       '￥${presentPrice}',
                      style: TextStyle(
                      color:Colors.pinkAccent,
                    fontSize: ScreenUtil().setSp(40),
                    ),),
                   Text(
                      '市场价:￥${oriPrice}',
                        style: TextStyle(
                        color: Colors.black26,
                   decoration: TextDecoration.lineThrough
                    ),)
              ],),
            );
    }
}