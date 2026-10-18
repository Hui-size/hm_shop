
import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tokenmanager {
  //返回持久化对象的实例
  Future<SharedPreferences> _getInstance(){
    return SharedPreferences.getInstance();
  }

  String _token='';
  //初始化Token
  init()async{
    final prefs=await _getInstance();
    _token= prefs.getString(GlobalConstants.TOKEN_KEY)?? "";
  }
  //设置token
  Future<void> setToken(String val)async{
    //获取持久化实例
    final prefs=await _getInstance();
    //将 Token 保存到本地
    prefs.setString(GlobalConstants.TOKEN_KEY,val);//存储的键与值,token写到持久化磁盘
    _token=val;
  }
  //获取Token,同步方法
  String getToken(){
    return _token;
  }
  //删除Token
  Future<void> removeToken()async{
    final prefs=await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);//磁盘
    _token="";//内存
  }
}
final tokenManager=Tokenmanager();//创建一个类对象方便后续调用方法  