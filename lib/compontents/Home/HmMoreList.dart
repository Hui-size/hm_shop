import 'package:flutter/material.dart';

class Hmmorelist extends StatefulWidget {
  Hmmorelist({Key? key}) : super(key: key);

  @override
  _HmmorelistState createState() => _HmmorelistState();
}

class _HmmorelistState extends State<Hmmorelist> {
  @override
  Widget build(BuildContext context) {
    //必须是Sliver家族的组件
    //网格是两列
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,//上下间隔
        crossAxisSpacing: 10,//左右间隔 10
        ), 
      itemBuilder: (BuildContext context,int index){
          return Container(
            child: Text("商品",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            alignment: Alignment.center,
            );            
    });
  }
}