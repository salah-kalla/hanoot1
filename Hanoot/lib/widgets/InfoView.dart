
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoView extends StatelessWidget {
  final String primaryText,secondaryText,path;
  final Color iconColor;

  InfoView({this.path,this.iconColor,this.primaryText,this.secondaryText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(padding:const EdgeInsets.all(50.0),
        child: SvgPicture.asset(path,
        height: MediaQuery.of(context).size.height/4,
          color: iconColor,
        ),
        ),
        Padding(padding:  const EdgeInsets.all(18.0),
        child: Text(primaryText,
        textAlign: TextAlign.center,
          style: GoogleFonts.elMessiri(fontSize: 35,
          fontWeight: FontWeight.w200
          ),
        ),


    ),

      ],

    );
  }
}
