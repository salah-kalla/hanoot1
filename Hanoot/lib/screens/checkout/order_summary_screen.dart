import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSummeryScreen extends StatefulWidget {
  Function onBack, Checkout ;
  CartState cartState ;
  OrderSummeryScreen({this.onBack,this.cartState,this.Checkout});
  @override
  _OrderSummeryScreenState createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 600));
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
    return WillPopScope(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context,child)=>
            Transform(
              transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(8.0),
                      child: widget.cartState.paymentLoading?
                      Container():
                      Text("تحديد طريقة الدفع",textAlign: TextAlign.start,style: GoogleFonts.elMessiri(fontSize: 18),),
                    ),
                    widget.cartState.paymentLoading?
                    Center(child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 20,),
                        Text("يرجى الإنتظار قليلا",textAlign: TextAlign.start,style: GoogleFonts.elMessiri(fontSize: 12),),

                      ],
                    ),)
                        :ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.cartState.paymentMethodList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_,index){
                        final item = widget.cartState.paymentMethodList[index];
                        return ListTile(
                         // isThreeLine: true,
                          leading: widget.cartState.paymentMethod ==item?
                          Icon(Icons.radio_button_checked,color: Theme.of(context).accentColor,)
                              : Icon(Icons.radio_button_unchecked),
                          title: Text("${item.title}",
                            style: GoogleFonts.elMessiri(color:widget.cartState.paymentMethod==item?
                          Theme.of(context).accentColor:
                          Theme.of(context).textTheme.title.color
                          ),
                          ),
                        //  subtitle: Text("${item.title}"),
                          trailing: (item.title=="تداول")?
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/tadwel.png")):
                          (item.title=="الدفع بواسطة بطاقة معاملات")?
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/Moamalat.png")):
                          (item.title=="سداد")?
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/sdad.jpg")) :
                          (item.title=="الدفع نقدًا عند الإستلام")?
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/buy.png"))
                          :
                          (item.title=="خدمة يوني")?
                          Container(
                              height: 40,
                              width: 30,
                              child: Image.asset("assets/Miza.png"))
                          :Icon(Icons.payment)
                          ,
                          onTap: (){
                            widget.cartState.setPaymentMethod(item);
                          },
                        );

                      },

                    ),
                    SizedBox(height: 10,),
                    Divider(color: Colors.grey,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("سعر المنتجات",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold),),
                        Text("${widget.cartState.totalCartAmount.toString()} "+"د،لـ"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("سعر الشحن",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold)),
                        Text("${widget.cartState.shippingMethodItem.cost.toString()} "+"د،لـ"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("المجموع",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold)),
                        Text("${widget.cartState.shippingMethodItem.cost+widget.cartState.totalCartAmount} "+"د،لـ"),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("عنوان الشحن",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold)),
                        if(widget.cartState.address!=null||widget.cartState.address.city.isNotEmpty)
                        Text("${widget.cartState.address.city}"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("رقم الهاتف ",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold)),
                        if(widget.cartState.address!=null||widget.cartState.address.phoneNumber.isNotEmpty)
                          Text("${widget.cartState.address.phoneNumber}"),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Divider(color: Colors.grey,),
                    SizedBox(height: 15,),
                    Row(children: [
                      Expanded(
                        child: Material(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(50),
                          elevation: 4,
                          child: FlatButton(
                            onPressed: () {
                              widget.onBack();
                            },
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("رجوع",style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: RoundedLoadingButton(
                          child: Text("الشراء الآن ",
                              style: GoogleFonts.elMessiri(fontSize: 12,color: Colors.white)),
                          controller: _btnController,
                          onPressed: _doSomething,
                          color: Theme.of(context).accentColor,

                        ),
                      ),
                    ]),

                  ],
                ),

              ),
            )
        ,
      ),
    );
  }
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  void _doSomething() async {
    Timer(Duration(seconds: 5), () {
      _btnController.success();
    });
    widget.Checkout();

  }
}
