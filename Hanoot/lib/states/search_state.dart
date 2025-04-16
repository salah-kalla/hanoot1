import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchState extends ChangeNotifier{
  bool isRersultLoading = false ;
  bool showKeywords = false ;
  String searchKeyword ;
  List<String> keyWords = List();
  List<Product> searchResult = List();
  int currentPage = 1 ;
  Services _services = Services();
  SearchState(){
    keyWords = List();
    _getRecentSearchList();
  }
  setKeyword(String value){
    isRersultLoading = false ;
    showKeywords = false ;
    searchKeyword = value ;
    if(!keyWords.contains(value)) keyWords.add(value);
    addKeywordsToStorage();
    _performSearch();
  }
  _performSearch()async{
    isRersultLoading = true ;
    notifyListeners();
    searchResult = await _services.searchProducts(name: searchKeyword,page: currentPage);
    isRersultLoading = false;
    notifyListeners();
  }
  Future<void>  addKeywordsToStorage()async{
try{

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setStringList(Constants.kLocalkey["recentSearches"], keyWords);
}catch(e){
}

  }
  clearResult(){
    showKeywords = true ;
    searchResult.clear();
    notifyListeners();
  }
  Future<void>  _getRecentSearchList()async{
    isRersultLoading = true ;
    notifyListeners();

    try{

      SharedPreferences preferences = await SharedPreferences.getInstance();
      final list = preferences.getStringList(Constants.kLocalkey["recentSearches"]);
      if(list!=null&&list.length>0)keyWords=list;
      showKeywords = true ;
      isRersultLoading = false ;
    }catch(e){
      isRersultLoading = false ;

    }
    notifyListeners();
  }
  void clearKeywords(){
    keyWords=List();
    addKeywordsToStorage();
    notifyListeners();
  }
  removeKeyword(String value){
    keyWords.remove(value);
    addKeywordsToStorage();
    notifyListeners();
  }

}