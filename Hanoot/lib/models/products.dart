

import 'package:quiver/strings.dart';

class Product {
  int id ;
  String sku ;
  String name;
  String description ;
  String permalink ;
  String price ;
  String regularPrice ;
  String salePrice ;
  bool onSale ;
  bool inStock ;
  double averageRating ;
  int ratingCount ;
  List<String> images ;
  String imageFeature ;
  List<ProductAttribute> attribute;
  List<ProductAttribute> infors = [];
  int categoryId ;
  String videoUrl ;
  String status ;
  List<int> groupedProducts ;
  List<String> files ;
  int stockQuantity ;
  String type ;
  String shippingClass ;
  String affiliateUrl;
  Map<String,dynamic> multiCurrencies ;
  String storeId ;
  Product();
  Product.empty(int id){
    this.id = id ;
    name ="جاري الانتظار ...";
    price="0.0";
    imageFeature = "";
  }
  bool isEmptyProduct(){
    return name == "جاري الانتظار ..."&&price=="0.0"&&imageFeature=="";
  }
  Product.fromjson(Map<String,dynamic> jsondata){
    try{
      id = jsondata["id"];
      name = jsondata["name"];
      type = jsondata["type"];
      description = isNotBlank(jsondata["description"])? jsondata["description"] : jsondata["short_description"];
      permalink = jsondata["permalink"];
      price = jsondata["price"]!=null?jsondata["price"].toString():"0.0";
      regularPrice = jsondata["regular_price"]!=null?jsondata["regular_price"].toString():null;
      salePrice = jsondata["sale_price"]!=null?jsondata["sale_price"].toString():null;
      onSale = jsondata["on_sale"];
      shippingClass = jsondata["shipping_class"];
      inStock = jsondata["in_stock"]??jsondata["stock_status"]=="instock";
      averageRating = double.parse(jsondata["average_rating"]);
      ratingCount=int.parse(jsondata["rating_count"].toString());
      categoryId = jsondata["categories"]!=null ?
          jsondata["categories"][0]["id"]:0;
      status = jsondata["status"];

      //add stock limit
      if(jsondata["manage_stock"]==true){
        stockQuantity = jsondata["stock_quantity"];

      }
      List<ProductAttribute> attributeList=[];
        if(jsondata["attributes"].isNotEmpty){
          jsondata["attributes"].forEach((item){

            if(item["visible"]&&item["variation"]) attributeList.add(ProductAttribute.fromjson(item));

          });

          attribute =attributeList ;
          jsondata["attributes"].forEach((item){

            infors.add(ProductAttribute.fromjson(item));
          });
        }

      List<String> list = [];

      for(var item in jsondata["images"]){
        list.add(item["src"]);
      }
      images = list ;
      imageFeature = images[0].toString();
      //get video link
      var video = jsondata["meta_data"].firstWhere((item)=>item['key']=="video_url"||item["key"]=="_woofv_video_embed",orElse:()=>null);
      if(video!=null){
        videoUrl = video["value"]is String?video["value"]:video["value"]["url"]??"";

      }
      affiliateUrl = jsondata["external_url"];
      multiCurrencies = jsondata["multi-currency-prices"];


    }catch(e){

    }
  }
  Product.fromLocalJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      sku = json['sku'];
      name = json['name'];
      description = json['description'];
      permalink = json['permalink'];
      price = json['price']!=null?json['price']:"0.0";
      regularPrice = json['regularPrice'];
      salePrice = json['salePrice'];
      onSale = json['onSale'];
      shippingClass = json["shippingClass"];

