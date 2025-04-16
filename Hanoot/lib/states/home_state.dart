import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:localstorage/localstorage.dart';

class HomeState extends ChangeNotifier{
  Services _services ;
  bool isLoading ;
  int page = 1 ;
  bool endPage = false ;
  List<Product> products = [] ;
  List<Categories> category ;
  Map<int,Categories> categorieslist = {};
  List<Categories> subcategory ;
  List<Categories> parentcategory ;
  String errorMessage ;
  bool error0cured = false ;
  HomeState(){
    isLoading = true ;
    _services = Services();
    products = [];
  }
  getProducts()async{
    try{
      products = await _services.getProducts(page: 1);
      page = 1 ;

      endPage = false ;
      isLoading = false ;
      notifyListeners();
      cacheProducts();
    }catch(e){
      error0cured =true;
      isLoading =false;
      errorMessage = e.toString() ;
      loadProductsFromCache();
      notifyListeners();
    }
  }
  loadMoreProducts()async{
    try{
      page = page+1;
     // notifyListeners();
      var myProducts
          = await _services.getProducts(page: page);
      products = [...products,...myProducts];
      if(myProducts.isEmpty)endPage = true ;
      isLoading = false ;
      notifyListeners();
    }catch(e){
      error0cured =true;
      isLoading =false;
      errorMessage = e.toString() ;
      notifyListeners();
    }
  }
  cacheProducts()async{
    final LocalStorage _localStorage = LocalStorage(Constants.APP_FOLDER);
    try{
      final ready =await  _localStorage.ready;
      if(ready){
        await _localStorage.setItem(Constants.kLocalkey["home"], products);
      }
    }catch(e){
      throw e ;
    }
    notifyListeners();
  }
  loadProductsFromCache()async{
    isLoading = true ;
    final LocalStorage storage = new LocalStorage(Constants.APP_FOLDER);
    try{
      final ready = await storage.ready;
      if(ready){
        final json = storage.getItem(Constants.kLocalkey["home"]);
        if(json!=null){
            List<Product> list = [];
            for(var item in json ){
             // list.add(Product.fromlocaljson(item));
            }
            products = list ;
        }
      }
    }catch(e){
    }
    isLoading = true ;
    notifyListeners();
  }
  getCategories()async{

    try{
      category = await _services.getCategories();

      isLoading = false ;
      for(Categories cat in category){
        categorieslist[cat.id] = cat ;
      }
      await getCategoryWithCache(CAtegories: category);
      notifyListeners();

    }catch(e){
      isLoading = false ;

    }
  }
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
        List<Categories> categoryIdse = [];
        List<Categories> parentCategories = getParentCategory();
        for (var item in parentCategories) {
          if (hasChildren(item.id)) {
            List<Categories> subCategories = getSubCategories(item.id);
            for (var item in subCategories) {
              categoryIdse.add(item) ;
              categoryIds.add(item.id);
            }
          } else {

            //categoryIds.add(item.id);
          }
        }
        subcategory = categoryIdse ;
        parentcategory = parentCategories;
        for (var item in categoryIdse) {

        }
        for(var c in categoryIds){
        }
        //return await getCategoryCache(categoryIds);
      } else {}
     }catch(e){

    }
  }

}