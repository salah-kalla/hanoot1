import 'package:flutter/material.dart';
import 'package:Hanoot/main.dart';
import 'onboarding_model.dart';
import 'single_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double ScreenWidth, Screenheight;
  PageController pageController=PageController(
    initialPage: 0,
  );
  int currentIndex = 0 ;
  bool lastpage = false ;
  List<OnBoardingModel> screens = [
    OnBoardingModel(
        image: 'assets/on1.png',
        title: 'تسوق كل ماهو جديد',
        description:
        "الآن يمكنك التسوق وشراء ماتريد خلال خطوات بسيطه"),
    OnBoardingModel(
        image: 'assets/on4.png',
        title: "طلبك يوصلك لباب بيتك",
        description:
        "تتم عمليات التوصيل وتجهيز الطلبات في أسرع وقت ممكن "),
    OnBoardingModel(
        image: 'assets/on3.png',
        title: "استمتع بمشاهدة أخر العروض",
        description: "يمكنك الوصول لقسمك المفضل وتصفح منتجاته بكل سهولة، كما يمكنك مشاهدة أخر العروض والتخفيضات المتاحة ")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double md = MediaQuery.of(context).size.height * 0.02;
    Screenheight = MediaQuery.of(context).size.height;
    ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: md),
              height: Screenheight,
              width: ScreenWidth,
              child: PageView.builder(
                controller: pageController,
                itemCount: screens.length,
                itemBuilder: (BuildContext context, int postion) {
                  return SingleOnBoarding(screens[postion]);
                },
                onPageChanged: (int index){
                  setState(() {
                    currentIndex=index ;
                    if(index==(screens.length-1)){
                      lastpage = true ;
                    }else{
                      lastpage = false ;

                    }
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -(Screenheight*0.1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              _drowDot(screens.length),

            ),
          ),
          (lastpage)?_drowbutton() :Container(),
        ],
      ),
    );
  }
  List<Widget> _drowDot(int qyt){
    List<Widget> widgets = [] ;
    for(int i =0 ; i <qyt ; i++){
      widgets.add(
        Container(
          decoration: BoxDecoration(
            color: (i==currentIndex)?Theme.of(context).accentColor:Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 5,
          width: 30,
          margin: (i==qyt-1)?EdgeInsets.only(right: 20):EdgeInsets.only(right: 20),
        ),
      );
    }
    return widgets ;
  }
  Widget _drowbutton(){
    return Container(
      child: Transform.translate(
        offset: Offset(0, -(Screenheight * 0.06)),
        child: SizedBox(
          width: ScreenWidth*0.55,
          height: 40,
          child: RaisedButton(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
            color:Theme.of(context).accentColor,
            onPressed:() async{
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setBool("is_seen", true);
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
                ModalRoute.withName('/'),
              );

            },
            child: Text("ابدا",style: GoogleFonts.elMessiri(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 3 ,
              fontWeight: FontWeight.bold,
            ),),
          ),
        ),
      ),
    );
  }

}
