import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem>bannerList;
  HmSlider({Key? key,required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _controller=CarouselSliderController();//控制轮播图跳转的控制器
  int _currentIndex=0;
  Widget _getSlider(){
    //返回轮播图插件
    //根据数据渲染的不同的轮播选择
    //在flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;//获取的屏幕宽度
    return CarouselSlider(
      carouselController: _controller,//绑定controller对象
      items:List.generate(widget.bannerList.length, (int index){
      return Image.network(widget.bannerList[index].imgUrl,
      fit: BoxFit.cover,
      width: screenWidth,
      );
    }), options:CarouselOptions(
      viewportFraction: 1,//占比为多少
      autoPlay: true,
      onPageChanged: (int index,reason){
        _currentIndex=index;
        setState(() {
          
        });
      }
      //autoPlayInterval:Duration(seconds: 2),
    ));
  }
  Widget _getSearch() {
  return Positioned(
    top: 10,
    left: 0,
    right: 0,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.circular(25),
        ), // BoxDecoration
        child: Text(
          "搜索...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ), // Text
      ), // Container
    ), // Padding
  ); // Positioned
}
//返回指示灯
  Widget _getDots(){
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:List.generate(widget.bannerList.length, (int index){
            return 
            GestureDetector(
              onTap: (){
                _controller.jumpToPage(index);
              },
              child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 6,
              width:index == _currentIndex? 40:20,
              decoration: BoxDecoration(
                color:index ==_currentIndex 
                ? Colors.white
                :Color.fromRGBO(0, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),);            
          }),
        ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    //Stack ->轮播图 搜索框 指示灯导航;
    return Stack(
      children: [_getSlider(),_getSearch(),_getDots()],
    );
    // return Container(
    //   color: Colors.blue,
    //   height: 300,
    //   alignment: Alignment.center,
    //    child: Text("轮播图",style: TextStyle(color: Colors.white,fontSize: 20),)
    // );
  }
}