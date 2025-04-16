import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/products.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWishList extends StatefulWidget {
  final Function onTap,onRemovePressed,onPrimaryButtonPressed,ClearItem;
  final String primaryTitle ;
  final Product product ;
  final ProductVariation productVariation ;
  final int quantity ;
  CardWishList({this.productVariation,this.product,this.quantity,
    this.onPrimaryButtonPressed,this.onRemovePressed,this.onTap,this.primaryTitle, this.ClearItem,
  });
  @override
  _CardWishListState createState() => _CardWishListState();
}

class _CardWishListState extends State<CardWishList> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child)=>
        Stack(
          children: <Widget>[
            Container(
              child:  Padding(padding: EdgeInsets.only(right:10.0,left:15.0,top: 15,bottom: 5.0),
                child:  Transform(
                  transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(5.0),

                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width-20.0,
                      padding: EdgeInsets.only(left: 20,right: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only(right:5.0,left: 4,top: 2,bottom: 2),
                              margin: EdgeInsets.only(left: 10.0),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                              ),
                              child:  ExtendedImage.network(widget.product.imageFeature,
                                cache: true,
                                fit:BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(widget.product.name,    softWrap: false,
                                  overflow: TextOverflow.ellipsis,style: GoogleFonts.elMessiri(fontSize: 12,),),
                                SizedBox(height:5,),
                                Text("${widget.product.price} "+"د،لـ",style: GoogleFonts.elMessiri(fontSize: 14,color: Colors.grey),),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Align(
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: RawMaterialButton(onPressed: widget.onPrimaryButtonPressed,
                                            fillColor: Theme.of(context).accentColor,
//              child: Text("$primaryTitle"),
                                            child: Text("اضف للسلة"),
                                            elevation: 7,
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child:    InkWell(
                onTap: (){
                  widget.onRemovePressed();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left:2.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Card(
                      elevation: 2,
                      color: Theme.of(context).accentColor ,
                      child: Icon(Icons.clear,size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
