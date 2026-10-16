//基于Dio第二次封装

import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class Diorequest {
  final _dio = Dio();//dio请求对象
  //基础地址拦截器
  Diorequest(){
    _dio.options..baseUrl=GlobalConstants.BASE_URL
    ..connectTimeout=Duration(seconds: GlobalConstants.TIME_OUT)
    ..sendTimeout=Duration(seconds: GlobalConstants.TIME_OUT)
    ..receiveTimeout=Duration(seconds: GlobalConstants.TIME_OUT);
    //拦截器
    _addInterceptor();
  }
  void _addInterceptor(){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request,handler){
        handler.next(request);
      },
      onResponse: (response,handler){
        //http状态码 200 300
        if(response.statusCode!>=200&& response.statusCode!<300){
          handler.next(response);
          return;
        }
        handler.reject(DioException(requestOptions: response.requestOptions));//超过状态码，拦截处理
      },
      onError: (error,handler){
        //handler.reject(error);
        handler.reject(
          DioException(
            requestOptions: error.requestOptions,message: 
            error.response?.data["msg"]??"",//可选与空判断
        ),);
      },
    ));
  }
  Future<dynamic> get(String url,{Map<String ,dynamic>? params}){
    return _handleResponse(_dio.get(url,queryParameters: params));
  }
  //定义post接口
  Future<dynamic>post(String url,{Map<String,dynamic>?data}){//可选命名参数
    return _handleResponse(_dio.post(url,data: data));
  }

  //进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>>task)async{
    try{
        Response<dynamic>res= await task;
    final data= res.data as Map<String,dynamic>;//data才是我们真正返回的数据
    if(data["code"]== GlobalConstants.SUCCESS_CODE){
      //才认定http状态与业务状态均正常，就可以正常放行通过
      return data["result"];//只要result结果

    }
    //抛出异常
    //throw Exception(data["msg"] ?? "加载数据异常");//空判断为空则输出后面内容
    throw DioException(requestOptions: res.requestOptions,
    message: data["msg"]??"加载数据失败");
    }
    catch(e){
      //throw Exception(e);
      rethrow;//不改变原来抛出的异常类型
    }
  
  }
}

//单例对象
final dioRequest=Diorequest();//单例对象

//dio请求工具发出请求，返回的数据Response<dynamic>.data
//把所有的接口的data数据解放出来，拿到真正的数据，要判断业务状态码是不是等于1


