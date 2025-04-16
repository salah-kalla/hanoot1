import 'package:html_unescape/html_unescape.dart';
class Categories{
  int id;
  int parent ;
  int totalProduct;
  String name ;
  String image ;
  int count;

  Categories.fromjson(Map<String, dynamic> datajson){
//    if(datajson["Slug"]=="uncategorized"){
//      return ;
//    }
    count=datajson["count"];
    id=datajson["id"];
    name = HtmlUnescape().convert(datajson["name"]);
    parent=datajson["parent"];
    totalProduct=datajson["count"];
    final image =datajson["image"];
    if(image!=null){
      this.image=image['src'].toString();
    }else{
      this.image="https://hanoot.ly/wp-content/uploads/2020/09/photo-1-2.png";
    }
  }
  Map<String,dynamic>toJson(){
    return{
      "count":count,
      "id":id,
      "name":name,
      "parent":parent,
      "totalProduct":totalProduct,

    };
  }
  @override
  String toString()=>'Category { id: $id name: $name}';
}
