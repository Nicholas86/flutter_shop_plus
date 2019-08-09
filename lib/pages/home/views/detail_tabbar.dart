import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tabbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DetailProvider>(
      builder: (context, detailProvider, value){
        var isLeft = detailProvider.isLeft;
        var isRight = detailProvider.isRight;

        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              _myTabBarLeft(context, isLeft),
              _myTabBarRight(context, isRight),
            ],
          ),
        );
      },
    );
  }

  // 左边
  Widget _myTabBarLeft(BuildContext context, bool isLeft){

    return InkWell(
      onTap: (){
        print('点击左边');
        Provider.of<DetailProvider>(context).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center, // 居中
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft ? (Colors.pink) : (Colors.black12),
            )
          )
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? (Colors.pink) : (Colors.black12),
          ),
        ),
      ),
    );
  }

  // 右边
  Widget _myTabBarRight(BuildContext context, bool isRight){

    return InkWell(
      onTap: (){
        print('点击右边');
        Provider.of<DetailProvider>(context).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center, // 居中
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: isRight ? (Colors.pink) : (Colors.black12),
                )
            )
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? (Colors.pink) : (Colors.black12),
          ),
        ),
      ),
    );
  }

}