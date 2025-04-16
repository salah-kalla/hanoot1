import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBanner extends StatelessWidget {
  final Categories _category;
  final Function _onPressed ;
  CategoryBanner(this._category,this._onPressed);


  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height)/4.5;

    return InkWell(
      onTap: _onPressed,
      child: Stack(
        children: <Widget>[
          Container(
            height: Constants.screenAwareSize(height, context),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),

              image: DecorationImage(image: ExtendedNetworkImageProvider(_category.name,cache: true),
              fit: BoxFit.cover
              ),
               ),
          ),
          Container(
            height: Constants.screenAwareSize(height, context),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent,Colors.black54],
              begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
    Container(
    height: Constants.screenAwareSize(height, context),
    margin: EdgeInsets.all(4),
    child: Center(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: Text(_category.name,
        style: GoogleFonts.elMessiri(
          fontSize: Constants.screenAwareSize(40, context),
        //  fontFamily:
          color: Colors.white,
        ),
        ),
      ),
    ),
    )
        ],
      ),
    );
  }
}
