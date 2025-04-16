import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/routes/name_routers.dart';
import 'package:Hanoot/screens/CategoryListScreen.dart';
import 'package:Hanoot/screens/about_us.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/categories_state.dart';
import 'package:Hanoot/states/wishlist_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>  {

  bool Verified =false ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      Verified = preferences.getBool("Verified");
    });
  }
  bool isSwitched = false ;
  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context);
    return   Consumer<UserState>(
        builder: (context,userstate, child) =>SafeArea(
    child: Scaffold(
      body:CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
            expandedHeight: Constants.screenAwareSize(120, context),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //  title: const Text('الاعدادات'),
              background:
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height ,
                      margin: EdgeInsets.all(0),
                      child:     Container(
                        width: double.infinity,
                        height: 50,
                        child: Material(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)),
                          elevation: 7,
                          color: Theme.of(context).primaryColor,

                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 150,
                              height:120,
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(2),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Image.asset(appState.isDark?"assets/icons/app_icon3.png":"assets/icons/app_icon4.png",),
                              ),
                            ),
                          ],
                        )

                    ),

                  ],
                ),
              ),

            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    //     SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:20.0,top: 20,bottom: 10),
                          child: Text("معلومات شخصية",style: GoogleFonts.elMessiri(fontSize: 20),),
                        )
//                ,Padding(
//                  padding: const EdgeInsets.only(right:20.0,left: 20,top: 5),
//                  child: Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,),
//                )
                      ],

                    ),
                    //   SizedBox(height: 1,),
                    if(userstate.user==null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),

                        ),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            onTap: (){


                              Navigator.of(context).pushNamed(loginRouter);

                            },
                            leading: Icon(Icons.person_add),
                            title: Text("تسجيل دخول",style: GoogleFonts.elMessiri(),),
                            trailing:  Icon(Icons.chevron_right),
                          ),
                        ),

                      ),
                    // SizedBox(height: 1,),
                    if(userstate.user!=null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        decoration: BoxDecoration(
                          // color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(8)),

                        ),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            onTap: (){

                            },
                            leading: Icon(Icons.person),
                            title: Text("${userstate.user.name}",style: GoogleFonts.elMessiri(),),
                            //  trailing:  Icon(Icons.chevron_right),

                          ),
                        ),
                      ),
                    //  SizedBox(height: 1,),
                    if(userstate.user!=null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        decoration: BoxDecoration(
                          // color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(8)),

                        ),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            onTap: (){

                              Provider.of<UserState>(context,listen: false).logout();

                            },
                            leading: Icon(Icons.exit_to_app),
                            title: Text("تسجيل خروج",style: GoogleFonts.elMessiri(),),
                            trailing:  Icon(Icons.chevron_right),

                          ),
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:20.0,top: 5,bottom: 10),
                          child: Text(" عام",style: GoogleFonts.elMessiri(fontSize: 20),),
                        )
//              ,Padding(
//                padding: const EdgeInsets.only(right:20.0,left: 20,top: 5),
//                child: Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,),
//              )
                      ],

                    ),
                    //   SizedBox(height: 1,),
