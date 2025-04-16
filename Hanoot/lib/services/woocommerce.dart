import 'dart:convert' as convert;
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/models/order.dart';
import 'package:Hanoot/models/payment.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/models/shipping_method.dart';
import 'package:Hanoot/models/address.dart';
import 'package:Hanoot/models/user.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/services/woocommerce_api.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:quiver/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Woocommerce implements BaseServices {
  WooCommerceAPI wcApi ;
  bool isSecure ;
  String url ;
  String userId ;
  List<Categories> categories =[];
  Map<String,List<Product>> categoryCache = Map<String,List<Product>>();
  Woocommerce.fromConfig(){
    wcApi = WooCommerceAPI(
      url: Constants.URL_CLOUD,
      consumerKey: Constants.CONSUMER_KEY_CLOUD,
      consumerSecret: Constants.CONSUMER_SECRET_CLOUD,  );
    isSecure = true ;
  }
  void appConfig(appconfig){
    url = appconfig["url"];
  }


  @override
  Future creatReview({int productId, Map<String, dynamic> data})async {
    try{
//       = await wcApi.postAsync("products/reviews", data ,);
      var response =    await wcApi.postAsync("products/$productId/reviews", data, version: 2);

      if(response["message"]!=null){
        throw Exception(response["message"]);
      }else{
        return true ;
      }
    }catch(e){

    }
  }

  @override
  Future createOrder(Map<String, int> productsInCart,
      Map<String, ProductVariation> productVariationsInCart,
      Address address, PaymentMethod paymentMethod, userid)async {
    // TODO: implement createOrder
    try{
      var params =Order().toJson(productsInCart, productVariationsInCart, address, paymentMethod);
      var response = await wcApi.postAsync("orders", params);
    }catch(e){

    }
  }
  /////// about user login and create new user
  @override
  Future <User> createUser({firstName, lastName, username, password,isVendor = false}) async{
    try {

      String niceName = firstName + " " + lastName;
      final http.Response response = await http.post("https://hanoot.ly/wp-json/api/flutter_user/register/?insecure=cool&",
          body: convert.jsonEncode({
            "user_email": username,
            "user_login": username,
            "username": username,
            "first_name": firstName,
            "last_name": lastName,
            "user_pass": password,
            "email": username,
            "user_nicename": niceName,
            "display_name": niceName,
            "role": isVendor ? "seller" : "subscriber"
          }));
      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200 && body["message"] == null) {
        var cookie = body['cookie'];
        return await this.getUserInfo(cookie);
      } else {
        var message = body["message"];
        throw Exception(message != null ? message : "Can not create the user.");
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future <User> login({username, password}) async{
    var cookieLifeTime = 120960000000;

    try {
      final http.Response response = await http.post(
          "https://hanoot.ly/wp-json/api/flutter_user/generate_auth_cookie/?insecure=cool&$isSecure",
          body: convert.jsonEncode({"seconds": cookieLifeTime.toString(), "username": username, "password": password}));
      final body = convert.jsonDecode(response.body);

      if (response.statusCode == 200 && isNotBlank(body['cookie'])) {
        return await this.getUserInfo(body['cookie'], password: password);
      } else {
        throw Exception("The username or password is incorrect.");
      }
    } catch (err) {
      rethrow;
    }
  }
  @override
  Future getUserInfo(cookie,{password}) async{
    try {

      final http.Response response =
      await http.get("https://hanoot.ly/wp-json/api/flutter_user/get_currentuserinfo?cookie=$cookie&$isSecure");
      final body = convert.jsonDecode(response.body);

      if (response.statusCode == 200 && body["user"] != null) {
        // edit to ahmed gibran
        String p =body["user"]['role'].toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('isvendor',p);
        //////////////////////////
        var user = body['user'];
        user['password'] = password;
        userId = user['id'].toString();
        return User.fromAuthUser(user, cookie);
      } else {
        throw Exception(body["message"]);
      }
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future loginSMS({String token}) async{
    // TODO: implement loginSMS
    try{
      var endpoint = "https://hanoot.ly/wp-json/api/flutter_user/firebase_sms_login?phone=$token";
     var response = await http.get(endpoint);
       var jsonDecode = convert.jsonDecode(response.body);
     return User.fromJsonSMS(jsonDecode);
    }catch(e){
      throw e ;
    }
  }

/////////////////end about for user
  @override
  Future<List<Product>> fetchProductsByCategory({categoryId, page, minPrice, maxPrice, orderBy, lang, order})async {

    // TODO: implement fetchProductsByCategory

    try{
      List<Product> list = [];
      var endPoint = "products?status=publish&in_stock=true&lang=$lang&per_page=10&page=$page";
      if(categoryId>-1){
        endPoint+="&category=$categoryId";
      }
      if(minPrice!=null){
        endPoint+="&min_price=${minPrice}";
      }
      if(maxPrice!=null){

        endPoint+="&max_price=${maxPrice}";
      }
      if(orderBy!=null){
        endPoint+="&orderby=$orderBy";
      }
      if(order!=null){
        endPoint+="&order=$order";
      }
      var response=await wcApi.getAsync(endPoint);
      for(var item in response){
        list.add(Product.fromjson(item));


      }
      return list;

    }catch(e){

      throw e ;
    }
  }
  Future<List<Categories>> getCategoriesByPage({ page}) async {
    try {
      String url = "products/categories?exclude=311&per_page=100&page=$page";
      var response = await wcApi.getAsync(url);
      if (page == 1) {
        categories = [];
      }
      if (response is Map && isNotBlank(response["message"])) {
        throw Exception(response["message"]);
      } else {
        for (var item in response) {
          if (item['slug'] != "uncategorized" && item['count'] > 0) {
            final cate =Categories.fromjson(item);
            if (cate.id != null) {
              categories.add(cate);
            }
          }
        }
        if (response.length == 100) {
          return getCategoriesByPage( page: page + 1);
        } else {
          return categories;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<List<Categories>> getCategories({page})async {
    try{
      page=1;
      var response =
          await wcApi.getAsync("products/categories?&exclude=311&per_page=100");
      List<Categories> list = [];
      for(var item in response){
        list.add(Categories.fromjson(item));
      }



/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
     // await getCategoryWithCache(CAtegories: list);
      List<Categories> getCategoriesByPageList = [];

      if (response.length == 100) {
        getCategoriesByPageList = [...getCategoriesByPageList,...await getCategoriesByPage(page: page + 1)];

       return list = [...list,...getCategoriesByPageList];
      } else {
        return list ;
      }

    }catch(e){

      throw e ;
    }
  }

  @override
  Future getCoupons() async{
    // TODO: implement getCoupons
    try{
        var response = await wcApi.getAsync("coupons");
        return null ;
    }catch(e){
      throw e ;
    }  }

  @override
  Future<List> getPaymentMethods({address, shippingMethod, String token}) async{
    // TODO: implement getPaymentMethods
    try{
       var response = await wcApi.getAsync("payment_gateways");
       List<dynamic> list = [] ;
      for(var item in response){
       if(item["enabled"])
        list.add(PaymentMethod.fromjson(item));

      }
      return list;
    }catch(e){
      throw e ;
    }
  }

  @override
  Future getProduct(id) async{
    // TODO: implement getProduct
    try{
      var response = await wcApi.getAsync("products/$id");
      return Product.fromjson(response);
    }catch(e){
      throw e ;
    }
  }

  @override
  Future<List<ProductVariation>> getProductVariations(product) async{
    // TODO: implement getProductVariations
    try{
var response = await wcApi.getAsync("products/${product.id}/variations?per_page=20");

List<ProductVariation> list = [];
for(var item  in response){

  list.add(ProductVariation.fromjson(item));
}

return list ;
    }catch(e){
      throw e ;
    }
  }

  @override
  Future<List<Product>> getProducts({page}) async{
try{
  var response = await wcApi.getAsync("products?status=publish&in_stock=true&lang=en&per_page=10&page=$page");
  List<Product> list = [];
  if(response is Map && isNotBlank(response["message"])){
    throw Exception(response["message"]);
  }else{
    for(var item in response){
      list.add(Product.fromjson(item));

    }

    return list ;
  }
}catch(e){

}

/*try{
  var response = await wcApi.getAsync("products");
  List<Product> list = [];
  for(var item in response){
    list.add(Product.fromjson(item));

  }
  return list ;
}catch(e){
  throw e ;
}*/
  }

  @override
  Future<List<Review>> getReview(productId) async{
    // TODO: implement getReview
    try{

    var response = await wcApi.getAsync("products/$productId/reviews");
    List<Review> list = [];
    if (response is Map && isNotBlank(response["message"])) {
      throw Exception(response["message"]);
    } else {
      for (var item in response) {
        list.add(Review.fromjson(item));
      }
      return list;
    }
//    return list ;
    }catch(e){
      throw e ;
    }
  }




  @override
  Future loginFacebook({String token}) async{
    // TODO: implement loginFacebook
    try{
      return null ;

    }catch(e){
      throw e ;
    }
  }



  @override
  Future<List<Product>> searchProducts({name, page}) async{
    // TODO: implement searchProducts
    try{
var response = await wcApi.getAsync("products?search=$name&page=$page&per_page=5");
List<Product> list = [] ;
for(var item in response){
  list.add(Product.fromjson(item));
  
}
return list ;
    }catch(e){


      throw e ;
    }
  }

  @override
  Future updateOrder(orderId, {status} ) async{
    // TODO: implement updateOrder
    try{
var response = await wcApi.putAsync("orders/$orderId", {"status": status});
if(response["message"]!=null){
  throw Exception(response["message"]);
}else{
  return Order.fromJson(response) ;
 // return Order.fromjson(response);
}
  }catch(e){
  throw e ;
  }
  }



  @override
  Future getCategoryWithCache({List<Categories> CAtegories}) async{

    try {
      if (CAtegories.length > 0) {
        List<Categories> getSubCategories(id) {
          return CAtegories.where((o) => o.parent == id).toList();
        }

        bool hasChildren(id) {
          return CAtegories
              .where((o) => o.parent == id)
              .toList()
              .length > 0;
        }

        List<Categories> getParentCategory() {
          return CAtegories.where((item) => item.parent == 0).toList();
        }

        List<int> categoryIds = [];
        List<Categories> parentCategories = getParentCategory();
        for (var item in parentCategories) {
          if (hasChildren(item.id)) {
            List<Categories> subCategories = getSubCategories(item.id);
            for (var item in subCategories) {

              categoryIds.add(item.id);
            }
          } else {

          }
        }

      } else {}
    }catch(e){

    }
  }

  Future <Map<String,dynamic>> getCategoryCache(categoriesId) async{
try{
  final data = await wcApi.getAsync("flutter/category/cache?categoryIds=${List<int>.from(categoriesId).join(",")}");
  if(data["message"]!=null){
    throw Exception(data["message"]);
  }else{
    for(var i = 0;i<3; i++){
      var productsjson = data["${categoriesId[i]}"] as List ;
      List<Product> list = [];
      if(productsjson !=null && productsjson.isNotEmpty){
        for(var item in productsjson){
          Product product = Product.fromjson(item);
          product.categoryId = categoriesId[i];
          list.add(product);
        }
      }
      categoryCache["${categoriesId[i]}"] = list ;
    }
  }
  return categoryCache ;
}catch(e){

  rethrow ;
}
  }




  @override
  Future<Order> CreateNewOrder({CartState cartState, UserState userState, bool poid}) async{
    try{


      final params = Order().toNewJson(cartState: cartState,userState: userState,paid: poid);

      var response = await wcApi.postAsync("orders", params);
      if (response["message"] != null) {
        throw Exception(response["message"]);
      } else {
      await CartState().saveOrder(response);
        return Order.fromJson(response);

      }
    }catch(e){

    }

  }

  @override
  Future<List> getShippingMethod({address, String token}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var  zip ="0";
      zip = await prefs.getString('zip');
      List<ShippingMethod> list = [];
      var response = await wcApi.getAsync("shipping/zones");
      if (response is Map && isNotBlank(response["message"])) {
        throw Exception(response["message"]);
      } else {
        //  for (var zone in response) {
        //  final id = zone["id"];
        var id ="2";
        if(zip=="61400"){
          id ="20";
        }else if(zip=="61600"){
          id ="4";

        }else if(zip=="61700"){
          id ="5";


        }else if(zip=="61401"){
          id ="6";

        }else if(zip=="61402"){
          id ="7";

        }else if(zip=="61403"){
          id ="8";

        }else if(zip=="61900"){
          id ="6";


        }else if(zip=="62000"){
          id ="14";

        }else if(zip=="620004"){
          id ="15";

        }else if(zip=="620005"){
          id ="16";

        }else if(zip=="6140010"){
          id ="17";

        }else if(zip=="6140020"){
          id ="18";

        }else if(zip=="6140022"){
          id ="19";

        }else if(zip=="62100"){
          id ="13";

        }else if(zip=="63300"){
          id ="9";

        }else if(zip=="6140040"){
          id ="9";

        }else if(zip=="61404"){
          id ="10";

        }else if(zip=="61405"){
          id ="11";

        }else if(zip=="61406"){
          id ="12";

        }else if(zip=="618002"){
          id ="11";

        }
        else if(zip=="61800"){
          id ="12";

        }
        else if(zip=="617009"){
          id ="13";

        }
        else if(zip=="617008"){
          id ="14";

        }
        else if(zip=="63600"){
          id ="15";

        }
        else if(zip=="63400"){
          id ="16";

        }
        else if(zip=="616009"){
          id ="17";

        }
        else if(zip=="615002"){
          id ="18";

        } else if(zip=="615003"){
          id ="19";

        }else if(zip=="20615003"){
          id ="21";

        }else if(zip=="10615003"){
          id ="20";

        }
        ////////////////////add new
        else if(zip=="30615003"){
          id ="22";

        }else if(zip=="6150010"){
          id ="23";

        }else if(zip=="6160010"){
          id ="24";

        }else if(zip=="6140030"){
          id ="25";

        }else if(zip=="617007"){
          id ="26";

        }else if(zip=="6140023"){
          id ="27";

        }else if(zip=="6140050"){
          id ="28";

        }else if(zip=="615009"){
          id ="29";

        }
        ////////////////////
        var response = await wcApi.getAsync("shipping/zones/$id/methods");
//       var response = await wcApi.getAsync("shipping/zones/2/methods");


        if (response is Map && isNotBlank(response["message"])) {
          throw Exception(response["message"]);
        } else {
          var res = await wcApi.getAsync("shipping/zones/$id/locations");
//             var res = await wcApi.getAsync("shipping/zones/2/locations");

          if (res is Map && isNotBlank(res["message"])) {
            throw Exception(res["message"]);
          } else {
            List locations = res;
            bool isValid = true;
            bool checkedPostcode = false;
            bool isChecked = false;
            locations.forEach((o) {
              if (o["type"] == "Country" && isValid && !isChecked) {
                isValid = address.country == o["code"];
                isChecked = isValid;
              }
              if (o["type"] == "postcode" && ((!checkedPostcode && isValid) || (checkedPostcode && !isValid))) {
                isValid = address.zipCode == o["code"];
                checkedPostcode = true;
              }
            });

            if (isValid) {
              for (var item in response) {
                list.add(ShippingMethod.fromjson(item));
              }
            }
          }
        }
        // }
      }
      return list;
    } catch (e) {

      rethrow;
    }

  }

  @override
  Future <List<Order>> getMyOrder({UserState userState, page}) async{
    try{
      var response = await wcApi.getAsync("orders?customer=${userState.user.id}&per_page=20&page=$page");
      List<Order> list = [] ;
      if(response is Map && isNotBlank(response["message"])){
        throw Exception(response["message"]);
      }else{
        for(var item in response){

          list.add(Order.fromJson(item));
        }


        return list ;
      }
    }catch(e){
    }
  }

  @override
  Future getAuthor({id}) async{

    try{
//      List<Product> list= [];
//      var response = await dokanAPI.getAsync("products/$id");
      final http.Response response =
      await http.get("${Constants.URL_CLOUD}/wp-json/dokan/v1/products/600?consumer_key=${Constants.CONSUMER_KEY_CLOUD}&consumer_secret=${Constants.CONSUMER_SECRET_CLOUD}");
      final body = convert.jsonDecode(response.body);
      http://dokan.test/wp-json/dokan/v1/products/<id>
      return null ;
    }catch(e){
    }
  }

  @override
  Future<User> loginGoogle({var token}) async{
    const cookieLifeTime = 120960000000;
    try {

      var endPoint = "${Constants.URL_CLOUD}/wp-json/api/flutter_user/google_login/?second=$cookieLifeTime&access_token=$token";
      var response = await http.get(endPoint);

      var jsonDecode = convert.jsonDecode(response.body);
      if (jsonDecode['wp_user_id'] == null || jsonDecode["cookie"] == null) {
        throw Exception(jsonDecode['error']);
      }
      return User.fromJsonFB(jsonDecode);
    } catch (e) {
      //This error exception is about your Rest API is not config correctly so that not return the correct JSON format, please double check the document from this link https://docs.inspireui.com/fluxstore/woocommerce-setup/
      rethrow;
    }
  }

  @override
  Future<List<OrderNote>> getNotes({page,orderId}) async{
   try{
     var response = await wcApi.getAsync("orders/$orderId/notes");
    List<OrderNote> list = [];
    if (response is Map && isNotBlank(response["message"])) {
      throw Exception(response["message"]);
    } else {
      for (var item in response) {
        list.add(OrderNote.fromJson(item));
      }
      return list;
    }
//    return list ;
  }catch(e){
  throw e ;
  }
  }

  @override
  Future<List<Categories>> getCategoriesHome() async {
    try{
      var response =
      await wcApi.getAsync("products/categories?&exclude=311&per_page=50&parent=0");
      List<Categories> list = [];
      for(var item in response){
        list.add(Categories.fromjson(item));
      }
        return list ;

    }catch(e){

      throw e ;
    }
  }

}