import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/compontents/Home/HmCategory.dart';
import 'package:hm_shop/compontents/Home/HmHot.dart';
import 'package:hm_shop/compontents/Home/HmMoreList.dart';
import 'package:hm_shop/compontents/Home/HmSlider.dart';
import 'package:hm_shop/compontents/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //分类列表
  List<CategoryItem>_categoryList=[];

    List<BannerItem>_bannerList=[
    //  BannerItem(
    //   id: "1",
    //  imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/banner/nuandong_sj.png",
    //  ),
    //   BannerItem(
    //   id: "2",
    //  imgUrl:  "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/banner/nvshen_sj.png",
    //  ),
    //   BannerItem(
    //   id: "3",
    //  imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/banner/xinnian_sj.png",
    //  )
  ];
  //获取滚动容器的内容  
  List<Widget> _getScrollChildern(){
    return[
      //包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList,),),//轮播图组件,

      //放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList,),),//分类组件
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
  void initState() { 
    super.initState();
    _getBannderList();
    _getCategoryList();
  }
  //获取分类列表
  void _getCategoryList()async{
    _categoryList =await getCategoryListAPI();
    setState(() {});
  }
  //获取轮播图列表
  void _getBannderList()async{
    _bannerList =await getBannerListAPI();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern(),);//sliver家族的内容
  }
}