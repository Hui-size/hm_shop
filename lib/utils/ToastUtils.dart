
import 'package:flutter/material.dart';

class Toastutils {
  //阀门控制
  static bool showLoading =false;
  static void showToast(BuildContext context ,String ?msg){
    if(Toastutils.showLoading){
      return;
    }
    Toastutils.showLoading=true;
    Future.delayed(Duration(seconds: 3),(){
      Toastutils.showLoading=false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(//提示信息
    width: 180,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(40)
    ),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 3),
    content: Text(msg??"加载成功",textAlign: TextAlign.center,)));
  }
}