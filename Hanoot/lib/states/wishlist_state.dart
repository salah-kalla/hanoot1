import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/products.dart';
import 'package:localstorage/localstorage.dart';

class WishListState extends ChangeNotifier{
  List<Product> wishListCartProducts;

  WishListState(){
wishListCartProducts=[];
    getLocalWishlist();
  }
  bool checkInWishList(Product product){
    bool isPresent = false;
    if (wishListCartProducts.length > 0) {
      for (int i = 0; i < wishListCartProducts.length; i++) {
        if (wishListCartProducts[i].id == product.id) {
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }
      notifyListeners();
    }
    notifyListeners();
    return isPresent ;
  }
  addProductToWishList(Product product){
    bool isPresent = false;

    if (wishListCartProducts.length > 0) {
      for (int i = 0; i < wishListCartProducts.length; i++) {
        if (wishListCartProducts[i].id == product.id) {
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }
      if(!isPresent){

        wishListCartProducts.add(product);
     //   saveLocalWishListItem(wishListCartProducts);
        // removeFromCartforProduct(product);
        saveWishListsToLocal(wishListCartProducts);
        notifyListeners();
      }else{
      }
    } else {
      wishListCartProducts.add(product);
      //saveLocalWishListItem(wishListCartProducts);
      saveWishListsToLocal(wishListCartProducts);
      //   removeFromCartforProduct(product);
      notifyListeners();


    }

  }
  removeProductAndAddToCart(Product item){
    wishListCartProducts.remove(item);
    saveWishListsToLocal(wishListCartProducts);
    notifyListeners();
  }
  removeProductFromWishList(item){
   try{
     wishListCartProducts.remove(item);
     saveWishListsToLocal(wishListCartProducts);
     notifyListeners();
   }catch(e){
   }
  }
  Future<void> saveWishListsToLocal(List<Product> products)async{

    final LocalStorage storage = LocalStorage("into");
    try {
      final ready = await storage.ready;
      if (ready) {

        await storage.setItem("wishlist", products);
      }
    } catch (err) {
    }
  }
  Future<void> getLocalWishlist() async {
    final LocalStorage storage = LocalStorage("into");
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = await storage.getItem("wishlist");
        if (json != null) {
          List<Product> list = [];
          for (var item in json) {
            list.add(Product.fromLocalJson(item));
          }
          wishListCartProducts = list;
        }
      }
    } catch (err) {
    }
  }


}