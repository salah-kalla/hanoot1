import 'package:quiver/strings.dart';


  class ShippingMethod {
  String id ;
  String title ;
  String description ;
  double cost;
  String classCost;
  String methodId;
  String methodTitle;

  ShippingMethod({this.id,this.title,this.classCost,this.cost,this.description,this.methodId,this.methodTitle});


  ShippingMethod.fromjson(Map<String,dynamic> jsondata){
    try{
      id = "${jsondata["id"]}";
      title =  isNotBlank(jsondata["title"]) ? jsondata["title"] : jsondata["method_title"];
      description = jsondata["description"];
      methodTitle = jsondata["method_title"];
      cost = jsondata["settings"] != null &&
          jsondata["settings"]["cost"] != null &&
          isNotBlank(jsondata["settings"]["cost"]["value"])
          ? double.parse(jsondata["settings"]["cost"]["value"])
          : 0.0;
      Map settings = jsondata["settings"];
      settings.keys.forEach((key) {
        if (key is String && key.contains("class_cost_")) {
          classCost = jsondata["settings"][key]["value"];
        }
      });

    }catch(e){

    }

  }

  }
