import 'package:flutter/material.dart';
import 'package:Hanoot/models/order.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatefulWidget {
  Function onPressed ;
  Order order ;
  OrderCard({this.order,this.onPressed});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
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
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (context,child)=>InkWell(
      onTap: (){
        widget.onPressed();
      },
      child: Transform(
        transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
        child: ClipRRect(
        //  borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            Text("رقم الطلب",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold,fontSize: 12),),
                            SizedBox(width: 5,),
                            Text("${widget.order.id}#",style: GoogleFonts.elMessiri(fontSize: 15),),

                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[

                            Text("حالة الطلب",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold,fontSize: 12,),),
                            SizedBox(width:5,),

                            Text("${widget.order.status==Processing?"قيد التنفيذ":widget.order.status==OnHold?"قيد الانتظار":widget.order.status==Completed?"مكتمل":widget.order.status==Refunded?"راجع":widget.order.status==Pending?"في اننظار الدفع":widget.order.status==Cancelled?"ملغي":""}",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold,fontSize: 15,color: Theme.of(context).accentColor),),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.mode_edit,color: Theme.of(context).accentColor,size: 17,),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
const String Pending = "pending";
const String OnHold = "on-hold";
const String Processing = "processing";
const String Completed = "completed";
const String Cancelled = "cancelled";
const String Refunded = "refunded";