import 'dart:async';
import 'dart:core';
import 'package:connectivity/connectivity.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/models/order.dart';
import 'package:Hanoot/models/payment.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/models/reviews_store.dart';
import 'package:Hanoot/models/address.dart';
import 'package:Hanoot/models/user.dart';
import 'package:Hanoot/services/woocommerce.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/cart_state.dart';
abstract class BaseServices {
  Future<List<Categories>> getCategories();
  Future<List<Categories>> getCategoriesHome();
  Future<List<Product>> getProducts({page});
  Future<List<OrderNote>> getNotes({page,orderId});

  Future creatReview({int productId, Map<String, dynamic> data});
  Future<User> loginGoogle({String token});
  Future<List<Product>> fetchProductsByCategory(
  {categoryId,page,minPrice,maxPrice, orderBy,lang,order});
  Future<dynamic> loginFacebook({String token});
  Future<dynamic> loginSMS({String token});
  Future<List<dynamic>> getReview(productId);
  Future<List<dynamic>>  getProductVariations(dynamic product);
//  Future<List<dynamic>>  getShippingMethods({dynamic address,String token});
  Future<List<dynamic>>  getShippingMethod({dynamic address,String token});
  Future<dynamic> getAuthor({id});
  Future<List<dynamic>> getPaymentMethods({dynamic address, dynamic shippingMethod, String token});
  Future  getCategoryWithCache({List<Categories> CAtegories});
  Future updateOrder(orderId,{status});
  Future<List<dynamic>> searchProducts({name, page});
  Future<dynamic> getUserInfo(cookie);
  Future<User> createUser({
  firstName,
    lastName,
    username,
    password,
    isVendor,
});
 Future<dynamic> getMyOrder({UserState userState, page});
Future<dynamic> login({username,password});
  Future<dynamic> getProduct(id);
  Future<dynamic> getCoupons();
  Future<Order> CreateNewOrder ({CartState cartState, UserState userState, bool poid});
  Future  createOrder(
      Map<String,int> productsInCart,
      Map<String,ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod,
      userid){}

}

class Services implements BaseServices {
  BaseServices serviceApi = Woocommerce.fromConfig();
  static final Services _instance = Services._internal();
  factory Services()=>_instance;
  Services._internal();

  @override
  Future creatReview({int productId, Map<String, dynamic> data}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.creatReview(productId: productId,data: data);

    }else{
      throw Exception("No internet connection");
    }
  }

  @override
  Future createOrder(
      Map<String, int> productsInCart,
      Map<String,ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod,
      [userid=1])async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.createOrder(productsInCart, productVariationsInCart, address, paymentMethod, userid);

    }else{
      throw Exception("No internet connection");
    }
    // TODO: implement createOrder
  }

  @override
  Future <User> createUser({firstName, lastName, username, password,isVendor}) async{
    // TODO: implement createUser
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.createUser(
        firstName: firstName,
        lastName: lastName,
        username: username,
        password: password,
        isVendor: isVendor
      );

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<List<Product>> fetchProductsByCategory({categoryId, page, minPrice,
    maxPrice, orderBy, lang="en", order})async {
    // TODO: implement fetchProductsByCategory
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.fetchProductsByCategory(
        categoryId: categoryId,
        page: page,
        minPrice: minPrice,
        maxPrice: maxPrice,
        orderBy: orderBy,
        order: order,
        lang: lang
      );


    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<List<Categories>> getCategories() async{
    // TODO: implement getCategories
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getCategories();

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future getCoupons() async{
    // TODO: implement getCoupons
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getCoupons();

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<List> getPaymentMethods({address, shippingMethod, String token}) async{
    // TODO: implement getPaymentMethods
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getPaymentMethods(
        address: address,
        shippingMethod: shippingMethod,
        token: token
      );
    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future getProduct(id) async{
    // TODO: implement getProduct
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getProduct(id);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<List<ProductVariation>> getProductVariations(product) async{
    // TODO: implement getProductVariations
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getProductVariations(product);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future <List<Product>> getProducts({page}) async{
    // TODO: implement getProducts
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){


      return serviceApi.getProducts(page: page);
    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<List> getReview(productId) async{
    // TODO: implement getReview
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getReview(productId);

    }else{
      throw Exception("No internet connection");

    }
  }

//  @override
//  Future<List> getShippingMethods({address, String token}) async{
//    // TODO: implement getShippingMethods
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
//      return serviceApi.getShippingMethods(address: address,token: token);
//
//    }else{
//      throw Exception("No internet connection");
//
//    }
//  }

  @override
  Future getUserInfo(cookie) async{
    // TODO: implement getUserInfo
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getUserInfo(cookie);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future login({username, password}) async{
    // TODO: implement login
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.login(username: username,password: password);

    }else{
      throw Exception("No internet connection");

    }  }

  @override
  Future loginFacebook({String token}) async{
    // TODO: implement loginFacebook
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.loginFacebook(token: token);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future loginSMS({String token}) async{
    // TODO: implement loginSMS

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.loginSMS(token: token);

    }else{
      throw Exception("No internet connection");

    }  }

  @override
  Future<List> searchProducts({name, page}) async{
    // TODO: implement searchProducts

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.searchProducts(name: name,page: page);

    }else{
      throw Exception("No internet connection");

    }
  }
  @override
  void dispose(){

  }
  @override
  Future updateOrder(orderId, {status})async {
    // TODO: implement updateOrder

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.updateOrder(orderId,status: status);

    }else{
      throw Exception("No internet connection");

    }   }


  @override
  Future getCategoryWithCache({List<Categories> CAtegories}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getCategoryWithCache();

    }else{
      throw Exception("No internet connection");

    }
  }


  @override
  Future<Order> CreateNewOrder({CartState cartState, UserState userState, bool poid}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.CreateNewOrder(cartState: cartState,userState: userState,poid: poid);

    }else{
      throw Exception("No internet connection");

    }
    // TODO: implement CreateNewOrder
  }

  @override
  Future<List> getShippingMethod({address, String token}) async{
    // TODO: implement getShippingMethod
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getShippingMethod(address: address,token: token);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future getMyOrder({UserState userState, page}) async{
    // TODO: implement getShippingMethod
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getMyOrder(userState: userState,page: page);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future getAuthor({id}) async{
    // TODO: implement getAuthor
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getAuthor(id: id);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<User> loginGoogle({String token}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.loginGoogle(token: token);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<List<OrderNote>> getNotes({page,orderId}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getNotes(page: page,orderId:orderId);

    }else{
      throw Exception("No internet connection");

    }
  }

  @override
  Future<List<Categories>> getCategoriesHome() async{
    // TODO: implement getCategories
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      return serviceApi.getCategoriesHome();

    }else{
      throw Exception("No internet connection");

    }
  }

}