import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_reviews.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDescription extends StatefulWidget {
 final Product product ;

 ProductDescription(this.product);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
 final texStyle = GoogleFonts.elMessiri(fontWeight: FontWeight.w600) ;
double rating ;
TextEditingController reviewController = TextEditingController();
 creatReview(DetailState state)async{

   if(rating==0.0||reviewController.text.isEmpty||reviewController.text==""){

   }else{
     var reviews = reviewController.text ;
     int ratings = rating.toInt() ;
     setState(() {
       rating = 0.0;
       reviewController.text = "";
     });
     final user = Provider.of<UserState>(context,listen: false);
     if(user.user!=null)
       state.creatReview(productId: widget.product.id,data:{
       "review": reviews,
         "name": user.user.name,
         "email":user.user.email??user.user.name+"@hanoot.ly",
         "rating": ratings
     }).then((onValue) {
       setState(() {
         rating = 0.0;
         reviewController.text = "";
       });
     });
   }
 }
 updateRating(double index){
   setState(() {
     rating = index ;
   });
 }
@override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }
 @override
 void dispose() {
   reviewController.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 15,),
        Container(
          height: 1,decoration: BoxDecoration(color: Colors.grey[200]),
        ),
        ExpansionInfo(
          title: "الوصف",
          children: <Widget>[
            Align(
              alignment: Alignment.topRight
              ,child: HtmlWidget(
              widget.product.description,
              textStyle: texStyle,
            ),)


          ],
          expand: false,
        ),
       //enableReview?
          Container(
            height: 1,decoration: BoxDecoration(color: Colors.grey[200]),
          ),
        ChangeNotifierProvider<DetailState>(
            create: (context) => DetailState(widget.product.id),
            child:Consumer<DetailState>(builder: (context,state,child){
              return ExpansionInfo(
                title: "التعليقات",
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height/2.5,
                    child: Column(

                      children: <Widget>[
                        //      Text("test s"),
                        state.isReviewsLoading?
                        Expanded(
                          flex: 2,child: Container(
                          height:150,

                          padding: const EdgeInsets.all(15.0),

                            child: SingleChildScrollView(child: ShimmerReviews()),
                          ),
                        ):
                        state.
                        reviews.isNotEmpty?
                        Expanded(flex: 3,
                          child: Container(
                            height:150,
                            child: ListView.builder(itemBuilder: (context,index){
                              return Container(
                                margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    color:Colors.grey[200]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                     Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(Radius.circular(100)),
                                      
                                          ),
                                          child: Image.asset("assets/icons/emojis.png"),
                                          
                                        ),
                                       SizedBox(width: 10,),
                                     Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: <Widget>[
                                           Text("${state.reviews[index].reviewer}",
                                             style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor,
                                                 fontWeight: FontWeight.bold),),
                                           Text(state.reviews[index].review,style: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black),),
                                           SizedBox(height: 2,),
                                           Row(
                                             children: <Widget>[
                                               Container(
                                                 alignment: Alignment.topRight,
                                                 child: SmoothStarRating(
                                                   allowHalfRating: true,
                                                   starCount: 5,
                                                   rating: state.reviews[index].rating.toDouble()??0.0,
                                                   size: Constants.screenAwareSize(10, context),
                                                   color:Colors.amber,
                                                   borderColor: Colors.amberAccent,
                                                   spacing: 0.0,
                                                   isReadOnly: true,


                                                 ),
                                               ),
                                             ],
                                           ),
                                           SizedBox(height: 8,),

                                         ],
                                       ),

                                      ],
                                    )
                                  )


                              );
                            },
                              itemCount: state.reviews.length,
                            ),
                          ),
                        ):
                        Expanded(
                          flex: 2,child: Container(

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: Theme.of(context).accentColor.withOpacity(0.8),
                                    highlightColor:Theme.of(context).accentColor,
                                    child: Container(width: 50,height: 50,child:
                                    Image.asset("assets/icons/review2.png",color: Theme.of(context).accentColor,),),
                                  ),
                                  Text("لا يحتوي على تقييمات بعد ! "),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                         // height:80,
                         // color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  //  SizedBox(width: 5,),
                                  Expanded(
                                    flex:5,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            RatingBar(
                                              initialRating: 0.0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,

                                              ratingWidget: RatingWidget(
                                                full: Icon(
                                                  Icons.star,
                                                  color:Theme.of(context).accentColor,
                                                ),
                                                half:Icon(
                                                  Icons.star_half,
                                                  color:Theme.of(context).accentColor,
                                                ),
                                                empty:Icon(
                                                  Icons.star_border,
                                                  color:Theme.of(context).accentColor,
                                                ),
                                              ),

                                              onRatingUpdate:updateRating,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          height: 30,
                                          margin: EdgeInsets.all(6),
                                          child: TextFormField(
                                            controller: reviewController,
                                            decoration: InputDecoration(
                                                hintStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black),
                                                labelStyle: GoogleFonts.elMessiri(fontSize: 15,color: Colors.grey),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Theme.of(context).accentColor, width: 1.0),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                                ),
                                             icon: Icon(Icons.rate_review,color: Theme.of(context).accentColor),
                                              labelText: 'ضع تقييمك !',
                                              //  contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                                            ),

                                          ),
                                        ),


                                      ],
                                    ),

                                  ),
                                  Expanded(
                                    flex:2,
                                    child: Container(
                                      child:RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        onPressed: () async{
                                          // loginuser(context);
                                          await creatReview(state);
                                        },
                                        color: Theme.of(context).accentColor,
                                        child: Text('تقييم', style: GoogleFonts.elMessiri(color: Colors.white)),
                                      ),),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
                expand: false,
              );
            },))
        ,
        Container(
          height: 1,decoration: BoxDecoration(color: Colors.grey[200]),
        ),

      ],
    );
  }
}
class ExpansionInfo extends StatelessWidget {
  final String title ;
  final bool expand ;
  final List<Widget> children ;
  ExpansionInfo({@required this.title,this.children,this.expand});


  @override
  Widget build(BuildContext context) {
    return ConfigurableExpansionTile(
      initiallyExpanded: expand,
      headerExpanded: Flexible(child: Padding(padding: EdgeInsets.symmetric(vertical: 17.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,style: GoogleFonts.elMessiri(fontSize: 17,),textAlign: TextAlign.center,),
          Icon(Icons.keyboard_arrow_up),
        ],
      ),
      ),
      ),
      header: Flexible(child: Padding(padding: EdgeInsets.symmetric(vertical: 17.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,style: GoogleFonts.elMessiri(fontSize: 17),),
          Icon(Icons.keyboard_arrow_right,size: 20,),

        ],
      ),
      )),
      children: children,
    );
  }
}

