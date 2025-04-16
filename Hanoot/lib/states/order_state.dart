import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/order.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/states/UserState.dart';

class OrderState extends ChangeNotifier{
  List<Order> orders = List() ;
  Services services = Services();
  int page = 1 ;
  bool loading = true ;
  bool endPage = false ;
  OrderState(){
    services = Services();
    orders = List() ;
    notifyListeners();

  }
  Future <void> getMyOrders({UserState userState})async{
    try{
       loading = true ;
     //notifyListeners();
      orders =
      await services.getMyOrder(userState: userState,page:1);
      page = 1 ;
     saveOrders(order: orders);
       loading = false ;
       endPage = false ;
       notifyListeners();
    }catch(e){
      loading = false ;
      notifyListeners();
    }
  }
  Future<void> loadMore({UserState userState})async{
    try{
      page = page+1;
      notifyListeners();

      var order =
      await services.getMyOrder(userState: userState,page:page);
      orders = [...orders,...order];
      if(order.isEmpty)endPage=true ;
      loading = false ;
      notifyListeners() ;

    }catch(e){
      loading = false ;
      notifyListeners();
    }
  }

  void saveOrders({List<Order> order}) {
    if (orders==null||orders.isEmpty){
      orders = order ;
    }
    notifyListeners();
  }
}