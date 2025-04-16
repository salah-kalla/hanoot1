import 'package:flutter/material.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingMethodScreen extends StatefulWidget {
  Function onNext,onBack ;
  CartState cartState ;

  ShippingMethodScreen({this.cartState,this.onNext,this.onBack});
  @override
  _ShippingMethodScreenState createState() => _ShippingMethodScreenState();
}

class _ShippingMethodScreenState extends State<ShippingMethodScreen> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  bool state = false ;
  bool freeState = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 600));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
    var shippingclass= widget.cartState.cartProducts.firstWhere((element) => element.product.shippingClass=="heavyship", orElse: () => null);
    //    if shipping Class == heavyship even one time so make freeState it is false and make state it is true
    if(shippingclass!=null){
      setState(() {
        state = true;
        freeState = false;

      });
    }
    //    if shipping Class == free-ship even one time so make freeState it is true
    var freeShippingclass= widget.cartState.cartProducts.firstWhere((element) => element.product.shippingClass=="free-ship", orElse: () => null);
      if(freeShippingclass!=null){
        setState(() {
          freeState = true;
        });
      }
    widget.cartState.cartProducts.forEach((element) {

  //    if shipping Class is empty even one time so make freeState it is false
     if(element.product.shippingClass.isEmpty){
       setState(() {
         freeState =false ;
       });
     }
     //    if shipping Class == heavyship even one time so make freeState it is false and make state it is true
     if(element.product.shippingClass=="heavyship"){
        setState(() {
          state = true;
          freeState =false ;
        });
      }
    });  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final CartState state = Provider.of<CartState>(context).getShippingMethod(address: widget.address,token: widget.token);
    //state.getShippingMethod(address: widget.address,token: widget.token);
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child)=>
          SingleChildScrollView(
            child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               SizedBox(height: 100),
                Padding(padding: const EdgeInsets.all(2.0),
                  child: widget.cartState.shippingLoading?

                  Container():
                  Text("تحديد طريقة الشحن",textAlign: TextAlign.start,style: GoogleFonts.elMessiri(fontSize: 20),),
                ),
                SizedBox(height: 10,),

                widget.cartState.shippingLoading?
                Center(child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20,),
                    Text("يرجى الإنتظار قليلا",textAlign: TextAlign.start,style: GoogleFonts.elMessiri(fontSize: 15),),

                  ],
                ),)
                    :ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.cartState.shippingMethodList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_,index){
                    final item = widget.cartState.shippingMethodList[index];
                    if(state&&freeState==false){
                      // if freeShipping is not true and  any another Class Shipping == heavyship it is ok
                      widget.cartState.shippingMethodList[index].cost=double.parse(item.classCost);
                    }else if(freeState==true){
                      // if freeShipping is visible and no any another Class Shipping or any default coast so it is ok
                      widget.cartState.shippingMethodList[index].cost=0.0;
                    }
                    return ListTile(
                   //   isThreeLine: true,
                      leading: widget.cartState.shippingMethodItem ==item?
                      Icon(Icons.radio_button_checked,color: Theme.of(context).accentColor,)
                          : Icon(Icons.radio_button_unchecked),
                      title: Text("${item.title}",style: GoogleFonts.elMessiri(color:widget.cartState.shippingMethodItem==item?
                      Theme.of(context).accentColor:
                      Theme.of(context).textTheme.title.color
                      ),
                      ),
                      trailing: Text("${(state)?item.classCost.toString():item.cost.toString()}"+" د،لـ "),
                      onTap: (){

                        widget.cartState.setShippingMethod(item,method: state);
                      },
                    );

                  },

                ),
                SizedBox(height: 100,),

                Transform(
                  transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                  child: Row(children: [
                    Expanded(
                      child: Material(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
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
                      child: Material(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 4,
                        child: FlatButton(
                          onPressed: () async{

                            if(widget.cartState.shippingLoading){

                            }else{
                              widget.onNext();

                            }
                          },
                          child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("متابعة",style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                                Icon(Icons.chevron_right,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
    );
  }
}
