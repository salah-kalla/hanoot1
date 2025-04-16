import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:provider/provider.dart';
enum Errors {variationNotSelected, productNotLoaded }
class DetailState extends ChangeNotifier{
  bool isLoading,
  isRelatedProductsLoading,
  isVariantsLoading,
  isReviewsLoading,
  doesContainReviews;
  String _quantity;
  Services _services ;
  ProductVariation _currebtVariation;
  Product _product;
  List<Product> relatedProducts ;
  List<ProductVariation> _productVariations;
  List <Review> reviews ;
  String _productId ;
  int _categoryId ;
  Map<String, ProductVariation> variationMap = HashMap();
  Map<String,String> attributesMap = HashMap();
  DetailState(id){
    this._productId=id.toString();
    _quantity ="1";
    isLoading = true ;
    isVariantsLoading = true;
    isRelatedProductsLoading = true ;
    isReviewsLoading = true ;
    doesContainReviews = false ;
    relatedProducts = List();
    _productVariations=List();
    reviews = List();
    _services = Services();
    initProduct(id);

  }
  String get quantity =>_quantity ;
  Product get product =>_product;
  initProduct(id)async{
    try{

      _product = await _services.getProduct(_productId);
      _categoryId = _product.categoryId;
      isLoading = false ;
      notifyListeners();
      initRelatedProducts();
      initProductVariations();
      initReviews(id);
    }catch(e){

    }
  }

  // add to completed key
  changeAttributesTo(String attribute,String  value){
    attributesMap.update(attribute,(_)=>value,ifAbsent: ()=>value);
    //will be send add to completed key if was right  else send null variation
    changeProductVariation(variationMap[attributesMap.toString()]);

  }
  Future<void> creatReview({int productId, Map<String, dynamic> data})async{
  try{
    isReviewsLoading = true ;
    notifyListeners();
    await _services.creatReview(productId: productId,data: data);
    initReviews(productId);
  }catch(e){
    isReviewsLoading = false ;
    notifyListeners();
  }
}
  changeProductVariation(ProductVariation variation){
// "will be  Receive  ProductVariant value if is not equal null "
    _currebtVariation =variation ;
    notifyListeners();

  }

  // "changed auto  ProductVariant "

  ProductVariation get currentVariation=>_currebtVariation;
  initRelatedProducts()async{
    relatedProducts = await _services.fetchProductsByCategory(categoryId: _categoryId,page: 1);
    isRelatedProductsLoading = false ;
//    notifyListeners();
  }
  initReviews(id)async{
 try{
   isReviewsLoading = true ;
  // notifyListeners();
   reviews = await  _services.getReview(id);
   isReviewsLoading = false ;

  // notifyListeners();
   return reviews ;
 }catch(e){
   isReviewsLoading = false ;

 }
 notifyListeners();

  }
List<Review> getTopReviews(){
  isReviewsLoading = true ;
  notifyListeners();
    List<Review> topReviews = reviews.length>5?reviews.sublist(0,5):reviews;
  isReviewsLoading = false ;
  notifyListeners();
}
  initProductVariations()async{
try{
  _productVariations = await _services.getProductVariations(_product);

  isVariantsLoading = false ;
  notifyListeners() ;
  var items =1 ;

  _productVariations.forEach((variant){
    items++;
    Map<String,String> map = HashMap();
    variant.attribute.forEach((value){
      // add attribute object to map array on shape string value .
      map.update(value.name, (_) => value.option,ifAbsent: ()=>value.option);

    });

    //add map array to variationMap array on shape string key and ProductVariant value .
    variationMap.update(map.toString(), (_)=> variant, ifAbsent: ()=>variant);

  });


}catch(e){
}
  }
  List<ProductVariation> get productVariation => _productVariations;
  setQuantity(String value){
    _quantity = value;
    notifyListeners();
  }
  addToCart(context,product,quantity){
    if(product==null)throw "please not loaded";
    if(product!=null){
      if(_currebtVariation!=null){
        Provider.of<CartState>(context,listen: false).addProductToCart(product,_currebtVariation,quantity,true);

      }else{
        Provider.of<CartState>(context,listen: false).addProductToCart(product,null,quantity,true);

      }
    }
  }
  removeFromCart(context, item,product){
    if(product==null)throw "please not loaded";


        Provider.of<CartState>(context,listen: false).removeFromCartforProduct(item);


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _services.dispose();
  }
}