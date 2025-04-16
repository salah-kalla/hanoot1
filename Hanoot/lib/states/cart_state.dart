

import 'dart:collection';
import 'dart:convert' ;

import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/payment.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/models/address.dart';
import 'package:Hanoot/models/shipping_method.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:localstorage/localstorage.dart';

class CartState extends ChangeNotifier{
  Services _service = Services();
  bool loading = false;

  // product with id
  Map<String, Product> _products;
  //product with id and quantity
  Map<String, int> _productsInCart ;
  // product list in  cart
  Map<String, int > get productsInCart => _productsInCart ;
  Map<String, ProductVariation> _productVariationInCart = {};
  Map<String, ProductVariation> get productVariationInCart =>
      Map.from(_productVariationInCart);
  double totalCartAmount = 0 ;
  //add product
  Map<String,Product> get products =>_products;

    Map<Product,ProductVariation> _wishListProducts = HashMap();
  Map<Product,ProductVariation> get wishListProducts  => _wishListProducts ;
  //add product id and quantity selected ;
  Map<String,int> _productQuantityInCart;
  Map<String,int> get productQuantityInCart=>_productQuantityInCart;

  //update according to shipping methods ;
double totalCartExtraCharge = 200 ;
double totalCartPayableAmount = 0 ;
Address address ;

List<dynamic> paymentMethodList ;
PaymentMethod paymentMethod ;
bool paymentLoading ;
List<ShippingMethod> shippingMethodList ;
ShippingMethod shippingMethodItem ;
bool shippingLoading ;
String couponCode ;
List cartProducts = List();
//List wishListCartProducts= List();
 CartState(){
   shippingLoading = true ;
   paymentLoading = true ;
   shippingMethodList = List();
   paymentMethodList = List();
   _products = HashMap();
   _productsInCart = HashMap();
   _productQuantityInCart = HashMap();
   _productVariationInCart = HashMap();
   address = Address();
   getAddress();
   getCartFromLocal();

   calculateTotalCartAmount();

 }
 saveOrder(order) async{
    final LocalStorage storage = LocalStorage('into_order');
   try{


     // save the order Info as local storage
     final ready = await storage.ready;

     if (ready) {

       await storage.setItem("orders", order);
     }
   }catch(e){

   }
 }
 Future<void> CreateNewOrder({ Function success,
   Function fail,CartState cartState , UserState userState, bool paid})async{
   try{
     loading = true;
     notifyListeners();
     final order =  await _service.CreateNewOrder(cartState: cartState,userState: userState,poid: paid);
     success();

     loading = false;
     notifyListeners();
   } catch (err) {
     fail(err.toString());
     loading = false;
     notifyListeners();
   }

 }

 setAddress(Address address){
try{
  this.address=address;
  saveShippingAddress(address);
  notifyListeners();
}catch(e){

}
 }
 saveShippingAddress(Address address) async{
   final LocalStorage storage =  LocalStorage("hanootAddress");
   try{
     final ready = await storage.ready;
     if(ready){

       await storage.setItem("shippingAddress", address);
     }else{

     }
   }catch(e){

   }
   notifyListeners();
 }

  Future getAddress ()async{


     final LocalStorage storage = LocalStorage("hanootAddress");
     try{
       final ready = await storage.ready;
       if(ready){
         final addressJson = storage.getItem("shippingAddress");
         if(addressJson!=null){
           address = Address.fromlocaljson(addressJson);

           return address ;
         }else{


           return null ;
         }
       }else{

       }
     }catch(e){


     }
     notifyListeners();

   return address ;
 }
addProductToCart(
    Product product ,
    ProductVariation variation ,
    int qountity,
    bool isSave
    ){

try{
  if (isSave) {
      if(_productsInCart.containsKey(product.id.toString())){
       var newQou = _productsInCart[product.id.toString()];
       newQou+=qountity;
        _productsInCart.update(product.id.toString(), (_) => newQou,
            ifAbsent: () => qountity);

      }else{
        _productsInCart.update(product.id.toString(), (_) => qountity,
            ifAbsent: () => qountity);
      }


    saveCartListsInLocal(
        product: product, qountity: qountity, variation: variation);
  }

  bool isPresent = false;

  if (cartProducts.length > 0) {
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].product.id == product.id) {
        cartProducts[i].quantity+=qountity;
        if(variation!=null){
          double  price = double.parse(variation.price);
          double total = (price * qountity) ;
          totalCartAmount += total;
        }else{
          double  price = double.parse(cartProducts[i].product.price);
          double total = (price * qountity) ;
          totalCartAmount += total;
        }
        isPresent = true;
        break;
      } else {

        isPresent = false;
      }
    }
    if(!isPresent){
      var key= "${product.id}";
      _productVariationInCart.update(key, (value) => variation,ifAbsent: ()=>variation);
      cartProducts.add(CartProduct(productVariation: variation,product: product,quantity: qountity));
      _productsInCart.update(product.id.toString(), (_) => qountity,
          ifAbsent: () => qountity);

      if(variation!=null){

        double  price = double.parse(variation.price);
        double total = (price * qountity) ;
        totalCartAmount += total;

      }else{

        double  price = double.parse(product.price);
        double total = (price * qountity) ;
        totalCartAmount += total;
      }
      notifyListeners();

    }
  } else {
    totalCartAmount = 0.0;
    var key= "${product.id}";
    _productVariationInCart.update(key, (value) => variation,ifAbsent: ()=>variation);
    cartProducts.add(CartProduct(productVariation: variation,product: product,quantity: qountity));
    _productsInCart.update(product.id.toString(), (_) => qountity,
        ifAbsent: () => qountity);

    if(variation!=null){
      double  price = double.parse(variation.price);
      double total = (price * qountity) ;
      totalCartAmount += total;

    }else{

      double  price = double.parse(product.price);
      double total = (price * qountity) ;
      totalCartAmount = total;
    }
    notifyListeners();
  }
}catch(e){

  notifyListeners();

}

}


