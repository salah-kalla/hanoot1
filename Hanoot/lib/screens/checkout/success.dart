import 'package:flutter/material.dart';
import 'package:Hanoot/models/order.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class Success extends StatefulWidget {
  Order order ;
  Success({this.order});

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> with TickerProviderStateMixin{
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
      onWillPop: () async => false,
      child:AnimatedBuilder(
          animation: animationController,
          builder: (context,child)=>
              Scaffold(
                  body: SafeArea(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right:8,left: 8,top: 10,bottom: 20),

                          child: SingleChildScrollView(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Shimmer.fromColors(
                                      baseColor: Theme.of(context).accentColor.withOpacity(0.6),
                                      highlightColor: Theme.of(context).accentColor,
                                      child: Container(
                                        width: 100,
                                        height:100,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                          //   border: Border.all(color: Colors.white)

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("assets/icons/tick.png",color: Theme.of(context).accentColor),
                                        ),
                                      ),
                                    ),
                                    Shimmer.fromColors(
                                        baseColor: Theme.of(context).accentColor.withOpacity(0.7),
                                        highlightColor: Theme.of(context).accentColor,
                                        child: Text("الطلب مكتمل  ",style: GoogleFonts.elMessiri(fontSize: 20,color:Theme.of(context).accentColor),))
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[

                                        Transform(
                                          transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("رقم الطلب",style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold)),
                                              Text("${widget.order.id}#",style: GoogleFonts.elMessiri(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Transform(
                                          transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("حالة الطلب ",style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold)),
                                              Text("جاري الإنتظار",style: GoogleFonts.elMessiri(fontSize: 12,color: Theme.of(context).accentColor)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Transform(
                                          transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("المجموع الكلي",style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold)),
                                              Text("${widget.order.total} "+"د،لـ"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),

                                 Card(
                                   child: Padding(padding: EdgeInsets.all(8.0)
                                   ,child: Column(
                                       children: <Widget>[
                                         Transform(
                                           transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                                           child: Container(
                                             color: Theme.of(context).accentColor,
                                             padding: EdgeInsets.all(8),
                                             width: double.infinity,
                                             child: Text("عنوان الشحن",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold),),
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         Transform(
                                           transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget>[
                                               Text("الأسم ",style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold)),
                                               Text("${widget.order.billing.firstName} ${widget.order.billing.lastName}",style: GoogleFonts.elMessiri(fontSize: 12)),
                                             ],
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         Transform(
                                           transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget>[
                                               Text("العنوان ",style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold)),
                                               Text("${widget.order.billing.city} ",style: GoogleFonts.elMessiri(fontSize: 12,color: Theme.of(context).accentColor)),
                                             ],
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         Transform(
                                           transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget>[
                                               Text("رقم الهاتف ",style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold)),
                                               Text("${widget.order.billing.phoneNumber}# "),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),

                                 ),
                                SizedBox(height: 10,),

                                 Card(
                                   child: Padding(
                                     padding: EdgeInsets.all(8.0),
                                     child: Column(
                                       children: <Widget>[
                                         Transform(
                                           transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                                           child: Container(
                                             color: Theme.of(context).accentColor,
                                             padding: EdgeInsets.all(8),
                                             width: double.infinity,
                                             child: Text("طريقة الدفع ",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold),),
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         Transform(
                                           transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget>[

                                               Text(" ${widget.order.paymentMethodTitle} ",style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold)),
                                               (widget.order.paymentMethodTitle=="تداول")?
                                               Container(
                                                   height: 20,
                                                   width: 20,
                                                   child: Image.asset("assets/tadwel.png")):
                                               (widget.order.paymentMethodTitle=="الدفع بواسطة بطاقة معاملات")?
                                               Container(
                                                   height: 20,
                                                   width: 20,
                                                   child: Image.asset("assets/Moamalat.png")):
                                               (widget.order.paymentMethodTitle=="سداد")?
                                               Container(
                                                   height: 20,
                                                   width: 20,
                                                   child: Image.asset("assets/sdad.jpg")) :
                                               (widget.order.paymentMethodTitle=="الدفع نقدًا عند الإستلام")?
                                               Container(
                                                   height: 20,
                                                   width: 20,
                                                   child: Image.asset("assets/buy.png"))
                                                   :(widget.order.paymentMethodTitle=="خدمة يوني")?
                                               Container(
                                                   height: 20,
                                                   width: 20,
                                                   child: Image.asset("assets/Miza.png"))
                                                   :Icon(Icons.payment,color: Theme.of(context).accentColor)
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                                SizedBox(height: 20,),
                                SizedBox(height: 5,),
                                Center(
                                  child: Material(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 4,
                                    child: FlatButton(
                                      onPressed: (){

                                        Provider.of<AppState>(context,listen: false).setScreenIndex(0);
                                        Navigator.of(context).pop();
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
                                              Text("الرجوع للتسوق",style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                              SizedBox(width: 15,),
                                              Icon(Icons.shopping_cart,color: Colors.white,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
      )
    );
  }
}
