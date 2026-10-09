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
// {
//             "id": "1181622001",
//             "name": "气质女装",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png",
//             "children": [
//                 {
//                     "id": "1191110001",
//                     "name": "半裙",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bq.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110002",
//                     "name": "衬衫",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_cs.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110022",
//                     "name": "T恤",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_tx.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110023",
//                     "name": "针织衫",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_zzs.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110024",
//                     "name": "夹克",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_jk.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110025",
//                     "name": "卫衣",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_wy.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110028",
//                     "name": "背心",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bx.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 }
//             ],
//             "goods": null
//         }

//根据json编写class对象和工厂转化函数
class CategoryItem{
  String? id;
  String name;
  String picture;
  List<CategoryItem>? children;
  List<CategoryItem>? goods;
  CategoryItem({required this.id,required this.name,required this.picture,this.children,this.goods});
  //扩展一个工厂函数，一般用factory来声明，一般用来创建实例对象
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
  return CategoryItem(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    picture: json["picture"] ?? "",
    children: (json["children"] as List?)
        ?.map((item) =>
            CategoryItem.formJSON(item as Map<String, dynamic>))
        .toList() ?? <CategoryItem>[],
  );
}
}

/// 特惠推荐接口的完整响应
/// 特惠推荐内容，对应接口返回的 result。
class SpecialRecommendResult {
  String id;
  String title;
  List<SpecialRecommendSubType> subTypes;

  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommendResult.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: (json['subTypes'] as List?)
              ?.map((item) => SpecialRecommendSubType.fromJson(
                    item as Map<String, dynamic>,
                  ))
              .toList() ??
          <SpecialRecommendSubType>[],
    );
  }

  factory SpecialRecommendResult.formJSON(Map<String, dynamic> json) =>
      SpecialRecommendResult.fromJson(json);
}

/// 推荐子分类，例如抢先尝鲜、新品预告。
class SpecialRecommendSubType {
  String id;
  String title;
  SpecialRecommendGoodsItems goodsItems;

  SpecialRecommendSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory SpecialRecommendSubType.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendSubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: SpecialRecommendGoodsItems.fromJson(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }

  factory SpecialRecommendSubType.formJSON(Map<String, dynamic> json) =>
      SpecialRecommendSubType.fromJson(json);
}

/// 子分类的商品分页数据。
class SpecialRecommendGoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<SpecialRecommendGoodsItem> items;

  SpecialRecommendGoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory SpecialRecommendGoodsItems.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendGoodsItems(
      counts: (json['counts'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      pages: (json['pages'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 0,
      items: (json['items'] as List?)
              ?.map((item) => SpecialRecommendGoodsItem.fromJson(
                    item as Map<String, dynamic>,
                  ))
              .toList() ??
          <SpecialRecommendGoodsItem>[],
    );
  }

  factory SpecialRecommendGoodsItems.formJSON(Map<String, dynamic> json) =>
      SpecialRecommendGoodsItems.fromJson(json);
}

/// 特惠推荐商品；价格按接口保留字符串，描述允许为 null。
class SpecialRecommendGoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  SpecialRecommendGoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory SpecialRecommendGoodsItem.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendGoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'] as String?,
      price: json['price'] ?? '',
      picture: json['picture'] ?? '',
      orderNum: (json['orderNum'] as num?)?.toInt() ?? 0,
    );
  }

  factory SpecialRecommendGoodsItem.formJSON(Map<String, dynamic> json) =>
      SpecialRecommendGoodsItem.fromJson(json);
}

class GoodDetailItem extends SpecialRecommendGoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
