import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Constants {
  static final CONSUMER_KEY_CLOUD =
      "ck_b19bbe57f070ca8b000bc06fba24636417f1858c";
      // "ck_b79f9a087aea9cb0b7d45775b6d6ae0ccced01c4";
  static final CONSUMER_SECRET_CLOUD =
      "cs_fbe73d89b033398cfe7775cdf7aabf3f7f6a4ca9";
      // "cs_dc230139665386e47d75d3f0bd423e4be27f532a";
  static final URL_CLOUD = "https://hanoot.ly";
  static final APP_FOLDER = "COOL_STORE";
  static final kLocalkey = {
    "userInfo":"userInfo",
    "shippingAddress":"shippingAddress",
    "recentSearches":"recentSearches",
    "wishlist":"wishlist",
    "home":"home",
    "isDarkTheme":"isDarkTheme",
    "productsInCart":"productsInCart",
    "cartproducts":"products",
    "productsVariationsInCart":"productsVariationsInCart",
  };
  static Color lightPrimary = Color(0xff1E1E1E);
  static Color darkPrimary = Color(0xFFf4c404);
  static Color lightAccent = Color(0xFFf4c404);
  static Color darkAccent = Color(0xFFf4c404);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG  = Color(0xff1E1E1E);

  static String searchBarTag = "searchbartag";
  static String searchSubtitleTag= "searchSubtitleTag";
  static String searchIconTag = "searchIconTag";
  static double baseHeight = 640 ;

  static double screenAwareSize(double size, BuildContext context){
    return size*MediaQuery.of(context).size.height/baseHeight ;
  }
   static ThemeData lighTheme = ThemeData(
   //  backgroundColor: lightAccent,
     hintColor:darkBG ,
   backgroundColor: lightBG,
     primaryColor: lightPrimary,
     accentColor: lightAccent,
     cursorColor: lightAccent,
     scaffoldBackgroundColor: lightBG,
     appBarTheme: AppBarTheme(
       color: lightBG,
       elevation: 0,
       iconTheme: IconThemeData(

       ),
       textTheme: TextTheme(

         title: GoogleFonts.elMessiri(
           color: darkBG,
           fontSize: 18.0,
           fontWeight: FontWeight.w800,
         ),
       ),
     ),
   );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: lightAccent,
    hintColor:darkAccent ,
   // hintColor:darkBG ,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      color: darkBG,
      elevation: 0,
      textTheme: TextTheme(
        title: GoogleFonts.elMessiri(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
