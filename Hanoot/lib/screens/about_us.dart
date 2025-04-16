import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> with SingleTickerProviderStateMixin {

  Animation animation,afterAnimation ;
  AnimationController animationController ;


  Future<void> share() async {
    await FlutterShare.share(
        title: 'Hanoot',
        text: ' ',
        linkUrl: 'https://hanoot.ly/',
        chooserTitle: ''
    );
  }
  Future<void> email()async{
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'info@hanoot.ly',
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
    }
  }
  Future<void> launchUrl(String urlName) async {
    var url = "www.facebook.com";
    if(urlName=="googlePlay"){
    url = "https://play.google.com/store/apps";
    }else if(urlName=="tel"){
   url = "tel://+218913117005";
    }else if(urlName=="instagram"){
      url = "https://www.instagram.com/hanoot.ly/";
    }else if(urlName=="facebook"){
      url = "https://www.facebook.com/hanoot.ly";
    }else if(urlName=="youtube"){
      url = "https://www.youtube.com/channel/UCkvQqYsgKycmR7ItnHVA-Dw";
    }else if(urlName=="Developer"){
      url = "https://www.linkedin.com/in/ahmed-gibran-593236181";
    }else if(urlName=="whatsApp"){
      url = "whatsapp://send?phone=+218913117005";
    }else if(urlName=="messenger"){
      url = "http://m.me/hanoot.ly";
    }


    if (await canLaunch(url)) {
      await launch("$url");
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 1));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.5,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    final widet = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (context,child){
      return Scaffold(
        appBar:AppBar(

        ),
        body:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Transform(
                    transform: Matrix4.translationValues(afterAnimation.value * widet, 0.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 60,left:60),
                          child: Image.asset("assets/icons/app_icon.png",),
                        ),
                        SizedBox(height: 30,),

                      ],
                    )
                ),
              Transform(
                transform: Matrix4.translationValues(animation.value * widet, 0.0, 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                SizedBox(height: 0,),
            Center(
                child: Padding(padding: EdgeInsets.only(right:30,left: 30),
                  child: Text("""سوق حانوت هو متجر للتسوق الالكتروني ، به نحاول أن نتمكن من مساعدتك في الحصول على كل مستلزمات بيتك وأسرتك وعملك مباشرة عبر هذه المنصة مع توفير خدمة التوصيل الى باب بيتك.""",
                    style: GoogleFonts.elMessiri(color: Colors.grey[700],fontSize: 18),textAlign: TextAlign.center,),
                ),
            ),
                  SizedBox(height: 15.0),

                  Padding(
                    padding: const EdgeInsets.only(right:40.0,left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 2,child: Container(color: Colors.grey,height: 1,)),
                        Expanded(
                            flex: 3,child: Text("يمكنكم التوصل معنا من خلال",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey[700]),
                        )),
                        Expanded(
                            flex: 2,child: Container(color: Colors.grey,height: 1)),                     ],
                    ),
                  ),

                  Padding(padding: const EdgeInsets.only(right: 40.0,left: 40,top: 10,bottom: 10)
                  ,child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Container(
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: (){
                              launchUrl("messenger");
                            },
                            child: Material(
                              elevation: 2,
                              color: Color(0xff0078FF),
                              borderRadius: BorderRadius.circular(100),
                              child: Center(
                                child:Container(width:25,height: 25,child: Icon(FontAwesomeIcons.facebookMessenger,color: Colors.white,size: 25,)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: (){
                              launchUrl("whatsApp");
                            },
                            child: Material(
                              elevation: 2,
                              color: Color(0xff4FCE5D),
                              borderRadius: BorderRadius.circular(100),
                              child: Center(
                                child:Container(width:25,height: 25,child:
                                Icon(FontAwesomeIcons.whatsapp,color: Colors.white,size: 25,)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),

                  Padding(
                    padding: const EdgeInsets.only(right:60.0,left: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 2,child: Container(color: Colors.grey,height: 1,)),
                        Expanded(
                            flex: 3,child: Text("أو متابعتنا علي ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey[700]),
                        )),
                        Expanded(
                            flex: 2,child: Container(color: Colors.grey,height: 1)),                     ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(right:40.0,left: 40,top: 5,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(width: 5,),
                        Container(
                          height: 32,
                          width: 32,
                          child: InkWell(
                            onTap: (){
                              launchUrl("facebook");
                              //email();
                            },
                            child: Material(
                              elevation: 2,
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(100),
                              child: Center(
                                child:Container(width:20,height: 20,child: Image.asset("assets/icons/facebook.png",color:Colors.white,)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          height: 32,
                          width: 32,
                          child: InkWell(
                            onTap: (){
                              launchUrl("instagram");
                            },
                            child: Material(
                              elevation: 2,
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(100),
                              child: Center(
                                child:Container(width:20,height: 20,child: Image.asset("assets/icons/instagram.png",color: Colors.white,)),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 5,),
                        Container(
                          height: 32,
                          width: 32,
                          child: InkWell(
                            onTap: (){
                              launchUrl("youtube");
                            },
                            child: Material(
                              elevation: 2,
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(100),
                              child: Center(
                                child:Container(width:20,height: 20,child: Image.asset("assets/icons/youtube.png",color: Colors.white,)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          height: 32,
                          width: 32,
                          child: InkWell(
                            onTap: (){
                              share();
                            },
                            child: Material(
                              elevation: 2,
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(100),
                              child: Center(
                                child:Icon(Icons.share,color: Colors.white,size: 20,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
      ),
              ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(right:10.0,left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //  crossAxisAlignment: ,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(1.0),
                              child: Material(
                                elevation: 0,
                                child: InkWell(
                                  onTap:(){
                                    //  share();

                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(1.0),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: Container(width: 20,height: 20,
                                            child: Image.asset("assets/icons/pin.png",  color: Theme.of(context).accentColor,),
                                          ),),
                                        Expanded(
                                            flex: 5,
                                            child: Text("طرابلس - ليبيا",style: GoogleFonts.elMessiri(fontSize: 13),))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:Container(
                              margin: const EdgeInsets.all(1.0),
                              child: Material(
                                elevation: 0,
                                child: InkWell(
                                  onTap:(){
                                    email();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(1.0),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: Container(width: 20,height: 20,

                                            child: Image.asset("assets/icons/plane.png",  color: Theme.of(context).accentColor,),
                                          ),),
                                        Expanded(
                                            flex: 5,
                                            child:  Text("info@hanoot.ly",style: GoogleFonts.elMessiri(fontSize: 13),))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child:Container(
                              margin: const EdgeInsets.all(1.0),
                              child: Material(
                                elevation: 0,
                                child: InkWell(
                                  onTap:(){
                                    //  share();
                                    launchUrl("tel");

                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(1.0),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: Icon(Icons.phone,color: Theme.of(context).accentColor,size: 20,),),
                                        Expanded(
                                            flex: 5,
                                            child:Text("7005 311 91 218+",style: GoogleFonts.elMessiri(fontSize: 13),),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(1.0),
                              child: Material(
                                elevation: 0,
                                child: InkWell(
                                  onTap:(){
                                  //  email();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(1.0),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: Container(width: 20,height: 20,

                                            child: Image.asset("assets/icons/speed.png",  color: Theme.of(context).accentColor,),
                                          ),),
                                        Expanded(
                                            flex: 5,
                                            child:  Text("نحن نعمل على مدار 24 ساعة يوميا",style: GoogleFonts.elMessiri(fontSize: 12),))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      // Center(
                      //   child:   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       InkWell(
                      //           onTap: (){
                      //             launchUrl("Developer");
                      //           },
                      //           child:            Shimmer.fromColors(
                      //               baseColor: Theme.of(context).accentColor,
                      //               highlightColor: Theme.of(context).accentColor.withOpacity(0.8),
                      //               child:Padding(
                      //                 padding: const EdgeInsets.only(right:2.0,left: 2.0),
                      //                 child: Text("Ahmed Gibran",style: GoogleFonts.oswald(fontSize: 12,fontWeight: FontWeight.bold),),
                      //               ))),
                      //       Shimmer.fromColors(
                      //           baseColor: Colors.grey[500],
                      //           highlightColor: Colors.grey[700],
                      //           child:Text("Powered by",style: GoogleFonts.oswald(fontSize: 12,fontWeight: FontWeight.bold),)),
                      //
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),


              ],
              ),
          ),
        ),
        
      );
    });
  }
}
