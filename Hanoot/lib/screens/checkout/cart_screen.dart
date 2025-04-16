import 'package:flutter/material.dart';
import 'package:Hanoot/routes/name_routers.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/widgets/CardCart.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  CartState cartState ;
  UserState userState ;
  Function onPressed ;
  CartScreen({this.cartState,this.onPressed,this.userState});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              widget.cartState.cartProducts.length>0
                  ?Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).highlightColor,
                    padding: EdgeInsets.all(2.0),
                    margin: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                          child: Text("مجموع العناصر (${widget.cartState.cartProducts.length})",

                            style: GoogleFonts.elMessiri(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                        ),),
                        //   Spacer(),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                            child: Text(
                              'افراغ السلة',
                              style: GoogleFonts.elMessiri(
                                color: Colors.redAccent,
                                fontSize: 12
                              ),
                            ),
                          ),
                          onPressed: () {
                            widget.cartState.clearCart();
                          },
                        ),)
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height/2.4),
                      width: double.infinity,
                      child: SingleChildScrollView(child: buildCartListView(widget.cartState))),

                ],
              ):
              buildEmptyView(context),
            ],
          ),
        ) ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:    widget.cartState.cartProducts.length>0?   Container(
          margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height/4.7),
          height: 85,
          child: Container(
          //  elevation: 3,
            color: Theme.of(context).highlightColor,

            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(" الإجمالي :",style: GoogleFonts.elMessiri(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("${widget.cartState.totalCartAmount} "+"د،لـ",
                        style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),),

                    ],
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Material(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(0),
                    elevation: 2,
                    child: FlatButton(
                      onPressed: (){
                        if(widget.userState.loggedIn){
                           if(widget.cartState.totalCartAmount<=35.0){
                             showDialog(context: context,
                             builder: (context){
                               return AlertDialog(
                                 content: Text("الحد الأدني للشراء هو  35 د،ل",style: GoogleFonts.elMessiri(fontSize: 18),),
                                 actions: [
                                   FlatButton(onPressed: (){
                                     Navigator.of(context).pop();
                                   },
                                   child: Text("فهمت ذلك",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),),
                                   )
                                 ],
                               );
                             }
                             );
                           }else{
                             widget.onPressed();

                           }
                        }else{
                          Navigator.of(context).pushNamed(loginRouter);
                        }

                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        height: 30,
                        margin: EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("متابعة الشراء",
                              style: GoogleFonts.elMessiri(color: Color(0xff1E1E1E),fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            //  SizedBox(width: 15,),
                            Icon(Icons.chevron_right,color: Color(0xff1E1E1E),size: 25,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ):null,
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
          return CartCard(product: product,quantity: quantity,productVariation: variation,   ClearItem: (){
            state.removeFromCartforProduct(item);
          },  onRemovePressed: (){
          state.removeFromCartforProduct(item);
          },
                        RemoveQuantity:(){
              state.removeQuantityProductInCart(item);
            },
                        AddQuantity: (){
              state.addQuantityProductInCart(item);
            },
          );
        });
  }
  Widget buildEmptyView ( BuildContext context){
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
              child: Container(width: 120,height: 120,child:
              Image.asset("assets/icons/basket.png",color: Theme.of(context).accentColor,),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("يبدو أنك لم تتخذ قرارك بعد!",style: GoogleFonts.elMessiri(fontSize: 18),textAlign: TextAlign.center),
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
                   Provider.of<AppState>(context,listen: false).setScreenIndex(0);

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("تسوق الآن",style: GoogleFonts.elMessiri(color:Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(width: 15,),
                            Icon(Icons.shopping_cart,color:  Colors.black,)
                          ],
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
