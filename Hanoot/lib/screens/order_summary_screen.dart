import 'package:flutter/material.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CartState>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Order placed",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor,fontSize: 40),),
          SizedBox(height: 40,),
          RawMaterialButton(onPressed: (){
            state.clearCart();
            Navigator.pop(context);
          },
          fillColor: Theme.of(context).accentColor,
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,minHeight: 45
            ),
            elevation: 0,
            child: Text("Continue Shopping ",style: GoogleFonts.elMessiri(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
