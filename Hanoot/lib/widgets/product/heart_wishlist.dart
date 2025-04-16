import 'dart:async';
import 'dart:math';

import 'package:Hanoot/models/products.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/states/wishlist_state.dart';
import 'package:provider/provider.dart';
class HeartWishList extends StatefulWidget {
  final Product product ;

  const HeartWishList({Key key, this.product}) : super(key: key);

  @override
  _HeartWishListState createState() => _HeartWishListState();
}

class _HeartWishListState extends State<HeartWishList> with SingleTickerProviderStateMixin{
Animation filp_animation ;
AnimationController animationController;
@override
void initState() {
  // TODO: implement initState
  super.initState();
  animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
  filp_animation = Tween(begin: 0.9,end: 1.0).animate(CurvedAnimation(parent: animationController,
      curve: Interval(0.0, 0.5,curve: Curves.linear)));
}
@override
void dispose() {
  // TODO: implement dispose
  animationController.dispose();
  super.dispose();

}
  @override
  Widget build(BuildContext context) {
    final WishListState stateWishlist = Provider.of<WishListState>(context,listen: false);
    var inList= stateWishlist.wishListCartProducts.firstWhere((element) => element.id==widget.product.id, orElse: () => null);
    if(inList ==null){
      return IconButton(
        onPressed: () {
          Provider.of<WishListState>(context,listen: false).addProductToWishList(widget.product);
          setState(() {

          });
        },
        icon: Material(
         // color:Colors.white,

          elevation: 4,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.favorite_border,
               color: Colors.grey,),
          ),
        )
      );
    }
    else{
      Timer(Duration(milliseconds: 500), () async{
        await animationController.forward().orCancel;
      });
    return  AnimatedBuilder(animation: animationController,
          builder: (context,child){
            return IconButton(
                onPressed: () {
                  stateWishlist.removeProductFromWishList(widget.product);
                  setState(() {
                    animationController.repeat();
                  });
                },
                icon: Material(
            //      color:Colors.white,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Transform(
                      transform: Matrix4.identity()..rotateX(2*pi*filp_animation.value),
                      child: Icon(Icons.favorite,
                          color:Colors.red),
                    ),
                  ),
                )
            );
          });
    }
  }
}
