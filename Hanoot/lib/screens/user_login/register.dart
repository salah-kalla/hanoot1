import 'package:firebase_auth/firebase_auth.dart' as a;
import 'package:flutter/material.dart';
import 'package:Hanoot/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> with SingleTickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  final a.FirebaseAuth _firebaseAuth = a.FirebaseAuth.instance;

//  Future<String> signIn(String email, String password) async {
//    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
//        email: email, password: password);
//    FirebaseUser user = result.user;
//    return user.uid;
//  }

//  Future<String> signUp(String email, String password) async {
//    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
//        email: email, password: password);
//    FirebaseUser user = result.user;
//    return user.uid;
//  }

//  Future<FirebaseUser> getCurrentUser() async {
//    FirebaseUser user = await _firebaseAuth.currentUser();
//    return user;
//  }
//
//  Future<void> signOut() async {
//    return _firebaseAuth.signOut();
//  }

//  Future<void> sendEmailVerification() async {
//    FirebaseUser user = await _firebaseAuth.currentUser();
//    user.sendEmailVerification();
//  }
//
//  Future<bool> isEmailVerified() async {
//    FirebaseUser user = await _firebaseAuth.currentUser();
//    return user.isEmailVerified;
//  }
  ///
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

 TextStyle style = GoogleFonts.elMessiri( fontSize: 12.0);
  String username,password, firstname,lastname;
  void RegisterUser(BuildContext context) async{
    if(username==null||password==null||firstname==null||lastname==null){
      _btnController.stop();
      print("يجب ان يتم تعبئة جميع الحقول"+usernameController.text.toString() + password.toString());
    } else{
      try{
        await _firebaseAuth.createUserWithEmailAndPassword(email: usernameController.text, password: passwordController.text);
        String u;
        Provider.of<UserState>(context,listen: false).createUser(username: username,
            password: password,isVender: false,firstName: firstname,lastName: lastname,
            success: (user){
              Provider.of<UserState>(context,listen: false).saveUser(user);
              Provider.of<UserState>(context,listen: false).getUser();
              welcomeUser(user,context);
            },
            fail: (message){
              fillmesaage(message);
            }
        ).then((value) async => {
          //  u = await signUp(username,password)
        });
      }catch(e){
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.clear();
    passwordController.clear();
    firstnameController.clear();
    lastnameController.clear();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));

    animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    AppState appState = Provider.of<AppState>(context,listen: false);

    return AnimatedBuilder(animation: animationController, builder: (context,child){
      return  Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListenableProvider.value(
              value: Provider.of<UserState>(context),
              child: Consumer<UserState>(builder: (context,state,child){
                return Center(
                  child: ListView(
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
                          SizedBox(height: 15.0),
                          TextFormField(
                            //    keyboardType: TextInputType.emailAddress,
                            //   autofocus: false,

                            controller: firstnameController,
                            onChanged: (val) {
                              firstname=val;
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.person_outline,color: Theme.of(context).accentColor,),
                              labelText: 'الآسم الأول',
                              contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                            ),

                          ),
                          TextFormField(
                            //    keyboardType: TextInputType.emailAddress,
                            //   autofocus: false,

                            controller: lastnameController,
                            onChanged: (val) {
                              lastname=val;
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.person,color: Theme.of(context).accentColor,),
                              labelText: "الأسم الأخير",
                              contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                            ),

                          ),
                          TextFormField(
                            //    keyboardType: TextInputType.emailAddress,
                            //   autofocus: false,

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
                          SizedBox(height: 12.0),
                          TextFormField(
                            //    autofocus: true,
                            //    obscureText: true,
                            controller:passwordController,
                            onChanged: (val){

                              password=val;},
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock,color: Theme.of(context).accentColor),
                              labelText: 'كلمة المرور',
                              contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                            ),

                          ),
                        ],
                      ),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                        child: Column(
                        children: <Widget>[
                          SizedBox(height: 24.0),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child:     RoundedLoadingButton(
                              child: Shimmer.fromColors(
                                baseColor:  Color(0xff1E1E1E),
                                highlightColor: Color(0xff1E1E1E).withOpacity(0.7),
                                child: Text('انشاء حساب',
                                    style: GoogleFonts.elMessiri(fontSize: 18,color: Theme.of(context).primaryColor)),
                              ),
                              controller: _btnController,
                              onPressed: ()async{

                                RegisterUser(context);
                              },
                              color: Theme.of(context).accentColor,

                            ),
                          ),
                          FlatButton(
                            child: Text(
                              'لدي حساب بالفعل !',
                              style: GoogleFonts.elMessiri(
                                color: Theme.of(context).accentColor,                  ),
                            ),
                            onPressed: () async{
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      )
                    ],
                  ),
                );
              },),
            ),
          )
      );
    });

  }
  void welcomeUser(User user,BuildContext context){
    _btnController.stop();

    var email = user.email ;
    print("مرحبا بك يا $email");
    final snackbar = SnackBar(content: Text("مرحبا بك يا $email"),

      duration: Duration(seconds: 10),
      action: SnackBarAction(label: "اغلاق", onPressed: (){

      }),
    );

    Navigator.of(context).pop();

   /// Navigator.pushNamed(context, '/');

  }
  void fillmesaage(message){
    _btnController.stop();
    print("هناك خطأ في عملية انشاء الحساب $message");
    final snackbar = SnackBar(content: Text("هناك خطأ في عملية تسجيل الةخول $message"),

      duration: Duration(seconds: 10),
      action: SnackBarAction(label: "اغلاق", onPressed: (){

      }),
    );
  }
  }



