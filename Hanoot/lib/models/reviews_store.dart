class Reviews {
  String comment_author;
  String email ;
  String comment_content ;
  String userId ;
  int rating ;
  int id ;
  String  comment_date ;
  Reviews.fromjson(Map<dynamic, dynamic> jsondate){
    this.id = jsondate['id'];
    this.comment_author = jsondate["author"]['name'];
    this.email = jsondate["author"]['email'];
    this.comment_content = jsondate['content'];
    this.userId = jsondate["author"]['id'];
    this.rating = jsondate['rating'];
    this.comment_date = jsondate["author"]['date'];
  }

}