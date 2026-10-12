

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';
//猜你喜欢参数
//page:1 pageSize:10
Future<GoodDetailsItems>getGuessListAPI(Map<String,dynamic>params)async{
  return GoodDetailsItems.fromJson( await dioRequest.get(HttpConstants.GUESS_LIST,params: params));
}