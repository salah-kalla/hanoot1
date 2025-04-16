import 'package:flutter/material.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';

class ShimmerReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  Container(
      height:150,
      child: ListView.builder(itemBuilder: (context,index){
        return   Container(

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
                    Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.8),
                        highlightColor:Colors.white,
              child:  Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(100)),

                      ),
                      child: Image.asset("assets/icons/emojis.png"),

                    )),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.8),
                            highlightColor:Colors.white,
                            child: Text("جاري الانتظار..",)),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.8),
                          highlightColor:Colors.white,
                          child: Text("...",style: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black)),),
                        SizedBox(height: 2,),
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topRight,
                              child: SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating: 5,
                                size: Constants.screenAwareSize(10, context),
                                color:Colors.grey,
                                borderColor: Colors.grey,
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
        itemCount:3,
      ),
    );

  }
}
