import 'package:flutter/material.dart';
import 'package:hm_shop/compontents/Home/HmCategory.dart';
import 'package:hm_shop/compontents/Home/HmHot.dart';
import 'package:hm_shop/compontents/Home/HmMoreList.dart';
import 'package:hm_shop/compontents/Home/HmSlider.dart';
import 'package:hm_shop/compontents/Home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //获取滚动容器的内容  
  List<Widget> _getScrollChildern(){
    return[
      //包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(),),//轮播图组件,
      //放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      SliverToBoxAdapter(child: HmCategory(),),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      SliverToBoxAdapter(child: Hmsuggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      //SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: 
      Padding(padding: EdgeInsets.symmetric(horizontal: 10),
      child:Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(child: Hmhot(),),
          SizedBox(width: 10,),
          Expanded(child: Hmhot(),),
        ],
        ) ,
      ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      Hmmorelist(),//无限滚动列表
    ];
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern(),);//sliver家族的内容
  }
}