/////get sub total
  double getShippingCost(){
   return 100.0 ;
  }
  Future<void> clearCartListsInLocal()async{
    final LocalStorage storage = LocalStorage("into");
    try {
      final ready = await storage.ready;
      if (ready) {

        List items =  await storage.getItem("cart_items");
        if(items!=null){
          items=null;
        }else {
          items=null;

        }
        await storage.setItem("cart_items", items);

      }
    } catch (err) {
    }
  }
  Future<void> saveCartListsInLocal(   { Product product ,
      ProductVariation variation ,
      int qountity})async{

    final LocalStorage storage = LocalStorage("into");
    try {
      final ready = await storage.ready;
      if (ready) {

       List items =  await storage.getItem("cart_items");
       if(items!=null){

         items.add({
           'product':product.toJson(),
           "productVariation":variation!=null?variation.toJson():null,
           "quantity":qountity
         });
       }else {
         items = [
           {
             "product": product.toJson(),
           "productVariation": variation != null ? variation.toJson() :null,
           "quantity": qountity,
           }
         ];
       }
       await storage.setItem("cart_items", items);

      }
    } catch (err) {
    }
  }
  Future<void> getCartFromLocal() async {
    final LocalStorage storage = LocalStorage("into");
    try {
      final ready = await storage.ready;
      if (ready) {
        List items = await storage.getItem("cart_items");
        if (items != null) {
          for(var item in items){
            addProductToCart(    Product.fromLocalJson(item["product"]),
              item["productVariation"] != null
                  ?ProductVariation.fromLocalJson(item["productVariation"])
                  : null,
              item["quantity"],
              false,);
          }
        }
      }
    } catch (err) {
    }
  }
  
  removeFromCartforProduct(item){
if(item.productVariation!=null){
  double price = double.parse(item.productVariation.price);
  final totalPrice = item.quantity * price ;
  totalCartAmount -= totalPrice;
}else{
  double price = double.parse(item.product.price);
  final totalPrice = item.quantity * price ;
  totalCartAmount -= totalPrice;
}
    _productsInCart.remove(item.product.id.toString());

    cartProducts.remove(item);
   var key= "${item.product.id}";
    _productVariationInCart.remove(key);
    removeItemFromCartListsInLocal(item);
    //saveCartListsToLocal(cartProducts);

    //  _saveProductsToLocalStorage();
    notifyListeners();
  }
  /// remove item in local database 
  Future<void> removeItemFromCartListsInLocal(cartItems)async{

    final LocalStorage storage = LocalStorage("into");
    try {
      final ready = await storage.ready;
      if (ready) {

        List items =  await storage.getItem("cart_items");
        if(items!=null){
          for(var i = 0 ; i<items.length;i++){
            if(items[i]["product"]["id"] == cartItems.product.id){
              items.remove(items[i]);

            }
          }
        }else {
        }
        await storage.setItem("cart_items", items);

      }
    } catch (err) {
    }
  }

  ////////////////Make The Amount For Zero
  defaultAmountPriceToZeroUesedItem(item){
    double price = double.parse(item.product.price);
    double total = (price * item.quantity) ;
    totalCartAmount -= total;
    notifyListeners();
   // _saveProductsToLocalStorage();
  }

  // delete same quantity for product if more 1 and remove product if then 1
  // update productQuantityInCart if more 1 and remove key for product from list  Map if then 1
  removeQuantityProductInCart(item){
    bool isPresent = false;
    // if list for empty or no
    if (cartProducts.length > 0) {
      for (int i = 0; i < cartProducts.length; i++) {
        // If the product exists in the list or not
        if (cartProducts[i].product.id == item.product.id) {
          // If the quantity for the product is more 1 or not
          if(cartProducts[i].quantity>=2&&cartProducts[i].quantity!=1){
            cartProducts[i].quantity-=1;
            if(cartProducts[i].productVariation!=null){

              double price = double.parse(cartProducts[i].productVariation.price);
              totalCartAmount -= price;
            }else{

              double price = double.parse(cartProducts[i].product.price);
              totalCartAmount -= price;
            }


          //  _saveProductsToLocalStorage();
            updateSaveCartListsInLocal(cartProducts[i]);
            var newQou = _productsInCart[cartProducts[i].product.id.toString()];
            newQou--;
            _productsInCart.update(cartProducts[i].product.id.toString(), (_) => newQou,
                ifAbsent: () => newQou);

          }else{
                 notifyListeners();
          }

          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }
      if(!isPresent){
      }
    } else {

    }


    notifyListeners();

  }

  ////update quantity in save local
  Future<void> updateSaveCartListsInLocal(cartItems)async{

    final LocalStorage storage = LocalStorage("into");
    try {
      final ready = await storage.ready;
      if (ready) {

        List items =  await storage.getItem("cart_items");
        if(items!=null){
        for(var i = 0 ; i<items.length;i++){

          if(items[i]["product"]["id"] == cartItems.product.id){
            items[i]["quantity"] = cartItems.quantity;

          }
        }
        }else {
        }
        await storage.setItem("cart_items", items);
      }
    } catch (err) {
    }
  }
  // add same quantity for product
  // update productQuantityInCart if more 1
  addQuantityProductInCart(item){
    bool isPresent = false;
    // if list for empty or no
    if (cartProducts.length > 0) {
      for (int i = 0; i < cartProducts.length; i++) {
        // If the product exists in the list or not
        if (cartProducts[i].product.id == item.product.id) {
          // If the quantity for the product is more 1 or not
          if(cartProducts[i].quantity>=1){
            cartProducts[i].quantity+=1;
            if(cartProducts[i].productVariation!=null){
              double price = double.parse(cartProducts[i].productVariation.price);
              totalCartAmount += price;
            }else{
              double price = double.parse(cartProducts[i].product.price);
              totalCartAmount += price;
            }

            updateSaveCartListsInLocal(cartProducts[i]);
            var newQou = _productsInCart[cartProducts[i].product.id.toString()];
            newQou++;
            _productsInCart.update(cartProducts[i].product.id.toString(), (_) => newQou,
                ifAbsent: () => newQou);
          }


        }
      }

    }


    notifyListeners();

  }

//  removeProductFromWishList(item){
//        wishListCartProducts.remove(item);
//        notifyListeners();
//  }
  setcouponCode(String value){
   couponCode = value ;
  }
  calculateTotalCartAmount(){
   cartProducts.forEach((item){
   //  double totalAmount = 0.0;
     double  price = 0.0;
     double total = 1 ;
     for (int i = 0; i < cartProducts.length; i++) {
       price = double.parse( cartProducts[i].product.price);
       total = (price * cartProducts[i].product.quantity) ;
       totalCartAmount += total;
     }
//     totalCartAmount+=double.parse(item.product.price);

   });

  }

  clearCart(){
   cartProducts.clear();
   productsInCart.clear();
   _productsInCart.clear();
   _productVariationInCart.clear();
   clearCartListsInLocal();
  // saveCartListsToLocal(cartProducts);

   //_saveProductsToLocalStorage();
   notifyListeners();

  }
  updateTotalPayableAmount()=>totalCartPayableAmount=totalCartAmount+totalCartExtraCharge;
  getShippingMethod({address,token}) async{
   try{
     shippingLoading = true ;
     notifyListeners();
     shippingMethodList = await _service.getShippingMethod(address: address,token: token);
     shippingMethodItem = shippingMethodList[0];
     shippingLoading = false ;
     notifyListeners();
   }catch(e){

   }
  }
  setShippingMethod(item,{bool method}){

    if(method){
      shippingMethodItem = item ;
      shippingMethodItem.cost =  double.parse(shippingMethodItem.classCost);
    }else{
      shippingMethodItem = item ;
    }
    notifyListeners();
  }
  /// Payments methods
  getPaymentMethods() async{
    try{
      paymentLoading = true ;
     // notifyListeners();
      paymentMethodList = await _service.getPaymentMethods();
      paymentMethod = paymentMethodList[0];
      paymentLoading = false ;
      notifyListeners();
    }catch(e){

    }
  }
  setPaymentMethod(item){
    paymentMethod = item ;
    notifyListeners();
  }

}

//class used to save and reterive product from local storage
class CartProduct{
Product product ;
ProductVariation productVariation ;
int quantity ;
CartProduct({this.productVariation,this.product,this.quantity});
Map<String,dynamic> toJson(){
  return{
    'product':product.toJson(),
    "productVariation":productVariation,
    "quantity":quantity
  };
}

CartProduct.fromjson(Map<String,dynamic> datajson){
  product = Product.fromjson(datajson["product"]);
  productVariation = ProductVariation.fromjson(datajson["productVariation"]);
  quantity = datajson["quantity"];
}
@override
  String toString() {
    // TODO: implement toString
    return "\n$product\n$productVariation\n$quantity";
  }


}