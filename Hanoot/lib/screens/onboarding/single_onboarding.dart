import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleOnBoarding extends StatelessWidget {
  final OnBoardingModel boardingModel ;
  SingleOnBoarding(this.boardingModel);
  //ScreenConfig screenConfig ;
 // WidthSize widthSize ;
  @override
  Widget build(BuildContext context) {
  //  screenConfig = ScreenConfig(context);
  //  widthSize = WidthSize(screenConfig);
    return Column(
        children: <Widget>[
          SizedBox(height: 20,),
          SizedBox(

            width: MediaQuery.of(context).size.width*0.9,
            height:  MediaQuery.of(context).size.height*0.45,
            child: Image(
              image:
              ExactAssetImage(boardingModel.image),fit: BoxFit.fill),
          ),
          SizedBox(height: 0,),
          Text(boardingModel.title,textAlign: TextAlign.center,style: GoogleFonts.elMessiri(
            fontWeight: FontWeight.bold ,
            fontSize:18,
          ),),
          SizedBox(height: 24,),
          Text(boardingModel.description,textAlign: TextAlign.center,style: GoogleFonts.elMessiri(
            fontWeight: FontWeight.w400 ,
            fontSize: 18,
            color: Colors.blueGrey,


          ),),
        ]
    );
  }
}
