import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class ShimmerOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return  Container(
    margin: EdgeInsets.only(top: 20),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: 4,
        itemBuilder: (context,index){
          return  Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            Text("رقم الطلب",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold,fontSize: 12),),
                            SizedBox(width: 5,),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.8),
                              highlightColor:Colors.white,
                              child: Container(
                                height: 2,
                                width: 50,
                                color: Colors.grey,

                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[

                            Text("حالة الطلب",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold,fontSize: 12,),),
                            SizedBox(width:5,),

                            Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.8),
                              highlightColor:Colors.white,
                              child: Container(
                                height: 2,
                                width: 50,
                                color: Colors.grey,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Shimmer.fromColors(
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Theme.of(context).accentColor.withOpacity(0.2),
                          child: Icon(Icons.mode_edit,color: Theme.of(context).accentColor,size: 17,)),
                    ),
                  ),


                ],
              ),
            ),
          );
          },),
  );

  }
}
