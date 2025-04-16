import 'dart:async';

import 'package:Hanoot/routes/name_routers.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/screens/user_login/verify.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginSms extends StatefulWidget {
  @override
  _LoginSmsState createState() => _LoginSmsState();
}

class _LoginSmsState extends State<LoginSms>  with SingleTickerProviderStateMixin{
  Animation animation ;
  AnimationController animationController ;
TextEditingController _controller =TextEditingController();
TextEditingController _controllerSMS =TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;

  CountryCode countryCode;
  String _phone;
  String _message ;
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
  @override
  void initState() {
    super.initState();
    _phone = '';
    countryCode = CountryCode(code: 'LY', dialCode: '+218', name: 'Libya');
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    AppState appState = Provider.of<AppState>(context,listen: false);

    return SafeArea(
      child: AnimatedBuilder(animation: animationController, builder: (context,child){
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(

          ),
          body: Transform(transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 200,height: 150,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      //radius: 48.0,
                      child:  Container(width: 200,height: 150,child:
                      Image.asset(appState.isDark?"assets/icons/app_icon4.png":"assets/icons/app_icon.png",),

                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width-90,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CountryCodePicker(
                              onChanged: (country) {
                                setState(() {
                                  countryCode = country;
                                });
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: countryCode.code,
                              //Get the country information relevant to the initial selection
                              onInit: (code) {
                                countryCode = code;
                              }),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.all(5),
                              child:   TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _controller,
                                  validator: (val) {
                                    return val.isEmpty
                                        ? "الحقل مطلوب"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "إدخل رقم هاتفك"),
                               )


                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top:8.0,right: 8.0,left: 8.0,bottom: 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.5,
                        child: RoundedLoadingButton(
                          child: Shimmer.fromColors(
                            baseColor:  Color(0xff1E1E1E),
                            highlightColor: Color(0xff1E1E1E).withOpacity(0.7),
                            child: Text("التحقق الأن",
                                style: GoogleFonts.elMessiri(fontSize: 15,color: Colors.black)),
                          ),
                          controller: _btnController,
                          onPressed: (){
                            _doSomething(context);
                          },
                          color: Theme.of(context).accentColor,

                        ),
                      )
                  )

                ],
              ),
            ),
          ),
          )
        );
      }),
    );
  }
final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
void _doSomething(BuildContext context) async {
  String phone =countryCode.dialCode+_controller.text.trim();
  _loginSMS(context,phone);
}

Future<void> _loginSMS(context,String phone) async {
  if (_controller.text == null||_controller.text.isEmpty) {
    var snackBar = SnackBar(content: Text("يرجي ادخال الرقم"));
    Scaffold.of(context).showSnackBar(snackBar);
  } else {
    // await _playAnimation();
    _btnController.start();

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      //_stopAnimation();
      _btnController.stop();

    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
     // _stopAnimation();
      _btnController.success();
      _btnController.stop();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Verify(
            verifyId: verId,
            phoneNumber: phone,
          ),
        ),
      );
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) async {
      final FirebaseUser user =
          (await _auth.signInWithCredential(phoneAuthCredential)).user;
      final FirebaseUser currentuser =await _auth.currentUser();
      assert(user.uid==currentuser.uid);

      if(user!=null) {
        _message = "Seccessfully singed in, uid: "+ user.uid;

        await Provider.of<UserState>(context, listen: false).loginFirebaseSMS(
          phoneNumber: user.phoneNumber,
          success: (user) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('Verified', true);

            prefs.setString('phone_number',_controller.text.toString());
            bool verified= await prefs.getBool('Verified');
            prefs.setString('isvendor', "subscribe");
            _btnController.stop();
            Navigator.of(context).pushNamedAndRemoveUntil(homeRouter, (route) => false);

            // _welcomeMessage(user, context);
          },
          fail: (message)  {
           // _failMessage(message, context);
          },
        );
      }else{
        _message = "Sign in faild";

      }
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
//      _stopAnimation();
    _btnController.stop();
//      _failMessage(exception.message, context);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 40),
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed,
    );
  }
}

}
