
import 'package:flutter/material.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/CartItem.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class OrderReviews extends StatelessWidget{
  final Function onButtonClicked ;
  OrderReviews({this.onButtonClicked});
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CartState>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text("Total items ${state.cartProducts.length}",
              style: GoogleFonts.elMessiri(fontWeight: FontWeight.w300),),
            padding: EdgeInsets.symmetric(horizontal: 17,vertical: 2),
            
          ),
            buildCartListView(state),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildCouponView(context,state),
                Padding(padding: const EdgeInsets.only(top: 18.0),
                child: ListTile(
                  leading: Text("SUB TOTAL"),
                  trailing: Text("..."),
                ),
                  
                ),
                RawMaterialButton(onPressed: onButtonClicked,
                fillColor: Theme.of(context).accentColor,
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: 45
                  ),
                  elevation: 0,
                  child: Text("PLACE ORDER",style: GoogleFonts.elMessiri(color: Colors.white),),
                  
                )
              ],
            ),
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
        itemBuilder: (context,index){
      final item = state.cartProducts[index];
      Product testProduct = state.cartProducts[index].product;
//      ProductVariation testProductVariation =
//          state.cartProducts[index].productVartiation;
      int quantity = state.cartProducts[index].quantity ;
      return  CartItem(
        product: testProduct,
//        productVariation: testProductVariation,
        quantity: quantity,
        onPrimaryButtonPressed: (){
       //   state.addProductToWishList(item);
        },
        onRemovePressed: (){
        //  state.removeProductAndAddToCart(item);
        },
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>DetailProducts(product:testProduct),fullscreenDialog: true
          ));

        },
      );
    });
    
  }
  Container buildCouponView(BuildContext context, CartState state){
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
              focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none, 
              enabledBorder: InputBorder.none, 
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              
            ),
          ),
          flex: 2,
          ),
          Expanded(child: FlatButton.icon(onPressed: (){}, icon: Icon(Icons.local_offer), label: Text("Apply")))
        ],
      ),
    );
  }
}
