import 'package:flutter/material.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Badge extends StatelessWidget {
  final String count ;
  final IconData iconData ;
  final TextStyle style ;
  final Color countBackgroundColor ;
    Badge({this.style,this.iconData,this.count,this.countBackgroundColor});

  @override
  Widget build(BuildContext context) {
    final lenght = Provider.of<CartState>(context).wishListProducts.length ;
    ThemeData themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Stack(
          children: <Widget>[
            Icon(iconData,
              size: Constants.screenAwareSize(20, context),
              color: themeData.iconTheme.color.withOpacity(.8),
            ),
            Positioned(
                bottom: 5,
                right: 0,
                child: Container(
              padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lenght>0?countBackgroundColor??Colors.redAccent.withOpacity(.7):Colors.transparent
                  ),
                  child: Text("${lenght>0?lenght: ""}",
                    style: style??
                        GoogleFonts.elMessiri(color: Colors.white),
                  ),

            ),
            )
          ],
        ),
      ),

    );
  }
}
