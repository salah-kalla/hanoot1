import 'package:Hanoot/models/payment.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/models/address.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:intl/intl.dart';

class ProductItem {
  int productId ;
  int variation_id ;
  String name ;
  int quantity;
  String total;


  ProductItem.fromJson(Map<String,dynamic> jsondata){
    productId =jsondata['product_id'];
    productId =jsondata['variation_id']??jsondata['variation_id'];
    name =jsondata['name'];
    quantity =jsondata['quantity'];
    total =jsondata['total'];

  }

}

class Order{
  int id;
  String number;
  String status;
  DateTime createdAt;
  double total;
  String paymentMethodTitle;
  String shippingMethodTitle;
  List<ProductItem> lineItem=[];
  Address billing ;
  Order({this.id,this.createdAt,this.number,this.status,this.total});
//  Order.fromjson(Map<String, dynamic> datajson){
//    id = datajson['id'];
//    number = datajson['number'];
//    status = datajson['status'];
//    createdAt = datajson['date_created']!=null
//    ?DateTime.parse(datajson['date_created']):
//        DateTime.now();
//    total = datajson['total']!=null?
//    double.parse('total'):0.0;
//    paymentMethodTitle = datajson['payment_method_title'];
//    datajson['line_items'].forEach((item){
//      lineItem.add(ProductItem.fromJson(item));
//    });
//    billing = Address.fromjson(datajson['billing']);
//    shippingMethodTitle = datajson['shipping_lines'][0]['method_title'];
//  }

  Map<String,dynamic> toJson(
    Map<String,int> productsInCart,
    Map<String,ProductVariation> productVariationInCart,
    Address address ,
    PaymentMethod paymentMethod,
    [userId=1]){
    var lineItems= productsInCart.keys.map((key){
      var productId = int.parse(key);
      var item ={"product_id":productId,"qountity":productsInCart[key]};
      if(productVariationInCart[key]!=null){
        item['variation_id']=productVariationInCart[key].id;
      }
    }).toList();
    return{
      "payment_method":paymentMethod.id,
      "payment_method_title":paymentMethod.title,
      "set_paid":false,
      "billing":address.toJson(),
      "shipping":address.toJson(),
      "line_items":lineItems,
      "customer_id":userId,
      "shipping_lines":[
        {'method_id':'flat_rate',"method_title":'Flat_Rate'}
      ]

    };
  }
  @override
  String toString()=>'Order{ id $id number: $number';

 Map<String,dynamic> toNewJson({CartState cartState, UserState userState, paid}) {

//   var lineItems = [
//     {
//       "product_id": 33,
//       "quantity": 2,
//     }     ,
//     {
//       "product_id": 43,
//       "quantity": 1,
//     }
//   ];
  var lineItems = cartState.productsInCart.keys.map((key) {
     var productId;
     if (key.contains("-")) {
       productId = int.parse(key.split("-")[0]);
     } else {
       productId = int.parse(key);
     }
     var item = {
       "product_id": productId,
       "quantity": cartState.productsInCart[key]
     };
     if (cartState.productVariationInCart[key] != null) {
       item["variation_id"] = cartState.productVariationInCart[key].id;
     }
     return item;
   }).toList();
   cartState.productsInCart.forEach((key, value) {
   });
   var params = {
     "payment_method": cartState.paymentMethod.id,
     "payment_method_title": cartState.paymentMethod.title,
     "set_paid": paid,
     "line_items": lineItems,
     "customer_id": userState.user.id,
     "status":"processing"
   };
//   if (paid) params["status"] = "completed";

//   if (kAdvanceConfig['EnableReview'] &&
//       cartModel.notes != null &&
//       cartModel.notes.isNotEmpty) {
//     params["customer_note"] = cartModel.notes;
//   }

//   if (kAdvanceConfig['EnableAddress']) {
     params["billing"] = cartState.address.toJson();
     params["shipping"] = cartState.address.toJson();
//   }

//   if (kAdvanceConfig['EnableShipping']) {
     params["shipping_lines"] = [
       {
         "method_id": cartState.shippingMethodItem.title,
         "method_title": cartState.shippingMethodItem.methodTitle,
         "total": cartState.shippingMethodItem.cost.toString()
       }
     ];
//   }

//   if (cartModel.couponObj != null) {
//     params["coupon_lines"] = [
//       {"code": cartModel.couponObj.code}
//     ];
//   }

   return params;
  }
  Order.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
   // customerNote = parsedJson["customer_note"];
    number = parsedJson["number"];
    status = parsedJson["status"];
    createdAt = parsedJson["date_created"] != null
        ? DateTime.parse(parsedJson["date_created"])
        : DateTime.now();
  //  dateModified = parsedJson["date_modified"] != null
//        ? DateTime.parse(parsedJson["date_modified"])
//        : DateTime.now();
    total =
    parsedJson["total"] != null ? double.parse(parsedJson["total"]) : 0.0;
//    totalTax = parsedJson["total_tax"] != null
//        ? double.parse(parsedJson["total_tax"])
//        : 0.0;
    paymentMethodTitle = parsedJson["payment_method_title"];

    parsedJson["line_items"].forEach((item) {
    lineItem.add(ProductItem.fromJson(item));
    });

    billing = Address.fromjson(parsedJson["billing"]);
    shippingMethodTitle = parsedJson["shipping_lines"] != null &&
        parsedJson["shipping_lines"].length > 0
        ? parsedJson["shipping_lines"][0]["method_title"]
        : null;
  }

}
class OrderNote{
  int id ;
 // String author;
  String note;
  var formattedDate;
  OrderNote.fromJson(Map<String,dynamic> json){
    id = json["id"];
  //  author = json["author"];
    formattedDate = json["date_created"];
    note = json["note"];
  }
  Map<String,dynamic> toJson(){
    return{
      "id":id,
      //"author":author,
      "note":note,
    };

  }
}