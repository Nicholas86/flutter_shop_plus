import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/pages/home/views/detail_top.dart';
import 'package:flutter_shop/pages/home/views/detail-explain.dart';
import 'package:flutter_shop/pages/home/views/detail_tabbar.dart';
import 'package:flutter_shop/pages/home/views/detail_web.dart';
import 'package:flutter_shop/pages/home/views/detail_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed: (){
              print('返回上一页');
              Navigator.pop(context);
            },
          ),
          title: Text('商品详细页'),
        ),
        body:FutureBuilder(
          future: _getDetailInfo(context) ,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Stack(
                children: <Widget>[
                      Container(
                          child: ListView( // 用listView的好处是不会溢出
                        children: <Widget>[
                              Top(),
                              Explain(),
                              Tabbar(),
                             Web(),
                        ]
                          )
                        ),
                  Positioned(
                      bottom: 0,
                    left: 0,
                    child: Bottom(),
                  ),
                ],
              );

            }else{
              return Text('加载中........');
            }
        })
      );
  }

  // 请求数据
  Future _getDetailInfo(BuildContext context) async {
    await Provider.of<DetailProvider>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }

}