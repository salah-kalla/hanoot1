import 'dart:async';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:Hanoot/models/products.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:provider/provider.dart';
class AddCart extends StatefulWidget {
  final Product product ;
  final DetailState state ;
  const AddCart({Key key, this.product,this.state}) : super(key: key);

  @override
  _AddCartListState createState() => _AddCartListState();
}

class _AddCartListState extends State<AddCart> with SingleTickerProviderStateMixin{
  Animation filp_animation ;
  AnimationController animationController;
  final intList = [1,2,3,4,5,6,7,8,9,10,11,
    12,13,14,15,16,
    17,18,19,20];
  int quantity =1;
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
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child:  InkWell(
                  onTap: (){
                    setState(() {
                      animationController.repeat();
                    });
                    widget.state.addToCart(context,widget.product,quantity);
                  },
                  child: Padding(padding: EdgeInsets.only(right: 15),
                    child:  Text("اضافة للسلة",style: GoogleFonts.elMessiri(color:
                    Colors.grey,fontWeight:  FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child:  Padding(padding: EdgeInsets.only(right: 2,),
                  child:  Container(
                    margin: EdgeInsets.all(10),
                   // padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              width: 15,
                              height: 20,
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
                                    setState(() {
                                      quantity+=1;
                                    });
                                    },
                                    child: Icon(Icons.add,size: 12,),
                                  ),
                                ),
                              ),
                            ),),
                        Expanded(
                            flex: 3,
                            child: Text("${quantity}",textAlign:TextAlign.center,style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 12),)),
                        Expanded(
                            flex: 2,
                            child:Container(
                              width: 15,
                              height: 20,
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
                                      setState(() {
                                        if(quantity>1){
                                          quantity-=1;
                                        }else{

                                        }
                                      });
                                    },
                                    child: Icon(Icons.remove,size: 12,),
                                  ),
                                ),
                              ),
                            ),),

                      ],
                    ),
                  ),
                ),
              ),


//                Expanded(child:  Padding(padding: EdgeInsets.only(right: 10),
//                      child: Icon(Icons.add_shopping_cart,
//                        color:Colors.grey,size: 18,),
//                    ),
//              flex:2,)
            ],
          )
      );



    }else{
      Timer(Duration(milliseconds: 500), () async{
    //    animationController.duration = Duration(milliseconds: 1);
      //  if(animationController.isCompleted){
          //animationController.reset();
          await animationController.forward().orCancel;


      });
     // animationController.stop();
      return AnimatedBuilder(
          animation: animationController,
          builder: (context,child){
        return Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: InkWell(
            onTap: (){
              setState(() {
              });
                widget.state.removeFromCart(context,item,widget.product);

            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child:  Transform(
                      transform: Matrix4.identity()..rotateX(2*pi*filp_animation.value),
                      child:Padding(padding: EdgeInsets.only(right: 15),
                      child:  Text("تمت الإضافة للسلة",style: GoogleFonts.elMessiri(color:
                      Theme.of(context).accentColor,fontWeight:  FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
                      )),
                ),

                Expanded(child: Transform(
                  transform: Matrix4.identity()..rotateX(2*pi*filp_animation.value),
                  child: Padding(padding: EdgeInsets.only(left: 10,right: 10),
                  child: Icon(Icons.check_circle,
                    color:Theme.of(context).accentColor,size: 22,),
                  )
                ),flex: 1,)
              ],
            ),
          )
        );
          });


    }
  }
}
