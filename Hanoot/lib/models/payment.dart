class PaymentMethod{
  String id;
  String title;
  String description ;
  bool enabled ;
  PaymentMethod({this.id,this.title,this.description,this.enabled});
  PaymentMethod.fromjson(Map<String, dynamic> datajson){
    id=datajson["id"];
    title = datajson["title"];
    description = datajson["description"];
    enabled = datajson["enabled"];
  }
}