      inStock = json['inStock'];
      averageRating = json['averageRating'];
      ratingCount = json['ratingCount'];
      List<String> imgs = [];
      for (var item in json['images']) {
        imgs.add(item);
      }
      images = imgs;
      imageFeature = json['imageFeature'];
      List<ProductAttribute> attrs = [];
      for (var item in json['attributes']) {
        attrs.add(ProductAttribute.fromlocaljson(item));
      }
      attribute = attrs;
      categoryId = json['categoryId'];
      multiCurrencies = json['multiCurrencies'];
    } catch (e) {
    }
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sku": sku,
      "name": name,
      "description": description,
      "permalink": permalink,
      "price": price,
      "regularPrice": regularPrice,
      "salePrice": salePrice,
      "onSale": onSale,
      "inStock": inStock,
      "averageRating": averageRating,
      "ratingCount": ratingCount,
      "images": images,
    "shippingClass" :shippingClass,
    "imageFeature": imageFeature,
      "attributes": attribute,
      "categoryId": categoryId,
      "multiCurrencies": multiCurrencies
    };
  }
}
 class ProductAttribute {
  int id ;
  String name ;
  List options;
  ProductAttribute.fromjson(Map<String, dynamic> jsondata){
    id = jsondata['id'];
    name = jsondata['name'];
    options = jsondata['options'];
  }
  Map <String, dynamic> toJson(){
    return {"id": id,"name":name,"options":options};
  }
  @override
  String toString() {
    return 'id: $id name: $name options: $options';
  }
  ProductAttribute.fromlocaljson(Map<String, dynamic> jsondata){
  try {
    id = jsondata['id'];
    name = jsondata['name'];
    options = jsondata['options'];
  }catch(e){
  }
  }

 }

 class Attribute{
  int id ;
  String name ;
  String option ;
  Attribute();
  Attribute.fromjson(Map<String,dynamic> jsondata){
    id=jsondata['id'];
    name=jsondata['name'];
    option=jsondata['option'];

  }
  Map<String,dynamic> toJson(){
    return{'id':id,'name':name,'option':option};
 }
 @override
  String toString() {
    // TODO: implement toString
    return 'id: $id name: $name option: $option';
  }

 }
 class ProductVariation{
  int id;
  String price;
  String regularPrice;
  String salePrice;
  bool onSale ;
  bool inStock ;
  String imageFeature;
  List<Attribute> attribute=[];
  ProductVariation();
  Map<String, dynamic> toJson(){
    return{
     "id":id,
     "price":price,
     "regularPrice":regularPrice,
     "salePrice":salePrice,
     "onSale":onSale,
     "inStock":inStock,
     "imageFeature":imageFeature,
     "attributes":attribute
    };
  }
  ProductVariation.fromLocalJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      price = json['price']!=null?json['price']:"0.0";
      regularPrice = json['regularPrice'];
      salePrice = json['salePrice'];
      onSale = json['onSale'];
      inStock = json['inStock'];
      imageFeature = json['imageFeature'];
      imageFeature = json['imageFeature'];
      List<Attribute> attributeList = [];
      json["attributes"].forEach((item){
        attributeList.add(Attribute.fromjson(item));
      });
      attribute=attributeList;

    } catch (e) {
    }
  }
  ProductVariation.fromjson(Map<String,dynamic> jsondata){
    id = jsondata['id'];
    price = jsondata['price'];
    regularPrice = jsondata['regular_price'];
    salePrice = jsondata['sale_price'];
    onSale = jsondata['on_sale'];
    inStock = jsondata['in_stock'];
    imageFeature = jsondata['imageFeature'];
    List<Attribute> attributeList = [];
    jsondata["attributes"].forEach((item){
      attributeList.add(Attribute.fromjson(item));
    });
    attribute=attributeList;
  }

  @override
  String toString() {
    // TODO: implement toString
    String value ='';
    attribute.forEach((attribute){
      value+='${attribute.name}: ${attribute.option}, ';
    });
    value = value.substring(0,value.length-3);
    return value ;
  }
 }
 class Review {
  int id , ProductId;
  String reviewer,reviewerEmail,review;
  int rating;
  Review({ this.id,
    this.ProductId,
    this.rating,
    this.review,
    this.reviewer,
    this.reviewerEmail});
  Map<String,dynamic> toJson(){
    return{
      "product_id":ProductId,
      "reviewer":reviewer,
      "reviewer_email":reviewerEmail,
      "review":review,
      "rating":rating
    };
  }
  Review.fromjson(Map<String,dynamic> jsondata){
    id=jsondata['id'];
    ProductId=jsondata['product_id'];
    reviewerEmail=jsondata['reviewer_email'];
    review=jsondata['review'];
    rating=jsondata['rating'];
    reviewer = jsondata["name"];
  }
 }