import 'package:flutter/material.dart';

class Loadingdialog {
  static void show(BuildContext context,{String message="加载中. . ."}){
    showDialog(context: context, builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),//转圈组件
                SizedBox(height: 10,),
                Text(message),
              ],
            ),
          ),
        ),
      );
    });
  }
  static void hide(BuildContext context){
    Navigator.pop(context);
  }
}