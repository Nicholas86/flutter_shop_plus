import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provide/child_category.dart';

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
        body: Center(
          child: Text("${Provider.of<ChildCategory>(context).noMoreText}"), //1
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
//            Provider.of<DetailProvider>(context, listen: false).getGoodsInfo(goodsId);
          },
        child: Icon(Icons.add),
      ),
    );
  }

  Future _getDetailInfo(BuildContext context) async {
    print('加载完成---------');

//    await Provider.of<DetailProvider>(context).getGoodsInfo(goodsId);

    await Provider.of<DetailProvider>(context, listen: false).getGoodsInfo(goodsId);

    print('加载完成');
    return '完成加载';
  }

}