import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCardUI extends StatefulWidget {
 // final double fontsize ;
  final  Function onPressed ;
  Categories category ;
  CategoryCardUI({this.category,this.onPressed});

  @override
  _CategoryCardUIState createState() => _CategoryCardUIState();
}

class _CategoryCardUIState extends State<CategoryCardUI> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: animationController,
        builder: (context,child)=>InkWell(
          onTap: (){
            widget.onPressed();
          },
          child: Transform(
            transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
            child: Container(
              margin: EdgeInsets.all(2),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [Colors.transparent,Constants.lightBG.withOpacity(.09)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter

                ),
              ),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Padding(padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width:80,
                          height:80 ,
                          padding: EdgeInsets.only(top:10,right: 4,left: 4,bottom: 4),
                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              image:
                              DecorationImage(

                                  fit: BoxFit.fill,
                                  image: ExtendedNetworkImageProvider(
                                    widget.category.image,
                                    cache: true,
                                  ))
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("${widget.category.name}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.elMessiri(
                            fontSize:  Constants.screenAwareSize(10, context),
                           //   fontWeight: FontWeight.bold,
                              // backgroundColor: ,
                              color: Theme.of(context).accentColor

                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              )
            ),
          ),
        ));
  }
}
