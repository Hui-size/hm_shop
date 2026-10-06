import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  HmCategory({Key? key, required this.categoryList}) : super(key: key);
  //分类列表
  

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,//横向排列
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context,int index){
          final category = widget.categoryList[index];
        return Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 231, 232, 234),
            borderRadius: BorderRadius.circular(40),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(category.picture,
                width: 40,
                height: 40,
              ),
              Text(category.name,style: TextStyle(color:Colors.black),),
            ],
          ),
          
        );
      }),
    );
  }
}