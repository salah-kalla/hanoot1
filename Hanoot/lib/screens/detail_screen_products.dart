import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:badges/badges.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:Hanoot/widgets/ProductCard.dart';
import 'package:Hanoot/widgets/product/GalleryView.dart';
import 'package:Hanoot/widgets/product/ProductDescription.dart';
import 'package:Hanoot/widgets/product/ProductTitle.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_product.dart';
import 'package:Hanoot/widgets/product/VariationsView.dart';
import 'package:Hanoot/widgets/product/add_cart.dart';
import 'package:Hanoot/widgets/product/heart_wishlist.dart';
import 'package:Hanoot/widgets/product/share_product.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class DetailProducts extends StatefulWidget {
  Product product ;
   bool fromHome  ;
  DetailProducts({this.product,this.fromHome});
  @override
  _DetailProductsState createState() => _DetailProductsState();
}

class _DetailProductsState extends State<DetailProducts> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
 int photoIndex = 0 ;
  bool iswishlist = false ;
 void _nextDoth(){
   setState(() {
     photoIndex = photoIndex<widget.product.images.length-1?photoIndex+1:0 ;
   });
 }
 void _backDoth(){
   setState(() {

     photoIndex = photoIndex>0?photoIndex-1:0 ;
   });
 }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }
 @override
  void setState(fn) {
   for(var i in widget.product.images){
     print(i.toString());
   }
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(animation: animationController, builder: (context,child){
      return  ChangeNotifierProvider(
        create: (_)=>DetailState(widget.product.id),
        child:  Scaffold(

          body:CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 375,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                //  title: Text("data"),
                  stretchModes: [
                    StretchMode.blurBackground,
                  //  StretchMode.fadeTitle,
                    StretchMode.zoomBackground
                  ],
                  background:  Stack(
                    children: <Widget>[
                      Hero(
                        tag: "1",
                        child: Container(
                       //   height: 400,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:  ExtendedNetworkImageProvider(
                                widget.product.images[photoIndex]??"data:image/jpeg;base64,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",
                                cache: true,

                              ),

                            ),

                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                        height: 375,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,

                        ),
                        onTap: (){
                          _nextDoth();

                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: 375,
                          width: MediaQuery.of(context).size.width/2,
                          color: Colors.transparent,
                        ),
                        onTap: (){
                          _backDoth();
                        },
                      ),
                    SafeArea(child: Padding(padding: EdgeInsets.only(left: 15,right: 10,top: 15)
                      ,child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                              Transform(
//                                transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
//                                child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
//                                  Navigator.of(context).pop();
//                                }),
//                              ),
//                              Spacer(),
                          Consumer<CartState>(builder: (context,stateCart,child){
                            return InkWell(
                              onTap: (){
                                   Navigator.of(context).pop();
                                if(widget.fromHome!=null){
                                  if(!widget.fromHome)
                                  Navigator.of(context).pop();
                                }else{
                                      Navigator.of(context).pop();
                                   }
                                Provider.of<AppState>(context,listen: false).setScreenIndex(3);

                                   //  Navigator.of(context).pop();
                              },
                              child: Transform.scale(
                                scale: 1,
                                child:
                                Badge(
                                    elevation: 0,
                                    position: BadgePosition.topStart(top: 0,start: 0),
                                    padding: EdgeInsetsDirectional.only(start: 4,end: 4,),
                                    showBadge: stateCart.cartProducts.length!=0||stateCart.cartProducts!=null,
                                    badgeContent: Text("${stateCart.cartProducts.length}",
                                      style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 8),
                                    ),
                                    badgeColor: Colors.redAccent.withOpacity(0.8),
                                    animationType: BadgeAnimationType.scale,
                                    child: Shimmer.fromColors(
                                        baseColor:Theme.of(context).accentColor.withOpacity(0.8), highlightColor: Theme.of(context).accentColor,
                                        child: Icon(Icons.shopping_cart,color: Theme.of(context).primaryColor,))),
                              ),
                            );

                          },),

                        ],
                      ),
                    ),),
                      Transform(
                        transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),

                        child: Container(
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.bottomLeft,
                            // margin: EdgeInsets.only(left: 10),
                            child: IconButton(icon: Icon(Icons.zoom_out_map,color: Colors.grey,), onPressed: (){
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryView(product: widget.product,)));

                              });

                            })),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),

                        child: Container(
                          height: 400,
                          margin: EdgeInsets.only(right: 10.0),
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.bottomRight,
                          // margin: EdgeInsets.only(left: 10),
                          child: HeartWishList(product: widget.product,),),
                      ),
                      Positioned(
                          top: 375,
                          left: MediaQuery.of(context).size.width/2-20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SelectedPhoto(indexofDots: widget.product.images.length,
                                  photoIndex: photoIndex,context:context),

                            ],
                          )),

                    ],
                  ),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate([
                Stack(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                    //  margin: EdgeInsets.only(top: 390),
                      decoration: BoxDecoration(
                        //   color:Colors.white,

                          borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))
                      ),
                      child:  Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                        child: Column(
                          children: <Widget>[
                            Transform(
                              transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                              child: ProductTitle(widget.product),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                              child: Column(
                                children: <Widget>[
                                  if(widget.product.attribute!=null)
                                    VariationsView(widget.product),
                                  ProductDescription(widget.product),
                                ],
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text("قد يعجبك ايضا",style: GoogleFonts.elMessiri(fontSize: 17),),
                                  ),
                                  Consumer<DetailState>(builder: (context,state,child){
                                    return Container(
                                        height: MediaQuery.of(context).size.height/2.7,
                                        child: state.isRelatedProductsLoading?ShimmerProduct(horizontal: true,):Container(
                                          height: 250,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.relatedProducts.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context,index){
                                              return Container(
                                                width: 170,
                                                child: ProductDisplayCard(onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailProducts(product:state.relatedProducts[index])));
                                                },
                                                  product: state.relatedProducts[index],
                                                  margin: 0,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                    );
                                  })
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ]))
            ],
          )
