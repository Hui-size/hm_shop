class BannerItem{
  String? id;
  String imgUrl;
  BannerItem({required this.id,required this.imgUrl});//可选命名参数值{}，然后require必传
  //扩展一个工厂函数，一般用factory来声明，一般用来创建实例对象
  factory BannerItem.formJSON(Map<String,dynamic>json){
    //必须返回一个BnnerItem对象
    return BannerItem(
      id: json["id"] ?? "",
      imgUrl: json["imgUrl"]??""
    );
  }
}

//每一个轮播图的具体类型