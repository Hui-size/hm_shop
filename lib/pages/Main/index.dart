import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final UserController _userController=Get.put(UserController());

  //定义数据，根据数据渲染4个导航
  //一般应用程序的导航是固定的
  final List<Map<String,String>>_tablist=[
    {
    "icon":"lib/assets/ic_public_home_normal.png",//正常显示的图标
    "active_icon":"lib/assets/ic_public_home_active.png",//激活显示的图标
    "text": "首页",
    },
    {
    "icon":"lib/assets/ic_public_pro_normal.png",//正常显示的图标
    "active_icon":"lib/assets/ic_public_pro_active.png",//激活显示的图标
    "text": "分类",
    },
    { 
    "icon":"lib/assets/ic_public_cart_normal.png",//正常显示的图标
    "active_icon":"lib/assets/ic_public_cart_active.png",//激活显示的图标
    "text": "购物车",
    },
   {
    "icon":"lib/assets/ic_public_my_normal.png",//正常显示的图标
    "active_icon":"lib/assets/ic_public_my_active.png",//激活显示的图标
    "text": "我的",
   }
  ];
  int _currntIndex=0;
  //返回底部渲染的四个分类
  List<BottomNavigationBarItem>_getTabBarWidget (){
    return List.generate(_tablist.length, (int index){//！为非空断言，还有Image.asset使用本地文件
      return BottomNavigationBarItem(
        icon: Image.asset(_tablist[index]["icon"]!,width: 30,height: 30,),//正常显示图标
        //激活图标
        activeIcon: Image.asset(
          _tablist[index]["active_icon"]!,
          width: 30,
          height: 30,),
          label: _tablist[index]["text"],
        );
    });
  }

  List<Widget>_getChildren(){
    return[
      HomeView(),CategoryView(),CartView(),MineView(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //避开安全区组件
       body:SafeArea(child: 
       IndexedStack(//堆叠组件
       index:_currntIndex,
        children: _getChildren(),//放置组件
       )
       ),
       bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,//展示没有选中的文本
        selectedItemColor: Colors.black,//颜色选中
        unselectedItemColor: Colors.black,
        onTap: (int index){          //点击
          //index就是当前索引
          _currntIndex=index;//绑定索引
          setState(() {});
        },
        currentIndex: _currntIndex,       
        items: _getTabBarWidget()
        ),
    );
  }
}