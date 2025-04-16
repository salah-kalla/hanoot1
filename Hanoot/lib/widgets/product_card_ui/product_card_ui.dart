import 'package:extended_image/extended_image.dart';
import 'package:Hanoot/models/products.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/product_card_ui/add_to_card_ui.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardUI extends StatefulWidget {
  final  Function onPressed ;
  final Product product ;
  final double margin ;
  ProductCardUI({this.product,this.margin=0,@required this.onPressed});
  @override
  _ProductCardUIState createState() => _ProductCardUIState();
}

class _ProductCardUIState extends State<ProductCardUI> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1300));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (context,child)=>InkWell(
          onTap:widget.onPressed,
          child: Transform(
            transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gradient: LinearGradient(colors: [Colors.transparent,Constants.lightBG.withOpacity(.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter

                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height ,
                margin:EdgeInsets.all(3) ,
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
                              // height:MediaQuery.of(context).size.height ,
                              margin: EdgeInsets.all(widget.margin),
                              decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ExtendedNetworkImageProvider(
                                        widget.product.imageFeature!=null?widget.product.imageFeature:"https://images.unsplash.com/photo-1587613757703-eea60bd69e66?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=975&q=80",
                                        cache: true,
                                      )
                                  )
                              ),
                            ),
                            ((widget.product.onSale??false)&&widget.product.regularPrice.isNotEmpty)?
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
                                ),
                                child: Text("${(100-double.parse(widget.product.price)/double.parse(widget.product.regularPrice.toString())*100).toInt()} %",

                                  style: GoogleFonts.elMessiri(fontSize: 9,fontWeight: FontWeight.w600,color: Colors.white),
                                ),
                              ),
                            ):Container(),

                          ],
                        ),
                      ),
                    ),
                    //  SizedBox(height: Constants.screenAwareSize(2, context),),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10,),

                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${widget.product.name}",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.elMessiri(
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
                                    rating: widget.product.averageRating??0.0,
                                    size: Constants.screenAwareSize(8, context),
                                    color: Colors.amberAccent,
                                    borderColor: Colors.amber,
                                    spacing: 0.0,


                                  ),
                                ),
                                SizedBox(width: 1,),
                                Text(widget.product.ratingCount==0?" (0) ":" (${widget.product.ratingCount}) ",textAlign:TextAlign.right,style: GoogleFonts.elMessiri(fontSize: Constants.screenAwareSize(8, context), color:  Colors.amber,),),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  alignment:Alignment.centerRight,
                                  child: Text(" ${widget.product.price} "+"د،لـ",style: GoogleFonts.elMessiri(
                                    fontSize: Constants.screenAwareSize(10, context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                            ),
                            Spacer(),
                            AddCartUI(product: widget.product,)

                          ],
                        )),
                    //  SizedBox(height: Constants.screenAwareSize(2, context),),

                    //  SizedBox(height: Constants.screenAwareSize(2, context),),

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
