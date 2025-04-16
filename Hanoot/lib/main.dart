import 'dart:async';
import 'dart:io';
import 'package:Hanoot/screens/CategoryListScreen.dart';
import 'package:Hanoot/screens/checkout/index.dart';
import 'package:Hanoot/screens/home_screen.dart';
import 'package:Hanoot/screens/search_screen.dart';
import 'package:Hanoot/screens/setting_screen.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/states/home_state.dart';
import 'package:Hanoot/states/homescreen/household_state.dart';
import 'package:Hanoot/states/homescreen/supermarket_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Hanoot/widgets/home_screen/Lists/household.dart';
import 'package:after_layout/after_layout.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/loclaztion/demp_loclaziton.dart';
import 'package:Hanoot/routes/custome_routers.dart';
import 'package:Hanoot/screens/cart_screen.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/screens/myorders_screen.dart';
import 'package:Hanoot/screens/onboarding/introduction_screen.dart';

import 'package:Hanoot/screens/wishlist_screen.dart';
import 'package:Hanoot/states/categories_state.dart';

import 'package:Hanoot/states/homescreen/vegetables_state.dart';
import 'package:Hanoot/states/order_state.dart';
import 'package:Hanoot/states/search_state.dart';
import 'package:Hanoot/states/wishlist_state.dart';
import 'package:Hanoot/widgets/home_screen/Lists/supermarket.dart';
import 'package:Hanoot/widgets/home_screen/Lists/vegetables.dart';
import 'package:Hanoot/widgets/product/heart_wishlist.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';


void main() async{

  return runApp(MyApp());
}
class INTO extends StatelessWidget {
  Widget homepage ;


  INTO(this.homepage);

  @override
  Widget build(BuildContext context) {
    return homepage ;
  }
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
Future<dynamic> _onBackgroundMessage(Map<String, dynamic> message) async {
  return Future<void>.value();
}
class _MyAppState extends State<MyApp> with AfterLayoutMixin{
  Locale _locale =Locale('ar', 'SA') ;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  StreamSubscription _sub;
  int itemId;
  bool isSeen ;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
 try{
   if (Platform.isAndroid)  _firebaseMessaging.configure(
     onBackgroundMessage: _onBackgroundMessage,
     // ...
   );
 }catch(e){

 }
    if (Platform.isIOS) iOSPermission();
}

  AlertDialog buildAlertDialog() {
    return AlertDialog(
      title: Text(
        "You are not Connected to Internet",
        style: GoogleFonts.elMessiri(fontStyle: FontStyle.italic),
      ),
    );
  }
  initPlatformState() async {
    await initPlatformStateForStringUniLinks();
  }

  initPlatformStateForStringUniLinks() async {

  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        EdgeAlert.show(context,
            title: message['notification']["title"],
            description: message['notification']['body'],
            gravity: EdgeAlert.TOP,
            backgroundColor: Theme.of(context).primaryColor);
        return null;
      },
      onResume: (Map<String, dynamic> message) => null,
      onLaunch: (Map<String, dynamic> message) => null,
    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
    });
  }
  @override
  void didChangeDependencies() {
      this._locale = Locale('ar', 'SA');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> AppState(initialScreen: HomeScreen(), screens: [
            HomeScreen(),
            CategoryListScreen(),
            SearchScreen(),
            IndexCartScreen(),
            SettingsScreen(),
          ]),
        ),
        ChangeNotifierProvider<HomeState>(
            create: (context) => HomeState(),
            child: Consumer<CartState>(
              builder: (context, provider, child) =>HomeScreen(),)),


        //////////user setting
        ChangeNotifierProvider<UserState>(
            create: (context) => UserState(),
            child: Consumer<UserState>(
              builder: (context, provider, child) =>SettingsScreen(),)),

        /// Home Screen Lists
        ChangeNotifierProvider<SuperMarketState>(
            create: (context) => SuperMarketState(categoryId: 138),
            child: Consumer<SuperMarketState>(
              builder: (context, state, child) =>SuperMarket(),)),
        ChangeNotifierProvider<HouseholdState>(
            create: (context) => HouseholdState(categoryId: 166),
            child: Consumer<HouseholdState>(
              builder: (context, state, child) =>Household(),)),
        ChangeNotifierProvider<VegetablesState>(
            create: (context) => VegetablesState(categoryId: 145),
            child: Consumer<VegetablesState>(
              builder: (context, state, child) =>Vegetables(),)),
        ///      ****     ///

        ChangeNotifierProvider<WishListState>(
            create: (context) => WishListState(),
            child: Consumer<WishListState>(
              builder: (context, provider, child) =>WishListScreen(),)),
        //////////////////////////


      ChangeNotifierProvider<CategoriesState>(
          create: (context) => CategoriesState(),
          child: Consumer<CategoriesState>(
            builder: (context, provider, child) =>HomeScreen(),)),


        //searches screen //////

        ChangeNotifierProvider<CartState>(
            create: (context) => CartState(),
            child: Consumer<CartState>(
              builder: (context, provider, child) =>HeartWishList(),)),
        ChangeNotifierProvider<CartState>(
            create: (context) => CartState(),
            child: Consumer<CartState>(
              builder: (context, provider, child) =>DetailProducts(),)),
        ChangeNotifierProvider<CartState>(
            create: (context) => CartState(),
            child: Consumer<CartState>(
              builder: (context, provider, child) =>CartScreen(),)),
        ChangeNotifierProvider<OrderState>(
            create: (context) => OrderState(),
            child: Consumer<OrderState>(
              builder: (context, provider, child) =>MyOrders(),)),
        ChangeNotifierProvider<SearchState>(
            create: (context) => SearchState(),
            child: Consumer<SearchState>(
              builder: (context, provider, child) =>SearchScreen(),)),

      ],
      child: Consumer<AppState>(
    builder: (context,state,child)=>MaterialApp(

                locale: _locale,
        localizationsDelegates: [
          DemoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar', 'SA'),// Arabic,  Saudia Arabia country code
          const Locale('en', 'US'), // English, USA country code
        ],
        debugShowCheckedModeBanner: false,
        onGenerateRoute: CustomRouter.allRoutes,
    theme: state.getTheme(),
      home:
      (isSeen==null||isSeen!=true)?
      OnBoarding()
      :
      AnimatedSplash(
        imagePath: 'assets/splash_screen.png',
        home: App(state:state),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),
      ),)
    );
  }
  @override
  void afterFirstLayout(BuildContext context) async{
    var pref = await SharedPreferences.getInstance();
    // pref.setBool("is_seen", false);
     setState(() {
       isSeen = pref.getBool('is_seen');

     });
  }
}

