
import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/services/base_services.dart';

class KitchenState extends ChangeNotifier{
  Services services ;
  List<Product> products ;
  int _categoryId ;

  int page =1 ;
  bool  endPage = false ;
  bool isLoading ;
  KitchenState({categoryId}){
    isLoading = true ;
    this._categoryId = categoryId ;
    products = List();
    services =Services();
    initProducts();
  }
  initProducts()async{
    isLoading = true ;
  //  notifyListeners();

    products = await services.fetchProductsByCategory(categoryId: _categoryId,page: 1);
    page = 1 ;
    endPage = false ;
    for(var item in products){
      print(item.categoryId);

    }
    //print(products.toString());
    isLoading = false ;
    notifyListeners();
  }
  Future<void> loadMoreCategoryProducts({ID})async{
    try{
      page = page+1;
      notifyListeners();

      var
      myProducts = await services.fetchProductsByCategory(categoryId: ID,page: page);

      products = [...myProducts,...products];
      if(myProducts.isEmpty)endPage=true ;
      isLoading = false ;
      notifyListeners() ;

    }catch(e){
      isLoading = false ;
      notifyListeners();
    }
  }

}