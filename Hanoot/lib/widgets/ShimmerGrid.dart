import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerGrid extends StatelessWidget {
  int time = 600;
  int offset= 50 ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        childAspectRatio: 6,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (context,pos){
          return Shimmer.fromColors(child: ShimmerLayout(),

              baseColor: Colors.grey[300], highlightColor: Colors.white,
          period: Duration(milliseconds: time),
          );
        }));
  }
}
class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Container(
            color: Colors.grey,
          )),
          Container(
            margin: EdgeInsets.only(top: 4,right: 40,bottom: 4,left: 4),
            height: 10,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(top: 4,right: 80,bottom: 4,left: 4),
            height: 10,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

