import 'package:flutter/material.dart';
import 'package:Hanoot/models/user.dart';
import 'package:Hanoot/routes/name_routers.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}
class _UserLoginState extends State<UserLogin> with SingleTickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  TextStyle style = GoogleFonts.elMessiri( fontSize: 12.0);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));

    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));

    animationController.forward();
  }
  String username,password ;
  Future routUrlForgetPassword(String url)async{
    url = "https://hanoot.ly/my-account/lost-password/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void loginuser(BuildContext context) {
    if(username==null||password==null){
      _btnController.stop();
    }else{
      try{
        Provider.of<UserState>(context,listen: false).login(
            username: username,
            password: password,
            success: (user){
              welcomeUser(user,context);
            },
            fail: (message){
              fillmesaage(message,context);
            }

        );
      }catch(e){
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    AppState appState = Provider.of<AppState>(context,listen: false);
    return AnimatedBuilder(animation: animationController,
        builder: (context,child){
        return  Scaffold(
            key: _scaffoldKey,
            // key: _formKey,
            //  backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: AppBar(
                  elevation: 2,
                  leading: Transform.scale(scale: 0.8,
                    child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                      Navigator.of(context).pop();
                    }),
                  ),
                )),
            body:Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListenableProvider.value(
            value: Provider.of<UserState>(context),
            child: Consumer<UserState>(builder: (context,state,child){
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                children: <Widget>[
                 Transform(
                   transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                   child: Column(
                     children: <Widget>[
                       Container(
                         width: 200,height: 150,
                         child: CircleAvatar(
                           backgroundColor: Colors.transparent,
                           radius: 48.0,
//                      child: Image.asset('assets/flight.png'),
                           child:  Container(width: 200,height: 150,child:
                        Image.asset(appState.isDark?"assets/icons/app_icon4.png":"assets/icons/app_icon.png",),

                           ),
                         ),
                       ),
                    //   Divider(),

                       SizedBox(height: 10.0),
                       Container(
                         height: 55,
                         child: TextFormField(
                           controller: usernameController,
                           onChanged: (val) {
                             username=val;
                           },
                           decoration: InputDecoration(
                             icon: Icon(Icons.email,color: Theme.of(context).accentColor),
                             labelText: 'البريد الالكتروني',
                             contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                           ),

                         ),
                       ),
                       SizedBox(height: 12.0),
                       Container(
                         height: 55,
                         child: TextFormField(
                           controller:passwordController,
                           onChanged: (val){

                             password=val;},
                           decoration: InputDecoration(
                             icon: Icon(Icons.lock,color: Theme.of(context).accentColor),
                             labelText: 'كلمة المرور',
                             contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                           ),

                         ),
                       ),
                     ],
                   ),
                 ),
                 Transform(
                   transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                   child: Column(
                     children: <Widget>[
                       SizedBox(height: 20.0),
                       Container(
                         width: MediaQuery.of(context).size.width-140,
                         height: 60,
                         child: Padding(
                           padding: EdgeInsets.symmetric(vertical: 10.0),
                           child:     RoundedLoadingButton(
                             child: Shimmer.fromColors(
                               baseColor: Color(0xff1E1E1E),
                               highlightColor: Color(0xff1E1E1E).withOpacity(0.7),
                               child: Text('تسجيل دخول',
                                   style: GoogleFonts.elMessiri(fontSize: 16,color: Theme.of(context).primaryColor)),
                             ),
                             controller: _btnController,
                             onPressed: (){
                               loginuser(context);
                             },
                             color: Theme.of(context).accentColor,

                           ),
                         ),
                       ),
                       SizedBox(height: 15.0),
                       Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       Expanded(
                           flex: 2,child: Container(color: Colors.grey,height: 1,)),
                       Expanded(
                           flex: 3,child: Text("أو متابعة التسجيل بإستخدام",
                         textAlign: TextAlign.center,
                       style: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey[700]),
                       )),
                       Expanded(
                           flex: 2,child: Container(color: Colors.grey,height: 1)),                     ],
                   ),
                       SizedBox(height: 10.0),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           InkWell(
                             onTap: () {
                               _loginGoogle(context);

                             },
                             child: Container(
                               width:100,
                               height: 40,
                               margin: EdgeInsets.all(1.0),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(100)),
                                 color: Colors.red,
                                  boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 1), // changes position of shadow
                                  ),]
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(2.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Expanded(
                                       flex: 2,
                                       child: Padding(
                                         padding: const EdgeInsets.only(right:4.0),
                                         child: Text(
                                           ' جوجل',
                                           textAlign: TextAlign.center,
                                           style: GoogleFonts.elMessiri(
                                               fontSize: 12,
                                               color: Colors.white,
                                               fontWeight: FontWeight.bold
                                           ),
                                         ),
                                       ),
                                     ),
                                     Expanded(
                                       flex: 2,
                                       child: Container(
                                         height: 23,
                                         width: 23,
                                         child: Image.asset("assets/google-plus.png",color: Colors.white,),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           FlatButton(
                             child: Container(
                               width: 130,
                               height: 38,
                               margin: EdgeInsets.all(1.0),
                               decoration: BoxDecoration(


                               ),
                               child: Material(
                                 color: Theme.of(context).accentColor,
                                 borderRadius: BorderRadius.circular(50),

                                 elevation: 3,
                                 child: Container(
                                     padding: EdgeInsets.only(top: 5,bottom: 5,right: 20,left: 20),

                                     child: Shimmer.fromColors(

                                       baseColor:  Color(0xff1E1E1E),
                                       highlightColor: Color(0xff1E1E1E).withOpacity(0.7),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: <Widget>[
                                           Text(
                                             'رقم الهاتف',
                                             style: GoogleFonts.elMessiri(
                                                 color: Color(0xff1E1E1E),   fontSize: 12 ,
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ),
                                           SizedBox(width: 8,),
                                           Icon(Icons.phone_iphone,color:  Color(0xff1E1E1E),size: 17,)
                                         ],
                                       ),
                                     )
                                 ),
                               ),
                             ),
                             onPressed: () async{
                               // await routUrlForgetPassword("");
                               Navigator.of(context).pushNamed(LoginSmsRouter);
                             },
                           ),
                         ],
                       ),
                       SizedBox(height: 20.0),
                       FlatButton(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             Text(
                               'ليس لديك حساب؟ ',
                               style: GoogleFonts.elMessiri(
                              //   fontWeight: FontWeight.bold,
                               color: Theme.of(context).primaryColor.withOpacity(0.5),
                                 //  decoration: TextDecoration.underline
                               ),
                             ),
                             Text(
                               'سجل الآن',
                               style: GoogleFonts.elMessiri(
                                 fontWeight: FontWeight.bold,
                                 color: Theme.of(context).accentColor,
                                 //  decoration: TextDecoration.underline
                               ),
                             ),
                           ],
                         ),
                         onPressed: () {
                           Navigator.of(context).pushNamed(registerRouter);

                         },
                       ),
                       Divider(),
                       SizedBox(height: 10.0),
                       FlatButton(
                         child: Text(
                           'هل نسيت كلمة المرور ؟',
                           style: GoogleFonts.elMessiri(
                             color: Theme.of(context).accentColor,                  ),
                         ),
                         onPressed: () async{
                           await routUrlForgetPassword("");
                           //  Navigator.of(context).pushNamed(LoginSmsRouter);
                         },
                       ),
                     ],
                   ),
                 )
                ],
              );
            },),

          ),
            ),
        );
        });
  }
  void welcomeUser(User user,BuildContext context){
    _btnController.stop();
    var email = user.email ;
   var snackbar = SnackBar(content: Text("مرحبا بك يا $email"),
      duration: Duration(seconds: 10),
      action: SnackBarAction(label: "اغلاق", onPressed: (){

      }),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
    Navigator.pop(context);
    Navigator.of(context).pushNamed(homeRouter);
  }
  void fillmesaage(message, context){
    _btnController.stop();
    SnackBar(content: Text("هناك خطأ في عملية تسجيل الةخول $message"),
      duration: Duration(seconds: 10),
      action: SnackBarAction(label: "اغلاق", onPressed: (){

      }),
    );
  }
  _loginGoogle(context) async {
   // await _playAnimation();
    await Provider.of<UserState>(context, listen: false).loginGoogle(
      success: (user) {
        //hideLoading();
        //_stopAnimation();
        welcomeUser(user, context);
      },
      fail: (message) {

        fillmesaage(message,context);
      },
    );
  }
}
