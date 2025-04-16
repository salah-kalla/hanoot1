import 'package:flutter/material.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/states/wishlist_state.dart';
import 'package:Hanoot/widgets/card_wishlist.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class WishListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<WishListState>(context);
    final theme = Theme.of(context);

    return Scaffold(


      appBar: AppBar(


        centerTitle: true,
        title: Text("قائمة رغباتي"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[

          SliverList(delegate: SliverChildListDelegate([
            state.wishListCartProducts.length>0?
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.wishListCartProducts.length,
                  itemBuilder: (context,index){
                    final item = state.wishListCartProducts[index];
                    final product = item ;
//                    final variation = item.productVariation;
                    return CardWishList(
                      product: product,
//                      productVariation: variation,
                      primaryTitle: "Move to cart",
                      onRemovePressed: (){
                        state.removeProductFromWishList(item);
                      //  state.removeProductAndAddToCart(item);
                      },
                      onPrimaryButtonPressed: (){
                        state.removeProductAndAddToCart(item);
                        Provider.of<CartState>(context,listen: false).addProductToCart(product, null, 1,true);
                      },

                    );
                  },
                ):
                buildEmptyView(theme,context)
          ]))
        ],
      ),
    );
  }
  Widget buildEmptyView (ThemeData theme, BuildContext context){
   return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top:150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Theme.of(context).accentColor.withOpacity(0.8),
              highlightColor:Theme.of(context).accentColor,
              child: Container(width: 100,height: 100,
                margin: EdgeInsets.only(bottom: 20),
                child:
              Image.asset("assets/icons/bag1.png",color: Theme.of(context).accentColor,),),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("لا يوجد لديك منتجات في قائمة الرغبات خاصتك ",style: GoogleFonts.elMessiri(fontSize: 18),textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width-50,

                child: Material(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 4,
                  child: FlatButton(
               onPressed: (){

               Navigator.of(context).pop();
               Provider.of<AppState>(context,listen: false).setScreenIndex(0);

           //   Navigator.of(context).pushNamed(homeRouter);
               },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor:Colors.white.withOpacity(0.7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("تسوق الآن",style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                           SizedBox(width: 15,),
                            Icon(Icons.shopping_cart,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            )

          ],
        ),
      ),
    );

  }

}
