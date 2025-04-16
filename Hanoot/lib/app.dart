import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/states/connectivity_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_setting/system_setting.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  final AppState state ;
  const App({Key key, this.state}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}
class _AppState extends State<App> with AfterLayoutMixin{
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();
  BuildContext myContext;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
            (_) {
          _isFirstLaunch().then((result){
            if(result)
              ShowCaseWidget.of(myContext).startShowCase([_one,_two,_three,_four,_five]);
          });
        }
    );
  }
  Future<bool> _isFirstLaunch() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences.getBool("showcase") ?? true;

      if(isFirstLaunch)
      sharedPreferences.setBool("showcase", false);

    return isFirstLaunch;
  }
  @override
  Widget build(BuildContext context) {

    return  ShowCaseWidget(
      // onFinish: ,
        builder:
        Builder(builder: (context) {
          myContext = context;
          return Scaffold(
            body:SafeArea(child: widget.state.selectedScreen) ,
            bottomNavigationBar:  Consumer<CartState>(builder: (context,stateCart,child){
              return BottomNavigationBar(
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey[600],
                currentIndex: widget.state.selectedScreenIndex,
                selectedItemColor: widget.state.getTheme().accentColor,
                unselectedLabelStyle:GoogleFonts.elMessiri(color: Colors.grey[600]) ,
                selectedLabelStyle:GoogleFonts.elMessiri() ,
                type: BottomNavigationBarType.shifting ,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(width: 20,height: 20,child:
                    Image.asset("assets/icons/home.png",color: Colors.grey[600]),),
                    label: "الرئيسية",
                    // title:  Text("الرئيسية",style: GoogleFonts.elMessiri(),),
                    activeIcon:Showcase(
                      key: _one,
                      showcaseBackgroundColor:  Colors.white,
                     // textColor:Theme.of(context).primaryColor,
                      overlayColor: Theme.of(context).accentColor,
                      //    title: 'الصفحة الرئيسية',
                      description: 'يمكنك رؤية ابرز العروض وأحدثها من هنا',
                      shapeBorder: CircleBorder(),
                      showArrow: true,
                      child: Container(width: 24,height: 24,
                        margin: EdgeInsets.all(0),
                        child:
                      Image.asset("assets/icons/home2.png",color: widget.state.getTheme().accentColor),),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _two,
                      //    title: 'الصفحة الرئيسية',
                      showcaseBackgroundColor:  Colors.white,
                      // textColor:Theme.of(context).primaryColor,
                      overlayColor: Theme.of(context).accentColor,
                      description: 'تقوم بعرض كافة الأقسام',
                      shapeBorder: CircleBorder(),
                      showArrow: false,
                      child: Container(width: 20,height: 20,
                        margin: EdgeInsets.all(4),
                        child:
                      Image.asset("assets/icons/category.png",color: Colors.grey[600]),),
                    ),
                    label: "الفئات",
                    activeIcon: Container(width: 20,height: 20,child:
                    Image.asset("assets/icons/grid.png",color: widget.state.getTheme().accentColor),

                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _three,
                      //    title: 'الصفحة الرئيسية',
                      showcaseBackgroundColor:  Colors.white,
                      // textColor:Theme.of(context).primaryColor,
                      overlayColor: Theme.of(context).accentColor,
                      description: 'تمكنك من البحث عن منتجات',
                      shapeBorder: CircleBorder(),
                      showArrow: true,
                      child: Container(width: 20,height: 20,
                        margin: EdgeInsets.all(4),

                        child:
                      Image.asset("assets/icons/search.png",color: Colors.grey[600]),),
                    ),
                      label: "البحث",
                    // title: Text("البحث",style: GoogleFonts.elMessiri(),),
                    activeIcon: Container(width: 20,height: 20,child:
                    Image.asset("assets/icons/search.png",color: widget.state.getTheme().accentColor),),
                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _four,
                      //    title: 'الصفحة الرئيسية',
                      showcaseBackgroundColor:  Colors.white,
                      // textColor:Theme.of(context).primaryColor,
                      overlayColor: Theme.of(context).accentColor,
                      description: 'تقوم بعرض السلة خاصتك واتمام الطلب',
                      shapeBorder: CircleBorder(),
                      showArrow: true,
                      child: Container(width: 20,height: 20,
                        margin: EdgeInsets.all(4),

                        child:
                      Badge(
                        elevation:0,
                        position: BadgePosition.topStart(top: 0,start: 0),
                        padding: EdgeInsetsDirectional.only(start: 4,end: 4,),
                        showBadge: stateCart.cartProducts.length!=0,
                        badgeContent: Text("${stateCart.cartProducts.length}",
                          style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 8),
                        ),
                        badgeColor: Colors.redAccent.withOpacity(0.8),
                        animationType: BadgeAnimationType.scale,
                        child:  Image.asset("assets/icons/cart.png",color: Colors.grey[600]),
                      ),


                      ),
                    ),
                    label: "السلة",
                    // title: Text("السلة",style: GoogleFonts.elMessiri(),),
                    activeIcon: Container(width: 20,height: 20,child:
                    Badge(
                      elevation:0,
                      position: BadgePosition.topStart(top: 0,start: 0),
                      padding: EdgeInsetsDirectional.only(start: 4,end: 4,),
                      showBadge: stateCart.cartProducts.length!=0,
                      badgeContent: Text("${stateCart.cartProducts.length}",
                        style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 8),
                      ),
                      badgeColor: Colors.redAccent.withOpacity(0.8),
                      animationType: BadgeAnimationType.scale,
                      child:Image.asset("assets/icons/cart2.png",color: widget.state.getTheme().accentColor),
                    ),

                    ),

                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _five,
                      //    title: 'الصفحة الرئيسية',
                      showcaseBackgroundColor:  Colors.white,
                      // textColor:Theme.of(context).primaryColor,
                      overlayColor: Theme.of(context).accentColor,
                      description: 'عرض جميع المعلومات المتعلقة بحسابك',
                      shapeBorder: CircleBorder(),
                      showArrow: true,
                      child: Container(width: 20,height: 20,
                        margin: EdgeInsets.all(4),

                        child:
                      Image.asset("assets/icons/setting.png",color: Colors.grey[600]),),
                    ),
                    label: "المزيد",
                    // title: Text("المزيد",style: GoogleFonts.elMessiri(),),
                    activeIcon: Container(width: 20,height: 20,child:
                  Image.asset("assets/icons/setting2.png",color:widget.state.getTheme().accentColor),),
                  )
                ],
                onTap: (index){
                  //  widget.state.setScreenIndex(index);
                  Provider.of<AppState>(context,listen: false).setScreenIndex(index);
                },
              );
            },),
          ) ;
        }));
  }
  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    checkinternet();
  }
  Future checkinternet()async{
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    if(!(await connectionStatus.checkConnection())){
      showDialog(context: context,
          builder: (context)=>CupertinoAlertDialog(
            title:Container(child:  Text("لايوجد إتصال بالإنترنت !",textAlign: TextAlign.center,),),
            content: Container(
              height: 120,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Container(width: 100,height: 100,child:
                  Image.asset("assets/icons/wifi.png"),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            actions: <Widget>[
           Container(child:  Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               SizedBox(height: 1,width: 5,),
               Expanded(
                 flex: 2,
                 child: RaisedButton(onPressed: (){
                   SystemSetting.goto(SettingTarget.WIFI);
                 },
                   child: Text("الإعدادات",style: GoogleFonts.elMessiri(color: Colors.white),),
                   color: Theme.of(context).primaryColor,
                 ),
               ),
               SizedBox(height: 1,width: 5,),
               Expanded(
                 flex: 1,
                 child: RaisedButton(onPressed: (){
                   Navigator.of(context).pop();
                 },
                   child: Text("اغلاق",style: GoogleFonts.elMessiri(color: Colors.white),),
                   color: Theme.of(context).primaryColor,
                 ),
               ),
               SizedBox(height: 1,width: 5,),
             ],
           ),)
            ],
          ),
      );

    }
  }
}
