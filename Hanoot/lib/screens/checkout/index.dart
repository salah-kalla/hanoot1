import 'package:flutter/material.dart';
import 'package:Hanoot/models/order.dart';
import 'package:Hanoot/screens/checkout/cart_screen.dart';
import 'package:Hanoot/screens/checkout/order_summary_screen.dart';
import 'package:Hanoot/screens/checkout/shipping_address.dart';
import 'package:Hanoot/screens/checkout/shipping_method.dart';
import 'package:Hanoot/screens/checkout/success.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexCartScreen extends StatefulWidget {
  @override
  _IndexCartScreenState createState() => _IndexCartScreenState();
}

class _IndexCartScreenState extends State<IndexCartScreen> {
    int currentstep = 0 ;
  PageController _controller = PageController(
    initialPage: 0,
  );
  bool complet = false ;
  bool shipping = false ;
  next(){
    currentstep+1 != 4?
        goTo(currentstep+1)
        :  setState(() {
      complet = true ;
    });
  }
  goTo(int step){
    setState(() {
      currentstep = step ;
    });
  }
  cancel(){
    if(currentstep > 0){
      goTo(currentstep -1);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final CartState cartState = Provider.of<CartState>(context);
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        actions: <Widget>[
          if(currentstep==0)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 Stack(
                   alignment: Alignment.center,
                   children: <Widget>[

                     Align(
                         alignment: Alignment.center,
                         child: Container(height:5 ,
                           decoration: BoxDecoration(
                               color: Colors.white,

                               border: Border.all(color: Theme.of(context).accentColor,width: 1)
                               ,borderRadius: BorderRadius.all(Radius.circular(10))

                           ),
                       width:MediaQuery.of(context).size.width-120,)),
                     Align(
                       alignment: Alignment.center,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           Container(
                               height: 35,
                               width: 35,
                               decoration: BoxDecoration(
                                   color:Theme.of(context).accentColor,
                                   borderRadius: BorderRadius.all(Radius.circular(20)

                                   ),
                                 border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)
                               ),
                               child: Icon(Icons.shopping_cart,color: Colors.white,size: 20,)),
                           SizedBox(width: 20,),

                           Container(
                               height: 25,
                               width: 25,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(20)),
                                   border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                               ),
                               child: Icon(Icons.location_on,color:Colors.grey,size: 12,)),
                           SizedBox(width: 20,),
                           Container(
                               height: 25,
                               width: 25,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(20)),
                                   border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                               ),
                               child: Icon(Icons.local_shipping,color: Colors.grey,size: 12,)),
                           SizedBox(width: 20,),
                           Container(
                               height: 25,
                               width: 25,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(20)),
                                   border: Border.all(color: Colors.grey.withOpacity(0.4),width: 1)

                               ),
                               child: Icon(Icons.payment,color: Colors.grey,size: 12,)),
                           SizedBox(width: 20,),
                           Container(
                               height: 25,
                               width: 25,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(20)),
                                   border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                               ),
                               child: Icon(Icons.done,color: Colors.grey,size: 12,)),
                           SizedBox(width: 20,),
                         ],
                       ),
                     ),
                   ],
                 )
                ],
              ),
            ),
          if(currentstep==1)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Align(
                          alignment: Alignment.center,
                          child: Container(height:5 ,
                            decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(color: Theme.of(context).accentColor,width: 1)
                                ,borderRadius: BorderRadius.all(Radius.circular(10))

                            ),
                            width:MediaQuery.of(context).size.width-120,)),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)

                                    ),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)
                                ),
                                child: Icon(Icons.shopping_cart,color: Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color:Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width:2)

                                ),
                                child: Icon(Icons.location_on,color: Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                                ),
                                child: Icon(Icons.local_shipping,color: Colors.grey,size: 12,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                                ),
                                child: Icon(Icons.payment,color: Colors.grey,size: 12,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                                ),
                                child: Icon(Icons.done,color:Colors.grey,size: 12,)),
                            SizedBox(width: 20,),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          if(currentstep==2)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Align(
                          alignment: Alignment.center,
                          child: Container(height:5 ,
                            decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(color: Theme.of(context).accentColor,width: 1)
                                ,borderRadius: BorderRadius.all(Radius.circular(10))

                            ),
                            width:MediaQuery.of(context).size.width-120,)),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)

                                    ),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)
                                ),
                                child: Icon(Icons.shopping_cart,color:Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width:2)

                                ),
                                child: Icon(Icons.location_on,color: Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color:Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)

                                ),
                                child: Icon(Icons.local_shipping,color:Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                                ),
                                child: Icon(Icons.payment,color:Colors.grey,size: 12,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                                ),
                                child: Icon(Icons.done,color:Colors.grey,size: 12,)),
                            SizedBox(width: 20,),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          if(currentstep==3)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Align(
                          alignment: Alignment.center,
                          child: Container(height:5 ,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Theme.of(context).accentColor,width: 1)
                                ,borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            width:MediaQuery.of(context).size.width-120,)),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)

                                    ),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)
                                ),
                                child: Icon(Icons.shopping_cart,color:Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width:2)

                                ),
                                child: Icon(Icons.location_on,color: Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)

                                ),
                                child: Icon(Icons.local_shipping,color: Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)

                                ),
                                child: Icon(Icons.payment,color:Colors.white,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color:Colors.grey.withOpacity(0.4),width: 1)

                                ),
                                child: Icon(Icons.done,color: Colors.grey,size: 12,)),
                            SizedBox(width: 20,),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          if(currentstep==4)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Align(
                          alignment: Alignment.center,
                          child: Container(height:5 ,
                            decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(color: Theme.of(context).accentColor,width: 1)
                            ),
                            width:MediaQuery.of(context).size.width-120,)),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)

                                    ),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)
                                ),
                                child: Icon(Icons.shopping_cart,color: Theme.of(context).accentColor,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width:2)

                                ),
                                child: Icon(Icons.location_on,color: Theme.of(context).accentColor,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)

                                ),
                                child: Icon(Icons.local_shipping,color: Theme.of(context).accentColor,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)

                                ),
                                child: Icon(Icons.payment,color: Theme.of(context).accentColor,size: 20,)),
                            SizedBox(width: 20,),
                            Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.4),width: 2)

                                ),
                                child: Icon(Icons.done_all,color: Theme.of(context).accentColor,size: 20,)),
                            SizedBox(width: 20,),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
      body:
      stepper(userState,cartState,context),
    );
  }
  Widget stepper(UserState userState,CartState cartState,BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
//       physics: ScrollPhysics(),
//        controller: _controller,
//        onPageChanged: goTo,
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// For Cart #1
         if(currentstep==0)
          Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CartScreen(cartState: cartState,onPressed:()=> next(),userState: userState,),
        ),
          /// For Address #2
            if(currentstep==1)

              ShippingAddress(cartState: cartState,userState: userState,onNext: ()=>next(),onBack: ()=>cancel(),),
          /// For Shipping #3
            if(currentstep==2)

              ShippingMethodScreen(cartState: cartState,onNext: ()=>next(),onBack: ()=>cancel(),),

          ///For Summary  Order ond Checkout #4
    if(currentstep==3)

    OrderSummeryScreen(cartState: cartState,onBack: ()=>cancel(),Checkout: (){
                createOrder(cartState: cartState,userState: userState,context: context);
              },)



          ],

        // onStepTapped: (step)=>goTo(step),
        ),
      ),
      
    );
  }

  //////
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


  Future<void> createOrder({paid = true, cod = false,BuildContext context,CartState cartState,UserState userState}) async {
//
    try {

      Provider.of<CartState>(context,listen: false).CreateNewOrder(cartState: cartState,userState: userState,paid: true,success: ()async{
        Provider.of<CartState>(context,listen: false).clearCart();
        final LocalStorage storage = LocalStorage('into_order');
        try{
          // save the order Info as local storage
          final ready = await storage.ready;
          if (ready) {
            var  items = await storage.getItem('orders');
            Order order = Order.fromJson(items);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Success(order: order)),
            );

          }
        }catch(e){

        }

      },
      fail: (){
        
      }
      );
    } catch (err) {
      final snackBar = SnackBar(
        content: Text(err.toString()),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

////////
}
