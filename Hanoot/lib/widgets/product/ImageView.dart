import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/product/GalleryView.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class ImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);

    return GestureDetector(
      onTap: (){
        if(!state.isLoading)
          Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryView(product: state.product,)));

      },
      child: state.isLoading?Container(
        height: Constants.screenAwareSize(300, context),
        color: Colors.grey[300],
      ):CarouselSlider(

        items:state.product.images.map((url){
          return Builder(builder: (BuildContext context) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 17),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    offset: Offset(0, 10),
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(8)),
//              image: DecorationImage(
//                fit: BoxFit.cover,image: NetworkImage(url)

              ),
              child: ExtendedImage.network(url,
                cache: true,
                  fit: BoxFit.fill,
                loadStateChanged: (ExtendedImageState imagestate) {
                  switch (imagestate.extendedImageLoadState) {
                    case LoadState.loading:
                      return Shimmer(child: Center(child: Text("جاري تحميل..."),),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.white]));
                      break;
                    case LoadState.failed:
                      return GestureDetector(
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Icon(Icons.error),
                            Positioned(
                                left: 0.0,
                                bottom: 0.0,
                                right: 0.0,
                                child: Text(
                                  "فشل تحميل الصورة، حاول مرة اخري",
                                  textAlign: TextAlign.center,))
                          ],
                        ),
                        onTap: () {
                          imagestate.reLoadImage();
                        },
                      );
                      break;
                    case LoadState.completed:
                      break;
                  }
                },
              ),
            );
          },
          );
          }).toList()
        ,

    viewportFraction: 0.9,
    aspectRatio: 1,
    enlargeCenterPage: true,
    height: Constants.screenAwareSize(320, context),
      )
    );
  }
}
