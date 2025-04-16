import 'package:flutter/material.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class ShimmerCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ShimmerCategoryCard(context);
  }
  Widget _ShimmerCategoryCard(BuildContext context){
    return   Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        gradient: LinearGradient(colors: [Colors.transparent,Constants.lightBG.withOpacity(.1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter

        ),
      ),
      child: Container(
        width: 300,
        height:300 ,
        margin:EdgeInsets.all(0) ,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),

          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white70.withOpacity(0.1),
                      highlightColor: Colors.white.withOpacity(0.2),
                      child: Container(

                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height ,
                        margin: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                        //  color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Theme.of(context).accentColor),
//                            borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: Constants.screenAwareSize(2, context),),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        color:Colors.black12.withOpacity(0.3),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child:    Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.8),
                            highlightColor:Colors.white,
                            child: Container(
                              height: 2,
                              width: 50,
                              color: Colors.grey,

                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
class ShimmerCategoryUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.all(2),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          gradient: LinearGradient(colors: [Colors.transparent,Constants.lightBG.withOpacity(.09)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter

          ),
        ),
        child:ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Padding(padding: EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child:  Shimmer.fromColors(
                        baseColor: Colors.white70.withOpacity(0.1),
                        highlightColor: Colors.white.withOpacity(0.2),
                        child: Container(
                      width:80,
                      height:80 ,
                      padding: EdgeInsets.only(top:10,right: 4,left: 4,bottom: 4),
                      decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),

                    )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child:  Shimmer.fromColors(
                        baseColor: Colors.white70.withOpacity(0.1),
                        highlightColor: Colors.white.withOpacity(0.2),
                        child:Text("....",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.elMessiri(
                          fontSize:  Constants.screenAwareSize(12, context),
                          //   fontWeight: FontWeight.bold,
                          // backgroundColor: ,
                          color: Theme.of(context).accentColor

                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

