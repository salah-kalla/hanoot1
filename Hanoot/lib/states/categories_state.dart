import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/services/base_services.dart';

class CategoriesState with ChangeNotifier{
  Services services = Services();
  List<Categories> category ;
  List<Categories> parentCategory ;
  List<Categories> parentCategoryHome ;

  List<Categories> supplierCategories;
  List<Categories> subcategory ;
  Map<int,Categories> categorieslist = {};
  bool isLoading = true ;
  String message ;
  CategoriesState(){
    category=List();
    supplierCategories=List();
    parentCategory=List();
    parentCategoryHome=List();
  isLoading = true ;

    getCategories() ;
    getCategoriesHome();
  }
  Future<void> getCategories()async{
    try{
      isLoading = true ;
      notifyListeners();
      category = await services.getCategories();
       for(var i in category){
         if(i.parent==0)
        {
           parentCategory.add(i);
         }
       }
      isLoading = false ;
message=null;
      supplierCategories = category.where((item) => item.parent==155).toList() ;

for(Categories cat in supplierCategories){
      }
notifyListeners();
    }catch(e){
isLoading = false ;
message = "هناك خطأ في جلب البيانات"+e.toString();

    }
  }
  Future<void> getCategoriesHome()async{
    try{
      isLoading = true ;
      notifyListeners();
      parentCategoryHome = await services.getCategoriesHome();
      isLoading = false ;
      message=null;
      notifyListeners();
    }catch(e){
      isLoading = false ;
      message = "هناك خطأ في جلب البيانات"+e.toString();

    }
  }
}