//              Badge(
//                elevation:0,
//                showBadge: stateCart.cartProducts.length!=0,
//                badgeContent: Text("${stateCart.cartProducts.length}",
//                  style: GoogleFonts.elMessiri(color: Colors.white),
//                ),
//                badgeColor: Theme.of(context).accentColor,
//                animationType: BadgeAnimationType.scale,
//                child:Image.asset("assets/icons/cart.png",color: state.getTheme().accentColor),
//
//              ),
                    Consumer<WishListState>(builder: (context,stateWishList,child){
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        decoration: BoxDecoration(
                          // color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(8)),

                        ),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            onTap: ()async{
                              // await Provider.of<OrderState>(context).getMyOrders(userState: state);
                              Navigator.of(context).pushNamed(wishListRouter);
//                    Navigator.of(context).push(MaterialPageRoute(
//                        fullscreenDialog: true,
//                        builder: (_)=>ChangeNotifierProvider(
//                          child: MyOrders(userState: userstate,),
//                          builder: (_)=>OrderState(),
//                        )
//                    ));

                            },
                            leading: Badge(
                                elevation: 0,
                                position: BadgePosition.topStart(top: 0,start: 0),
                                padding: EdgeInsetsDirectional.only(start: 4,end: 4,),
                                showBadge: stateWishList.wishListCartProducts.length!=0,
                                badgeContent: Text("${stateWishList.wishListCartProducts.length<10?stateWishList.wishListCartProducts.length:"+10"}",
                                  style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 8),
                                ),
                                badgeColor: Colors.redAccent.withOpacity(0.8),
                                animationType: BadgeAnimationType.scale,
                                child: Icon(Icons.favorite)),
                            title: Text("رغباتي",style: GoogleFonts.elMessiri(),),
                            trailing:  Icon(Icons.chevron_right),

                          ),
                        ),
                      );
                    },),
                    //////////////////end ///////
                    //   SizedBox(height: 1,),
                    Consumer<CategoriesState>(builder: (context,state,child){
                      return      state.isLoading?
                      Container(): Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        decoration: BoxDecoration(
                          // color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(8)),

                        ),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            onTap: ()async{
                              // await Provider.of<OrderState>(context).getMyOrders(userState: state);
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>
                                  CategoryListScreen(state: state,),
                                  fullscreenDialog: true
                              ));
//                    Navigator.of(context).push(MaterialPageRoute(
//                        fullscreenDialog: true,
//                        builder: (_)=>ChangeNotifierProvider(
//                          child: MyOrders(userState: userstate,),
//                          builder: (_)=>OrderState(),
//                        )
//                    ));

                            },
                            leading: Icon(Icons.apps),
                            title: Text("التصنيفات",style: GoogleFonts.elMessiri(),),
                            trailing:  Icon(Icons.chevron_right),

                          ),
                        ),
                      );
                    }),
                    //////////////////end ///////
                    //   SizedBox(height: 1,),
                    if(userstate.user!=null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        decoration: BoxDecoration(
                          // color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(8)),

                        ),
                        child:Card(
                          elevation: 1,
                          child: ListTile(
                            onTap: ()async{
                              // await Provider.of<OrderState>(context).getMyOrders(userState: state);
                              Navigator.of(context).pushNamed(ordersRouter);
//                    Navigator.of(context).push(MaterialPageRoute(
//                        fullscreenDialog: true,
//                        builder: (_)=>ChangeNotifierProvider(
//                          child: MyOrders(userState: userstate,),
//                          builder: (_)=>OrderState(),
//                        )
//                    ));

                            },
                            leading: Icon(Icons.access_time),
                            title: Text("طلباتي",style: GoogleFonts.elMessiri(),),
                            trailing:  Icon(Icons.chevron_right),

                          ),
                        ),
                      ),
                    //    SizedBox(height: 1,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                      decoration: BoxDecoration(
                        //    color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(8)),

                      ),
                      child:Card(
                        elevation: 1,
                        child: ListTile(
                          onTap: (){
                            appState.isDark?appState.setLightTheme():
                            appState.setDarkTheme();
                          },
                          leading: Icon(Icons.lightbulb_outline),
                          title: Text("وضع الليلي",style: GoogleFonts.elMessiri(),),
                          trailing:  Switch(
                            value: appState.isDark?true:false,
                            onChanged: (value){
                              setState(() {
                                appState.isDark?appState.setLightTheme():
                                appState.setDarkTheme();
                              });
                            },
                            activeTrackColor: Theme.of(context).highlightColor,
                            activeColor:Theme.of(context).accentColor ,
                          ),
                        ),
                      ) ,
                    ),
                    //    SizedBox(height: 1,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                      decoration: BoxDecoration(
                        // color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(8)),

                      ),
                      child:Card(
                        elevation: 1,
                        child: ListTile(
                          onTap: ()async{
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutUS()));

                          },
                          leading: Icon(Icons.info_outline),
                          title: Text("حول",style: GoogleFonts.elMessiri(),),
                          trailing:  Icon(Icons.chevron_right),

                        ),
                      ),
                    ),
                  ]))

        ],
      ),
   //   floatingActionButton: ChatButton(),
    )

        )
          );
  }


}

class ChatButton extends StatefulWidget {
  @override
  _ChatButtonState createState() => _ChatButtonState();
}

class _ChatButtonState extends State<ChatButton> with SingleTickerProviderStateMixin{
  double getRadiansFromDegree(double degree){
    double unitRadian = 57.295779513;
    return degree/unitRadian ;
  }
  AnimationController _animationController ;
  Animation animation ;
  @override
  void initState() {
    // TODO: implement initState
    _animationController =AnimationController(vsync: this,duration: Duration(milliseconds: 250));
    animation = Tween(begin: 0.0,end: 1.0).animate(_animationController);

    super.initState();
    _animationController.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
            Positioned(
              right: 30,
              bottom: 30,
              child:Stack(
                children: <Widget>[
                  InkWell(
                    onTap: (){

                      _animationController.forward();
                    },
                    child: Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(275),animation.value*100),
                      child: chatButtonUI(
                        height: 60,
                        width: 60,
                        color: Colors.red,
                        icon: Icon(Icons.mail),

                        onPressed: (){


                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      _animationController.forward();
                    },
                    child: Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(225),animation.value*100),
                      child: chatButtonUI(
                        height: 60,
                        width: 60,
                        color: Colors.green,
                        icon: Icon(Icons.mail),
                        onPressed: (){
                          _animationController.forward();
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(180),animation.value*100),
                    child:   Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(shape: BoxShape.circle,color:  Colors.blue),
                      child: IconButton(icon: Icon(Icons.mail), onPressed: (){
                        _animationController.forward();

                      }),

                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(_animationController.isCompleted){
                        _animationController.reverse();
                      }else{
                        _animationController.forward();
                      }
                    },
                    child: Positioned(
                      right: 180,
                      height: 30,
                      child: Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(180),animation.value*100),
                        child: chatButtonUI(
                          height: 100,
                          width: 100,
                          color: Colors.redAccent,
                          icon: Icon(Icons.mail),

                          onPressed: (){
                            if(_animationController.isCompleted){
                              _animationController.reverse();
                            }else{
                              _animationController.forward();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  chatButtonUI(
                    height: 60,
                    width: 60,
                    color: Colors.redAccent,
                    icon: Icon(Icons.mail),

                    onPressed: (){
                      if(_animationController.isCompleted){
                          _animationController.reverse();
                      }else{
                          _animationController.forward();
                      }
                    },
                  ),
                ],
              )
            ),

        ],
      ),
    );
  }
}
class chatButtonUI extends StatelessWidget {
 final double height ;
 final double width;
 final Color color ;
 final Function onPressed ;
 final Icon icon ;
  chatButtonUI({this.width,this.height,this.onPressed,this.color,this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(shape: BoxShape.circle,color: this.color),
      child: IconButton(icon: icon, onPressed: onPressed),
    );
  }
}