//          ListView(
//            shrinkWrap: true,
//            children: <Widget>[
//
//            ],
//          ),
//            floatingActionButton: Consumer<DetailState>(builder: (context,state,child){
////              return FloatingActionButton(onPressed: (){
////                try{
////                  state.addToCart(context);
////                  _showSnackbar(context,"تمت الإضافة الى السلة");
////                }catch(e){
////                  _showSnackbar(context,e.toString());
////
////                }
////              },
////                child: Icon(Icons.add_shopping_cart),
////              );
//            return Container(                margin: EdgeInsets.all(8),
//
//              child: Material(
//                elevation: 7,
//                borderRadius: BorderRadius.circular(20),
//                child: Container(
//                  height: 50,
//                  width: MediaQuery.of(context).size.width,
//                  child: Row(
//                          children: <Widget>[
//                            Expanded(
//                              flex: 4,
//                              child: Consumer<DetailState>(builder: (context,state,child){
//                                return Container(
//                                  height: MediaQuery.of(context).size.height,
//                                  width: MediaQuery.of(context).size.width,
//                                  child: FlatButton.icon(onPressed: (){
////                                  try{
//                  //                  Provider.of<CartState>(context,listen: false).addProductToCart(widget.product, null, 1,true);
//
//
////                                  }catch(e){
////                                    _showSnackbar(context,e.toString());
////
////                                  }
//                                  },
//                                    textColor: Colors.white,
//                                    color: Theme.of(context).accentColor,
//                                    icon: Icon(Icons.add_shopping_cart,color: Colors.white,),
//                                    label: Text("اضافة إلى السلة ",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold),),
//                                  ),
//                                );
//                              }),
//                            ),
//                            Expanded(child: Container(
//                                height: MediaQuery.of(context).size.height,
//                                width: MediaQuery.of(context).size.width,
//                                child: QuantityChooser()))
//                          ],
//                        ),
//                ),
//              ),
//            );
//            }),
//          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

, floatingActionButton:   Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Transform(
        transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),

        child: Consumer<DetailState>(builder: (context,state,child){
        return   Container(
            height: 45,
            width: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            margin: EdgeInsets.only(top: 2,right: 20),
            child:AddCart(product: widget.product,state: state,)
        );
      }),
      ),
      Transform(
          transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),

          child:Container(
        height: 60,
        width: 65,
        child: ShareProduct(product: widget.product,),
      ))
    ],
  ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      );
    });



  }
 _showSnackbar(BuildContext context, String text){
   Scaffold.of(context).showSnackBar(SnackBar(content: Text(text),duration: Duration(seconds: 1),));
 }
}
class SelectedPhoto extends StatelessWidget {
  final indexofDots ;
  final photoIndex ;
 final BuildContext context ;
  const SelectedPhoto({Key key, this.indexofDots, this.photoIndex, this.context}) : super(key: key);
  Widget _unactiveDots(){
    return Container(
      child: Padding(padding: EdgeInsets.only(left: 3.0,right: 3.0),
        child: Container(
          height: 5,
          width: 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
  Widget _activeDots(){
    return Container(
      child: Padding(padding: EdgeInsets.only(left: 3.0,right: 3.0),
        child: Container(
          height: 5,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:Theme.of(context).accentColor,
              boxShadow: [
                BoxShadow(
                  color:Theme.of(context).accentColor,
                  blurRadius: 2.0,
                  spreadRadius: 0,
                )
              ]
          ),

        ),
      ),
    );
  }

  List<Widget> bulidDots(){
    List<Widget> dots  = [];
    for(var index = 0;  index<indexofDots;++index){
      dots.add(index==photoIndex?_activeDots():_unactiveDots());
    }
    return dots ;
  }


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: bulidDots(),
      ),
    );
  }
}

