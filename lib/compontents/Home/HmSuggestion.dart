import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmsuggestion extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;
  Hmsuggestion({Key? key, required this.specialRecommendResult}) : super(key: key);
  
  @override
  _HmsuggestionState createState() => _HmsuggestionState();
}

class _HmsuggestionState extends State<Hmsuggestion> {
//取前3条数据
  List<SpecialRecommendGoodsItem> _getDisplayItems() {
    final subTypes = widget.specialRecommendResult.subTypes;
    if (subTypes.isEmpty) {
      return <SpecialRecommendGoodsItem>[];
    }
    return subTypes.first.goodsItems.items.take(3).toList();
  }

 Widget _buildHeader(){
  return Row(
    children: [
      Text("特惠推荐",style: TextStyle(color:const Color.fromARGB(255,86,24,20),
      fontSize: 18,
      fontWeight: FontWeight.w700,
      ),),
      SizedBox(width: 10),
      Text("精选生攻略",style: TextStyle(
        fontSize: 12,
        color: const Color.fromARGB(255, 86, 24, 20),
      ),)
    ],
  );
 }


 //左侧结构
 Widget _buildLeft(){
  return Container(
    width: 100,
    height: 140,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage("lib/assets/home_cmd_inner.png"),
        fit: BoxFit.cover,
      ),      
    ),
  );
 }

List<Widget>_getChildrenList(){
  List<SpecialRecommendGoodsItem>list=_getDisplayItems();//取到前3条数据
  return  List.generate(list.length, (int index){
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(8),
          child:Image.network(
          errorBuilder:(context, error, stackTrace) {
            //返回一个新的部件代替原有图片,图片出现异常的时候
            return Image.asset(
              "lib/assets/home_cmd_inner.png",
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            );
          },
          list[index].picture,width: 100,height: 140,
          fit: BoxFit.cover,) ,
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),          
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 35, 21),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("￥${list[index].price}",style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ],
    );
  });
}

 //完成渲染
 @override
  Widget build(BuildContext context) {
    return 
    Padding(padding: EdgeInsets.symmetric(horizontal: 10),
    child: Container(
       height: 300,      
       padding: EdgeInsets.all(12), 
       alignment: Alignment.center,
       decoration: BoxDecoration(color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: AssetImage("lib/assets/home_cmd_sm.png"),
          fit:BoxFit.cover
         ),//本地资源图片
       ),
       child:Column(
        children: [
          //顶部内容
          _buildHeader(),
          SizedBox(height: 10,),
          Row(
            children: [
              _buildLeft(),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _getChildrenList(),
              ))
            ],
          )
        ],
       ),
    ),);
    
  }
}
