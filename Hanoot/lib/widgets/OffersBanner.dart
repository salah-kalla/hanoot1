import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
class OffersBanner extends StatelessWidget {
  final imageList=[
    "https://images.unsplash.com/photo-1592842232655-e5d345cbc2d0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80",
    "https://images.unsplash.com/photo-1524861497943-aa659205b2c8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1519759282350-1ef2048aaa46?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=997&q=80",
    "https://images.unsplash.com/photo-1524862655266-89c67a10c4b3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      autoPlay: true,
      pauseAutoPlayOnTouch: Duration(seconds: 1),
      viewportFraction: 0.9,
      aspectRatio: 1,
      enlargeCenterPage: true,

      items:imageList.map((url){
        return Builder(builder: (BuildContext  context){
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 0.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: ExtendedNetworkImageProvider(url,cache: true),

              )
            ),
          );
        });
      }).toList() ,

    );
  }
}
