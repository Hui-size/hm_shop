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
      SliverToBoxAdapter(child: Hmsuggestion(specialRecommendResult: _specialRecommendResult,),),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      //SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: 
      Padding(padding: EdgeInsets.symmetric(horizontal: 10),
      child:Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),


        ],
        ) ,
      ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      HmMoreList(recommendList: _recommendList), //无限滚动列表
    ];
  }
  @override
  void initState() { 
    super.initState();
    _getBannderList();
    _getCategoryList();
    _getProductList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
    _registerEvent();
  }
  //获取特惠推荐
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "1",
    title: "特惠推荐",
    subTypes: [],
  );

// 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

// 推荐列表
  List<GoodDetailItem> _recommendList = [];

  //页码
  int _page = 1;
  bool _isLoading = false;//当前正在加载状态
  bool _hasMore = true;// 是否还有下一页
  //监听滚动到底部的事件
  void _registerEvent(){
    _controller.addListener((){
      if(_controller.position.pixels==
      (_controller.position.maxScrollExtent)){//最大距离
        //print("到底了");
        _getRecommendList();
      }
    });
  }

  // 获取推荐列表
  void _getRecommendList() async {
    //当已经有请求正在加载 或者已经没有下一页了 就放弃请求
    if(_isLoading || !_hasMore){
      return;
    }
    _isLoading=true;//站住位置
    int requestLimit = _page*10;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading=false;//松开位置
    setState(() {});
    if(_recommendList.length<requestLimit){
      _hasMore=false;
      return;
    }    
    _page++;//_page +=1;

  }


// 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }




  void _getProductList() async {
    final result = await getProductListAPI();
    if (!mounted) return;

    setState(() {
      _specialRecommendResult = result;
    });
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
  final ScrollController _controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,//绑定控制器
      slivers: _getScrollChildern(),);//sliver家族的内容
  }
}
