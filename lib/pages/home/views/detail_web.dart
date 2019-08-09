import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/home/models/detail.dart';
import 'package:flutter_html/flutter_html.dart';

class Web extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DetailProvider>(
        builder:(context, detailProvider, value) {
          var isLeft = detailProvider.isLeft;

          GoodInfo goodsInfo = detailProvider.detail.data.goodInfo;

          // print('${goodsInfo.goodsDetail}');

          return Text(
              '加载中。。。'
          );

          if (goodsInfo != null) {
            return Container(
              child: Html(data: goodsInfo.goodsDetail),
            );
          }else {
            return Text(
              '加载中。。。'
            );
          }

        });
  }
}