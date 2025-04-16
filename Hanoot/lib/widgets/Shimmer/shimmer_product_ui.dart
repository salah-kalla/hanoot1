import 'package:flutter/material.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';

class ShimmerProductUI extends StatelessWidget {
  final bool horizontal ;

  const ShimmerProductUI({this.horizontal});
  @override
  Widget build(BuildContext context) {

    return  horizontal? ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context,index){
        return

          Container(
            width: 200,
            child: _ShimmerProductsCard(context),
          );
      },
      separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
    )
        : GridView.builder(
      // physics: ScrollPhysics(),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

        childAspectRatio: .8,
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,

      ),


      itemBuilder: (context, index)=>

          _ShimmerProductsCard(context),

//                    Text(state.products[index].inStock.toString()),
      shrinkWrap: true,
      itemCount: 6,

    );
  }
  Widget _ShimmerProductsCard(BuildContext context){
    return Shimmer.fromColors(baseColor: Colors.grey.withOpacity(0.5), highlightColor: Colors.white.withOpacity(0.5),

      child: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        margin:EdgeInsets.all(5) ,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4)
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            SizedBox(height: Constants.screenAwareSize(2, context),),
            Expanded(
              flex: 1,
              child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child:Text("جاري الإنتظار ...",style: GoogleFonts.elMessiri(
                        fontSize: Constants.screenAwareSize(10, context),
                        fontWeight: FontWeight.w500,
                      ),
                        textAlign: TextAlign.right,
                      ),
                    )
                ),
                SizedBox(height: 3,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      child: SmoothStarRating(
                        allowHalfRating: true,
                        starCount: 5,
                        rating: 0.0,
                        size: Constants.screenAwareSize(8, context),
                        color: Theme.of(context).accentColor,
                        borderColor: Theme.of(context).accentColor,
                        spacing: 0.0,
                      ),
                    ),
                    SizedBox(width: 1,),
                    Text(" (0) ",textAlign:TextAlign.right,style: GoogleFonts.elMessiri(fontSize: Constants.screenAwareSize(8, context), color: Theme.of(context).accentColor,),),
                  ],
                ),
                SizedBox(height: 10,),
                Padding(

                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      alignment:Alignment.centerRight,
                      child:Text(" 0.0 "+"د،لـ",style: GoogleFonts.elMessiri(
                        fontSize: Constants.screenAwareSize(10, context),
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.right,

                      ),
                    )

                ),
                Spacer(),
                Container(
                  height: 25,
                  width: 70,
                  child: Row(
                    children: <Widget>[
                      Text("اضف للسلة")
                    ],
                  ),
                )

              ],
              ),
            ),
//            SizedBox(height: Constants.screenAwareSize(2, context),),

          ],
        ),
      ),
    );
  }
}

