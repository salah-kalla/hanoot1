import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/screens/wishlist_screen.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/CartItem.dart';
import 'package:Hanoot/widgets/InfoView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartState state = Provider.of<CartState>(context);
    final UserState Userstate = Provider.of<UserState>(context);

    return SafeArea(child: CustomScrollView(
      slivers: <Widget>[
        SliverList(delegate: SliverChildListDelegate([
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child:Text("Cart",style: GoogleFonts.elMessiri(
                  fontWeight: FontWeight.bold,
                  fontSize: 40
                ),) ,flex: 4,),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                    WishListScreen(),fullscreenDialog: true
                    ));
                  },
                  child:Badge(
                      elevation:0,
                      showBadge: true,
                      badgeContent: Text("${2}",
                        style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),
                      ),
                      badgeColor: Colors.redAccent.withOpacity(0.8),
                      animationType: BadgeAnimationType.scale,
                      child: Icon(Icons.favorite,color: Colors.redAccent,)
                  )
                ),

              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 17,vertical: 8),
          ),
          state.cartProducts.length>0
          ?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
//                    child: Text("مجموع العناصر ${state.totalCartAmount.toString()}",
                    child: Text("مجموع العناصر ${state.cartProducts.length}",

                      style: GoogleFonts.elMessiri(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 17,vertical: 2),
                  ),
                  Spacer(),
                  FlatButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17,vertical: 2),
                      child: Text(
                        'افراغ السلة',
                        style: GoogleFonts.elMessiri(
                            color: Theme.of(context).accentColor,
                           ),
                      ),
                    ),
                    onPressed: () {
                   state.clearCart();

                    },
                  ),
                ],
              ),
              buildCartListView(state),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async{
                try{
                  await Services()
                      .CreateNewOrder(cartState:state , userState: Userstate, poid: true);
                }catch(e){
                }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: Constants.screenAwareSize(40, context),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        decoration: BoxDecoration(color: Theme.of(context).accentColor),
                        child: Center(
                          child: Text("CHECKOUT ${state.totalCartAmount.toString()} LYD",style: GoogleFonts.elMessiri(color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ):
              buildEmptyCartView(context,state)
        ]))
      ],

    ));
  }
  Container buildCouponView(BuildContext context,CartState state){
    return Container(
      height: Constants.screenAwareSize(35, context),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[600])),
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(child: TextField(
            onChanged: (value){

            },
            onSubmitted: (value){
              state.setcouponCode(value);
            },
            decoration: InputDecoration(
              hintText: "Coupon Code",
              hintStyle: GoogleFonts.elMessiri(
                color: Theme.of(context).textTheme.subhead.color
              ),
              focusedErrorBorder: InputBorder.none,
              focusedBorder:  InputBorder.none,
              disabledBorder:  InputBorder.none,
              enabledBorder:  InputBorder.none,
              errorBorder:  InputBorder.none,
            ),
          ),flex: 2,

          ),
          Expanded(child: FlatButton.icon(onPressed: (){

          }, icon: Icon(Icons.local_offer), label: Text("Apply")),
          )
        ],
      ),
    );
  }
  ListView buildCartListView(CartState state){
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.cartProducts.length,
        itemBuilder: (context, index){
      final item = state.cartProducts[index];
          final product = item.product;
          final variation = item.productVariation;
          final quantity = item.quantity;
          return CartItem(
            productVariation: variation,
            product: product,
            quantity: quantity,
            ClearItem: (){
              state.removeFromCartforProduct(item);
            },
            onPrimaryButtonPressed: (){
             // state.addProductToWishList(item);
            },
            onRemovePressed: (){
              state.removeFromCartforProduct(item);
            },
            RemoveQuantity:(){
              state.removeQuantityProductInCart(item);
            },
            AddQuantity: (){
              state.addQuantityProductInCart(item);
            },
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailProducts(product:product),fullscreenDialog: true));
            },
          );

    });
  }
  Column buildEmptyCartView(BuildContext context, CartState state){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InfoView(
          iconColor: Theme.of(context).iconTheme.color.withOpacity(.9),
          path: "assets/shopping_cart.png",
          primaryText: "يبدو أنك لم تتخذ قرارك بعد!",
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
        child: FlatButton(
    color: Theme.of(context).accentColor,
    onPressed: (){
          Provider.of<AppState>(context).navigateToHome();
    }, child: Text(
    " تسوق الآن",
    style: GoogleFonts.elMessiri(color: Colors.white,),

    ),)
        ),
   ( state.wishListProducts.length>0)?
     Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
     child: FlatButton(onPressed: (){
       Navigator.of(context).push(MaterialPageRoute(builder: (_)=>WishListScreen(),
       fullscreenDialog: true,
       ));
     }, child: Text("قائمة الرغبات",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),)),
     ):Container(),

      ],
    );
  }

  Future<void> createOrder({paid = false, cod = false,BuildContext context}) async {
    final CartState state = Provider.of<CartState>(context);
    final UserState Userstate = Provider.of<UserState>(context);
    try {
      final order = await Services()
          .CreateNewOrder(cartState:state , userState: Userstate, poid: paid);

    } catch (err) {

    }
  }

}
