import 'dart:async';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

import 'package:Hanoot/models/products.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:provider/provider.dart';
class AddCartUI extends StatefulWidget {
  final Product product ;
  const AddCartUI({Key key, this.product}) : super(key: key);

  @override
  _AddCartUIListState createState() => _AddCartUIListState();
}

class _AddCartUIListState extends State<AddCartUI> with SingleTickerProviderStateMixin{
  Animation filp_animation ;
  AnimationController animationController;
  var item ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 700));
    filp_animation = Tween(begin: 0.8,end: 1.0).animate(CurvedAnimation(parent: animationController,
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
    final CartState cartState = Provider.of<CartState>(context,listen: false);
    var inList= cartState.cartProducts.firstWhere((element) => element.product.id==widget.product.id, orElse: () => null);
    cartState.cartProducts.forEach((element) {
      if(element.product.id==widget.product.id){
        item = element ;
      }
    });
    if(inList ==null){
      return Container(
        height: 25,
        width: 80,
        margin: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),

          child: RawMaterialButton(onPressed:(){
            setState(() {
              animationController.repeat();
              cartState.addProductToCart(widget.product, null, 1, true);
            });
          },
            fillColor: Colors.white,
//              child: Text("$primaryTitle"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("اضف للسلة",style: GoogleFonts.elMessiri(fontSize: 10,color: Colors.grey),),
                SizedBox(width: 1,),
                Icon(Icons.add_shopping_cart,size: 10,color: Colors.grey,)
              ],
            ),
            elevation: 7,
          ),
        ),
      );
    }else{
      Timer(Duration(milliseconds: 500), () async{
        await animationController.forward().orCancel;


      });
      // animationController.stop();
      return AnimatedBuilder(
          animation: animationController,
          builder: (context,child){
            return Container(
                  height: 25,
                  width: 80,
                  margin: EdgeInsets.only(bottom: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RawMaterialButton(onPressed:(){
                      setState(() {
                        cartState.removeFromCartforProduct(item);
                      });
                    },
                      fillColor: Theme.of(context).accentColor,
//              child: Text("$primaryTitle"),
                      child: Transform(
                          transform: Matrix4.identity()..rotateX(2*pi*filp_animation.value),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("اضف للسلة",style: GoogleFonts.elMessiri(color:Colors.black,fontSize: 10),),
                              Icon(Icons.add_shopping_cart,color:Colors.black,size: 10,)
                            ],
                          )),
                      textStyle: GoogleFonts.elMessiri(color: Colors.white),
                      elevation: 7,
                    ),
                  ),
                )


            ;
          });


    }
  }
}
