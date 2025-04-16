import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/order.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/order_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetails extends StatefulWidget {

  Order order ;
  OrderDetails({this.order});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> with SingleTickerProviderStateMixin,AfterLayoutMixin {
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  Services services = Services();
  bool noteLoading = true;
  List<OrderNote> orderNotes =[] ;
 // Services services = Services();
  void CancelOrder()async{
    try{
      await services.updateOrder(widget.order.id,status: "cancelled").then((value) {
        setState(() {
          widget.order= value;
        });
        Provider.of<OrderState>(context,listen: false).getMyOrders(userState: Provider.of<UserState>(context,listen: false));
      });
    }catch(e){

    }
  }
  void getNotes()async{
    try{
      setState(() {
        noteLoading = true;
      });
      orderNotes =  await services.getNotes(orderId: widget.order.id);
      setState(() {
        noteLoading = false;
      });
    }catch(e){
      setState(() {
        noteLoading = false;
      });
    }
  }
  String formatTime(DateTime time) {
    return "${time.day}/${time.month}/${time.year}";
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getNotes();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final OrderState orderState = Provider.of<o(context);
    final AppState appState = Provider.of<AppState>(context);
    Provider.of<OrderState>(context,listen: false).getMyOrders(userState: Provider.of<UserState>(context,listen: false));

    return    Consumer<OrderState>(
        builder: (context, orderState, child){
      return WillPopScope(
        onWillPop: () async => true,
        child: AnimatedBuilder(animation:animationController, builder: (context,child){
          return Scaffold(
              backgroundColor:appState.isDark?null: Colors.white,
              appBar: AppBar(
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                title:Text(" تفاصيل الطلب${" "+widget.order.id.toString()}# ",style: GoogleFonts.elMessiri(color: Colors.white),),
              ),
              body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[

                      Container(
                        width: double.infinity,
                        height: 70,
                        child: Material(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)),
                          elevation: 4,
                          color: Theme.of(context).accentColor,

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Column(
                          children: <Widget>[
                            //  OrderCard(order: widget.order,onPressed: null,),
                            Transform(transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Material(
                                  color:appState.isDark?null: Colors.white,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Column(
                                    children: <Widget>[

                                      Center(
                                        child: Container(height: 1,width: MediaQuery.of(context).size.width-250,
                                          color: Theme.of(context).accentColor.withOpacity(0.2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("رقم الطلب",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 7,),
                                            Text("${widget.order.id}#", style: GoogleFonts.elMessiri(color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("حالة الطلب",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 10,),
                                            Text("${widget.order.status==Processing?"قيد التنفيذ":widget.order.status==Refunded?"تم الارجاع":widget.order.status==Cancelled?"ملغي":widget.order.status==Completed?"مكنمل":widget.order.status==Pending?"في انتظار الدفع":widget.order.status==OnHold?"قيد الإنتظار":widget.order.status==Failed?"فشل":""}",
                                              style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),

                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("القيمة الاجمالية",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 10,),
                                            Text("${widget.order.total} د،ل ",
                                              style: GoogleFonts.elMessiri(color:  Colors.grey),

                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("طريقة الدفع",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 10,),
                                            Text("${widget.order.paymentMethodTitle}",
                                              style: GoogleFonts.elMessiri(color: Colors.grey),

                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("تاريغ الطلب",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 10,),
                                            Text(formatTime(DateTime.parse(
                                                widget.order.createdAt.toString())),
                                              style: GoogleFonts.elMessiri(color: Colors.grey),

                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                            Transform(transform: Matrix4.translationValues(afterAnimation.value * width, 0.0, 0.0),                              child: Container(
                                padding: EdgeInsets.only(top: 8,right: 20,left: 20),
                                child: Material(
                                  color:appState.isDark?null: Colors.white,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:Text("تفاصيل العنوان",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),),

                                        ),
                                      ),
                                      Center(
                                        child: Container(height: 1,width: MediaQuery.of(context).size.width-250,
                                          color: Theme.of(context).accentColor.withOpacity(0.2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("الآسم",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 7,),
                                            Text("${widget.order.billing.firstName+" "+widget.order.billing.lastName}", style: GoogleFonts.elMessiri(color:  Colors.grey)),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("المدينة",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 10,),
                                            Text("${widget.order.billing.city} ",
                                              style: GoogleFonts.elMessiri(color:  Colors.grey),

                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("رقم الهاتف",style: GoogleFonts.elMessiri(fontSize: 12,fontWeight: FontWeight.w600),),
                                            SizedBox(width: 10,),
                                            Text("${widget.order.billing.phoneNumber}#",
                                              style: GoogleFonts.elMessiri(color: Colors.grey),

                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                            //  Text("${widget.order.status==Processing? "معالجة":'ملغي' }",style: GoogleFonts.elMessiri(fontSize: 16,color:widget.order.status=="processing"? Colors.green:Colors.red),),
                            Transform(transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),                              child: Container(
                                padding: EdgeInsets.only(top: 8,right: 20,left: 20),
                                child: Material(
                                  color:appState.isDark?null: Colors.white,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:Text("حالة الطلب",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),),

                                        ),
                                      ),
                                      Center(
                                        child: Container(height: 1,width: MediaQuery.of(context).size.width-250,
                                          color: Theme.of(context).accentColor.withOpacity(0.2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: orderStepper(context: context),
                                      )
                                    ],
                                  ),
                                ),

                              ),
                            ),
                            Transform(transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),                              child: Container(
                              padding: EdgeInsets.only(top: 8,right: 8,left: 8),
                              child: Material(
                                color:appState.isDark?null: Colors.white,
                                elevation: 0,
                                borderRadius: BorderRadius.circular(5),
                                child: Column(
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(8),
                                      child: Center(
                                        child:Text("ملاحظات",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),),

                                      ),
                                    ),
                                    Center(
                                      child: Container(height: 1,width: MediaQuery.of(context).size.width-250,
                                        color: Theme.of(context).accentColor.withOpacity(0.2),
                                      ),
                                    ),
                                    noteLoading?Container(
                                      height: 150,
                                      child: Center(

                                        child: Container(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator()),
                                      ),
                                    ):(orderNotes.isNotEmpty)?
                                    Container(
                                      height: 200,
                                      child: ListView.separated(
                                        itemCount:orderNotes!=null? orderNotes.length:0,
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Divider();
                                        },
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(left: 80,right: 5,top: 10),
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft:Radius.circular(5),bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5)
                                              ),
                                              color: Theme.of(context).accentColor
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("${orderNotes[index].note}"),
                                                Row(
                                                  crossAxisAlignment:CrossAxisAlignment.end,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("${DateFormat('E MM/dd - H:mm ').format(DateTime.parse(orderNotes[index].formattedDate)) }",style: GoogleFonts.elMessiri(fontSize: 10),),
                                                    Icon(Icons.done_all,size: 10,)
                                                  ],
                                                )

                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ):
                                        Container(
                                          height: 100,
                                          child: Center(
                                            child: Text("لا يوجد ملاحظات"),
                                          ),
                                        )
                                  ],
                                ),
                              ),

                            ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
          );
        }),
      ); });
    }
    //cancelled
   //processing
  //completed
  /*
      (S.of(context).status=="pending payment")?"في انتظار الدفع":
    (S.of(context).status=="On-hold")?"في الانتظار":
    (S.of(context).status=="Processing")?"معالجة":
    (S.of(context).status=="Completed")?"مكتمل":
   */
    Widget orderStepper({  BuildContext context}){
     return Container(
       child: Column(
         children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: Column(    mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,

                   children: <Widget>[
                    // Text("قيد الإنتظار",style: GoogleFonts.elMessiri(fontSize: 18),),
                     SizedBox(height: 5,),
                     Container(
                       height: 30,
                       width: 30,
                       child: Material(
                         borderRadius: BorderRadius.circular(50),
                         elevation: 4,
                         color: widget.order.status==Cancelled? Colors.blueGrey:widget.order.status==Processing?Theme.of(context).accentColor:widget.order.status==OnHold?Theme.of(context).accentColor:widget.order.status==Completed?Theme.of(context).accentColor:Colors.blueGrey,
                         child: Icon(Icons.hourglass_empty,color: Colors.white,size: 20),
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                 height: 3,
                 width: 40,
                 color: widget.order.status==Cancelled||widget.order.status==Failed? Colors.blueGrey:widget.order.status==Processing?Theme.of(context).accentColor:widget.order.status==OnHold?Colors.blueGrey:widget.order.status==Completed?Theme.of(context).accentColor:Colors.blueGrey,
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(    mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,

                   children: <Widget>[
                     //Text("قيد التنفيذ",style: GoogleFonts.elMessiri(fontSize: 18),),
                     SizedBox(height: 5,),
                     Container(
                       height: 30,
                       width: 30,
                       child: Material(
                         borderRadius: BorderRadius.circular(50),
                         elevation: 4,
                         color: widget.order.status==Cancelled||widget.order.status==Failed? Colors.blueGrey:widget.order.status==Processing?Theme.of(context).accentColor:widget.order.status==OnHold?Colors.blueGrey:widget.order.status==Completed?Theme.of(context).accentColor:Colors.blueGrey,
                         child: Icon(Icons.timelapse,color: Colors.white,size: 20,),
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                 height: 3,
                 width: 40,
                 color: widget.order.status==Cancelled||widget.order.status==Failed? Colors.blueGrey:widget.order.status==Processing?Colors.blueGrey:widget.order.status==OnHold||widget.order.status==Pending?Colors.blueGrey:widget.order.status==Completed?Theme.of(context).accentColor:Colors.blueGrey,
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(    mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,

                   children: <Widget>[
                    // Text("مكتمل",style: GoogleFonts.elMessiri(fontSize: 18),),
                     SizedBox(height: 5,),
                     Container(
                       height: 30,
                       width: 30,
                       child: Material(
                         borderRadius: BorderRadius.circular(50),
                         elevation: 4,
                         color: widget.order.status==Processing||widget.order.status==Cancelled||widget.order.status==OnHold||widget.order.status==Refunded||widget.order.status==Pending||widget.order.status==Failed? Colors.blueGrey:Theme.of(context).accentColor,
                         child: Icon(Icons.sentiment_very_satisfied,color: Colors.white,size: 20),
                       ),
                     ),
                   ],
                 ),
               ),
//           Container(
//             height: 30,
//             width: 3,
//             color: Theme.of(context).accentColor,
//           ),



             ],
           ),
           widget.order.status!=Completed&&widget.order.status!=Refunded&&widget.order.status!=Cancelled&&widget.order.status!=Failed?
           Container(
             height: 40,
             width: 100,
             margin: EdgeInsets.only(top: 20),
             child: Material(
               elevation: 3,
               borderRadius: BorderRadius.circular(10),
               color: widget.order.status!=Completed&&widget.order.status!=Cancelled&&widget.order.status!=Refunded?Colors.red:Colors.blueGrey,
               child: InkWell(
                 onTap: (){
                   widget.order.status==Processing||widget.order.status==Pending||widget.order.status==OnHold? CancelOrder():null ;

                 },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Text("الغاء",style:GoogleFonts.elMessiri(fontSize: 16,color: Colors.white) ,)
                   ],
                 ),
               ),
             ),
           ):
           widget.order.status==Refunded||widget.order.status==Cancelled||widget.order.status==Failed?
           Container(
             height: 40,
             width: 100,
             margin: EdgeInsets.only(top: 15),
             child: Material(
               elevation: 3,
               borderRadius: BorderRadius.circular(10),
               color:Colors.blueGrey,
               child: InkWell(
                 onTap: (){

                 },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Text("الطلب ملغي",style:GoogleFonts.elMessiri(fontSize: 16,color: Colors.white) ,)
                   ],
                 ),
               ),
             ),
           ):Container(),



         ],
       )


     );
    }

}

   const String Pending = "pending";
   const String Failed = "failed";
   const String OnHold = "on-hold";
   const String Processing = "processing";
  const String Completed = "completed";
  const String Cancelled = "cancelled";
  const String Refunded = "refunded";


