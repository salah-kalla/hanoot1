import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CartCard extends StatelessWidget {
  final Function onTap,onRemovePressed,onPrimaryButtonPressed,ClearItem,RemoveQuantity,AddQuantity;
  final String primaryTitle ;
  final Product product ;
  final ProductVariation productVariation ;
  final int quantity ;
  //final WishListBool = true ;
  CartCard({this.productVariation,this.product,this.quantity,
    this.onPrimaryButtonPressed,this.onRemovePressed,this.onTap,this.primaryTitle, this.ClearItem,this.RemoveQuantity,this.AddQuantity
  });
  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context);
    return Stack(
      children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(padding: EdgeInsets.only(top:12.0,left: 10.0,bottom: 4.0,right: 4.0),
          child: Material(
            elevation: 4,
            color: appState.isDark?null:Colors.white ,
            borderRadius: BorderRadius.circular(5.0),

            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width-20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                // padding: EdgeInsets.only(left: 5,right: 5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child:Container(
                          padding: EdgeInsets.only(right:8.0,bottom: 8.0,top: 4.0),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  ExtendedImage.network(product.imageFeature,
                            cache: true,
                            fit:BoxFit.fill,


                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(top: 2,right: 8.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(product.name,    softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.elMessiri(fontSize: 14,color: Colors.grey),),
                              ),
                          //    SizedBox(height:2,),
                              Expanded(
                                flex: 1,
                                child: Text("${productVariation==null? product.price:productVariation.price} "
                                    ""+"د،لـ",
                                  style: GoogleFonts.elMessiri(fontSize: 15,color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold
                                  ),),
                              ),
                           //   SizedBox(height:5,),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 25,
                                      height: 25,
                                      child: Material(
                                        color: Theme.of(context).accentColor ,
                                        borderRadius: BorderRadius.circular(5),
                                        elevation: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: FlatButton(
                                              padding: EdgeInsets.only(left: 0.01),
                                              onPressed: (){
                                                RemoveQuantity();
                                              },
                                              child: Icon(Icons.remove,size: 12,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2,),
                                    Container(
                                        width: 35,
                                        child: Center(child: Text("${quantity}",style: GoogleFonts.elMessiri(color: Colors.grey)))),


                                    Container(
                                      width: 25,
                                      height: 25,
                                      child: Material(
                                        color: Theme.of(context).accentColor ,
                                        borderRadius: BorderRadius.circular(5),
                                        elevation: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),

                                          ),
                                          child: FlatButton(
                                            padding: EdgeInsets.only(left: 0.01),

                                            onPressed: (){
                                              AddQuantity();
                                            },
                                            child: Icon(Icons.add,size: 12,),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("x${quantity.toString()}",style: GoogleFonts.elMessiri(color: Colors.grey,fontSize: 10),),
                                ],
                              )
                            ),
                          ),
                        ),),
                    ],
                  ),
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
              ClearItem();
            },
            child: Padding(
              padding: const EdgeInsets.only(left:0.0),
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
    );
  }
}
