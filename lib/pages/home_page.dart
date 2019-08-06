import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import '../service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  // 传参
  var formData = {'lon':'115.02932','lat':'35.76189'};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text('百姓生活+')),
      body: FutureBuilder(
          future:request('homePageContext',formData:formData),
          builder: (context, snapshot){
            if (snapshot.hasData){
              var data = json.decode(snapshot.data.toString());

              // 轮播组件
              List<Map> swipers = (data['data']['slides'] as List).cast();

              // 网格组价
              List<Map> navigators = (data['data']['category'] as List).cast();

              // 广告
              String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];

              // 店长推荐
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];

              // 商品推荐
              List<Map> recommands = (data['data']['recommend'] as List).cast();

              return SingleChildScrollView ( // 上下滑动
                    child: Column(
                      children: <Widget>[
                        SwiperDily(swiperDateList: swipers), // 轮播
                        TopNavigator(navigatorList: navigators), // 网格
                        AdBanner(adPicture: adPicture), // 广告
                        LeaderPhone(image: leaderImage, phone: leaderPhone), // 店长电话
                        Recommand(recommandList: recommands) // 推荐
                      ],
                    ),
                );
            }else{
              return Center (
                child: Text('数据加载中。。。')
              );
            }
          }
      ),
    );
  }

}

// 轮播图
class SwiperDily extends StatelessWidget {

  // 接收外部传进来的数据
  final List swiperDateList;

  // 便利构造器方法
  SwiperDily({this.swiperDateList});

  @override
  Widget build(BuildContext context) {

    return Container (
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network('${swiperDateList[index]['image']}', fit: BoxFit.fill,); // 满屏
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }

}

// 网格视图
class TopNavigator extends StatelessWidget {

  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (this.navigatorList.length > 10){
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
        color: Colors.amber,
        height: ScreenUtil().setHeight(320),
        padding: EdgeInsets.all(3.0), // 内边距
        // 网格视图
        child: GridView.count(
          crossAxisCount: 5, // 每行5个
          padding: EdgeInsets.all(5.0), // 每个间距  
          children: navigatorList.map((item){
            return _gridViewWidget(context, item);
          }).toList(), // 注意toList
        ),
    );
  }

  Widget _gridViewWidget(BuildContext context, item){
    return InkWell(
      onTap:(){
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95), fit: BoxFit.fill),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
}

// 广告
class AdBanner extends StatelessWidget {

  final String adPicture;
  AdBanner({Key key, this.adPicture}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Image.network(adPicture, fit: BoxFit.fill,),
    );
  }
}

// 店长电话模块
class LeaderPhone extends StatelessWidget {

  final String image;
  final String phone;

  LeaderPhone({Key key, this.image, this.phone}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container (
      child: InkWell(
        onTap:(){
          print('点击电话');
          _laucherUrl();
        },
        child: Image.network(image, fit: BoxFit.fill),
      ),
    );
  }

  void _laucherUrl () async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)){
      await launch(url);
    }else{
      throw 'url 不能进行访问, 异常';
    }
  }
}

// 商品推荐
class Recommand extends StatelessWidget {
  
  final List recommandList;
  Recommand({Key key, this.recommandList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(390),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(), // 标题组件
          _recommandList() // 推荐组件
        ],
      ),
    );
  }

  // 标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      // 盒子
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.black12)
          )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  // 商品单独项
  Widget _item(index){
    return InkWell(
      onTap: (){
        print('点击事件');
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        // 整个Contain的边框
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommandList[index]['image']),
            Text('${recommandList[index]['mallPrice']}'),
            Text(
              '${recommandList[index]['price']}',
              style: TextStyle( // 线
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 横向列表
  Widget _recommandList(){
    return Container(
      height: ScreenUtil().setHeight(333),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 横向
        itemCount: recommandList.length,
        itemBuilder: (context, index){
          return _item(index);
        },
      ),
    );
  }

}