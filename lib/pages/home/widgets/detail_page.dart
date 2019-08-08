import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/pages/home/views/detail_top.dart';

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
              return Container(
                child: Column(
                  children: <Widget>[
                    Top(),
                  ]
                )
              );
            }else{
              return Text('加载中........');
            }
        })
      );
  }

  Future _getDetailInfo(BuildContext context) async {

    await Provider.of<DetailProvider>(context).getGoodsInfo(goodsId);

    print('加载完成');
    return '完成加载';
  }

}