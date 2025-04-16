
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/routes/name_routers.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class Verify extends StatefulWidget {
  final String phoneNumber;
  final String verifyId;

  Verify({ this.verifyId, this.phoneNumber});
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify>  with SingleTickerProviderStateMixin{
  Animation animation ;
  AnimationController animationController ;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool hasError = false;
  var onTapRecognizer;
@override
  void dispose() {
    // TODO: implement dispose
  _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };


  }
  _loginSMS(smsCode, context) async {
   // await _playAnimation();
    try {
      _btnController.start();

      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: widget.verifyId,
        smsCode: smsCode,
      );
      final FirebaseUser user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      if (user != null) {
        await Provider.of<UserState>(context, listen: false).loginFirebaseSMS(
          phoneNumber: user.phoneNumber,
          success: (user) async {
            _btnController.success();
            _btnController.stop();


            },
          fail: (message)  {
            _btnController.stop();

          },
        ).then((value) => {
        _btnController.success(),
        _btnController.stop(),

        Navigator.of(context).pushNamedAndRemoveUntil(homeRouter, (route) => false)

        }).catchError((onError)=>{

        });
      } else {
//        await _stopAnimation();
//        _failMessage(S.of(context).invalidSMSCode, context);
      }
    } catch (e) {
      _btnController.stop();

//      await _stopAnimation();
//      _failMessage(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(animation: animationController, builder: (context,child){
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
        appBar: AppBar(



        ),
        body:Transform(transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
        child: SingleChildScrollView(
          child:  Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 48.0,
//                      child: Image.asset('assets/flight.png'),
                child:  Shimmer.fromColors(
                  baseColor: Theme.of(context).accentColor.withOpacity(0.7),
                  highlightColor:Theme.of(context).accentColor,
                  child: Container(width: 70,height: 70,child:
                  Image.asset("assets/icons/sms.png",color: Theme.of(context).accentColor,),),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("لقد تم إرسال رمز التحقق إلي الرقم ",style: GoogleFonts.elMessiri(fontSize: 15,fontWeight: FontWeight.bold)),
                    Text("${widget.phoneNumber}",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    length: 6,
                    obsecureText: false,
                    autoFocus: true,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.underline,
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    onChanged: (value) {
                      if (value != null && value.length == 6) {
                        _btnController.start();
                        _loginSMS(value, context);
                      }
                    },
                  )),
              SizedBox(height: 10,),
              FlatButton(
                child: Text(
                  'لم أتلقي الرمز !',
                  style: GoogleFonts.elMessiri(
                      color: Theme.of(context).accentColor,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.of(context).pop();

                },
              ),
              SizedBox(height: 20,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/3,

                    child: RoundedLoadingButton(
                      child: Text("تأكيد",
                          style: GoogleFonts.elMessiri(fontSize: 20,color: Colors.black)),
                      controller: _btnController,
                      onPressed: (){
                        if(_controller.text.isNotEmpty||_controller.text!=""||_controller.text!=null||_controller.text!=" "){
                          _doSomething(context);
                        }
                      },
                      color: Theme.of(context).accentColor,

                    ),
                  )
              )

            ],
          ),
        ),
        )

      );
    });
  }
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  void _doSomething(BuildContext context) async {
//    Timer(Duration(seconds: 5), () {
//      _btnController.success();
//    });
    _loginSMS(_controller.text,context);
  }
  /*
   child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 40.0,
                        child: Image.asset('assets/images/logo.png')),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'التحقق من رقم الهاتف',
                style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: RichText(
                text: TextSpan(
                    text: "أدخل الرمز المرسل إلي",
                    children: [
                      TextSpan(
                          text: widget.phoneNumber,
                          style: GoogleFonts.elMessiri(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ],
                    style: GoogleFonts.elMessiri(color: Colors.black54, fontSize: 15)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  length: 6,
                  obsecureText: false,
                  autoFocus: true,
                  animationType: AnimationType.fade,
                  shape: PinCodeFieldShape.underline,
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  onChanged: (value) {
                    if (value != null && value.length == 6) {
                      _loginSMS(value, context);
                    }
                  },
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              // error showing widget
              child: Text(
                hasError ? "* يرجى تعبئة جميع الخلايا بشكل صحيح" : "",
                style: GoogleFonts.elMessiri(color: Colors.red.shade300, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "لم تتلق الرمز؟",
                  style: GoogleFonts.elMessiri(color: Colors.black54, fontSize: 15),
                  children: [
                    TextSpan(
                        text: " اعادة الإرسال",
                        recognizer: onTapRecognizer,
                        style: GoogleFonts.elMessiri(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16))
                  ]),
            ),
            SizedBox(
              height: 14,
            ),

          ],
        ),
   */
}
