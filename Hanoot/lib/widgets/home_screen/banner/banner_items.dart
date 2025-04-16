import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
class BannerItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height:260,
        // width: double.infinity,
        width: MediaQuery.of(context).size.width,
        child:InkWell(
          onTap: () {
         //   Navigator.of(context).pushNamed("/category");
          },
          child:  Carousel(
            boxFit: BoxFit.fill      ,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 2000),
            dotSize: 3.0,
            dotIncreasedColor:Theme.of(context).accentColor,
            dotBgColor: Colors.transparent,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            showIndicator: true,
            borderRadius: false,
            indicatorBgPadding: 7.0,
            images: [
             ExactAssetImage("assets/icons/banner1.png"),
             ExactAssetImage("assets/icons/banner2.png"),

            ],
          ),
        ),
      );
  }
}