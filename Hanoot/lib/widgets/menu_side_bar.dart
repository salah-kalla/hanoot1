import 'package:Hanoot/states/app_state.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/routes/name_routers.dart';
import 'package:Hanoot/screens/CategoryListScreen.dart';
import 'package:Hanoot/screens/about_us.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/categories_state.dart';
import 'package:Hanoot/states/wishlist_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class MenuSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 4,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 160,
                            height:120,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/icons/app_icon3.png",),
                            ),
                          ),
                        ],
                      )

                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
               ),
          ),
          SizedBox(height: 1,),
          Consumer<UserState>(builder: (context,userstate,child){
            return userstate.user==null
                ? Container()
                :  Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                // color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: ListTile(
                onTap: (){
                },
                leading: Icon(Icons.person),
                title: Text("${userstate.user.username}",style: GoogleFonts.elMessiri(),),

              ),
            );
          },),
          SizedBox(height: 1,),
          Consumer<WishListState>(builder: (context,stateWishList,child){
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                // color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(8)),

              ),
              child: ListTile(
                onTap: ()async{
                  Navigator.of(context).popAndPushNamed(wishListRouter);

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
            );
          },),
          //////////////////end ///////
//          SizedBox(height: 1,),
//          Container(
//            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
//            decoration: BoxDecoration(
//              // color: Colors.white70,
//              borderRadius: BorderRadius.all(Radius.circular(8)),
//
//            ),
//            child: ListTile(
//              onTap: ()async{
//                Navigator.of(context).popAndPushNamed(storesRouter);
//
//              },
//              leading: Icon(Icons.store),
//              title: Text("المتاجر"),
//              trailing:  Icon(Icons.chevron_right),
//
//            ),
//          ),
          SizedBox(height: 1,),
          Consumer<CategoriesState>(builder: (context,state,child){
            return      state.isLoading?
            Container(): Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                // color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(8)),

              ),
              child: ListTile(
                onTap: ()async{
                  // await Provider.of<OrderState>(context).getMyOrders(userState: state);
                  Navigator.of(context).pop();
                  Provider.of<AppState>(context,listen: false).setScreenIndex(1);
//                  Navigator.push(context, MaterialPageRoute(builder: (_)=>
//                      CategoryListScreen(state: state,),
//                      fullscreenDialog: true
//                  ));

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
            );
          }),
          SizedBox(height: 1,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            decoration: BoxDecoration(
              // color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(8)),

            ),
            child: ListTile(
              onTap: ()async{
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutUS()));

              },
              leading: Icon(Icons.info_outline),
              title: Text("حول",style: GoogleFonts.elMessiri(),),
              trailing:  Icon(Icons.chevron_right),

            ),
          ),

          SizedBox(height: 1,),
          Consumer<UserState>(builder: (context,userstate,child){
            return userstate.user==null
                ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                //   color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(8)),

              ),
              child: ListTile(
                onTap: (){
                  Navigator.of(context).popAndPushNamed(loginRouter);

                },
                leading: Icon(Icons.person_add),
                title: Text("تسجيل دخول",style: GoogleFonts.elMessiri(),),
                trailing:  Icon(Icons.chevron_right),
              ),
            )
                :  Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                // color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(8)),

              ),
              child: ListTile(
                onTap: (){

                  Provider.of<UserState>(context,listen: false).logout();


                },
                leading: Icon(Icons.exit_to_app),
                title: Text("تسجيل خروج",style: GoogleFonts.elMessiri(),),
                trailing:  Icon(Icons.chevron_right),

              ),
            );

          },),
        ],
      ),
    );
  }
}