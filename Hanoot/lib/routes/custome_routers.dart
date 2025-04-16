import 'package:flutter/material.dart';
import 'package:Hanoot/app.dart';
import 'package:Hanoot/main.dart';
import 'package:Hanoot/routes/name_routers.dart';
import 'package:Hanoot/screens/home_screen.dart';
import 'package:Hanoot/screens/myorders_screen.dart';
import 'package:Hanoot/screens/not_found_screen.dart';
import 'package:Hanoot/screens/setting_screen.dart';
import 'package:Hanoot/screens/user_login/login_email.dart';
import 'package:Hanoot/screens/user_login/login_sms.dart';
import 'package:Hanoot/screens/user_login/register.dart';
import 'package:Hanoot/screens/wishlist_screen.dart';
import 'package:Hanoot/widgets/menu_side_bar.dart';

class CustomRouter {
static Route<dynamic> allRoutes(RouteSettings settings){
  switch(settings.name){
    case homeRouter :
      return MaterialPageRoute(builder: (_)=>HomeScreen());
      break;
    case homeAppRouter :
      return MaterialPageRoute(builder: (_)=>App());
      break;
    case rehomeRouter :
      return MaterialPageRoute(builder: (_)=>MyApp());
      break;
    case settingRouter :
      return MaterialPageRoute(builder: (_)=>SettingsScreen());
      break;
    case ordersRouter :
      return MaterialPageRoute(builder: (_)=>MyOrders());
      break;
    case wishListRouter :
      return MaterialPageRoute(builder: (_)=>WishListScreen());
      break;
    case loginRouter :
      return MaterialPageRoute(builder: (_)=>UserLogin());
      break;
    case registerRouter :
      return MaterialPageRoute(builder: (_)=>UserRegister());
      break;
    case menuSideBarRouter :
      return MaterialPageRoute(builder: (_)=>MenuSideBar());
      break;
    case LoginSmsRouter :
      return MaterialPageRoute(builder: (_)=>LoginSms());
      break;
  }
  return MaterialPageRoute(builder: (_)=>NotFound());

}
}