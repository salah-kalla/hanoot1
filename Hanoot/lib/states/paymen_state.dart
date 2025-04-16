import 'package:Hanoot/models/address.dart';
import 'package:Hanoot/models/payment.dart';
import 'package:Hanoot/models/shipping_method.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:flutter/foundation.dart';

class PaymentState extends ChangeNotifier{
  Services _services = Services();
  List<PaymentMethod> paymentMethod ;
  bool loading = true ;
  PaymentState(){
    getPaymentMethods();
  }
  Future<void> getPaymentMethods({Address address,ShippingMethod shippingMethod,
  String token})async{
    try{
      paymentMethod = await _services.getPaymentMethods(
          address: address,
      shippingMethod: shippingMethod,
      token: token);
      loading=false;
      notifyListeners();
    }catch(e){
      loading=false;
      notifyListeners();
      throw Exception("error in get Payment Methods:");
    }
  }
}