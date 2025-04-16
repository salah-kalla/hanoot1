import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatefulWidget {
  final double fontsize ;
  final  Function onPressed ;
  Categories category ;
  CategoryCard({this.category,this.onPressed,this.fontsize});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            gradient: LinearGradient(colors: [Colors.transparent,Constants.lightBG.withOpacity(.1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter

            ),
          ),
          child: Container(
            width: 200,
            height:200 ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),

            ),
            margin:EdgeInsets.all(0) ,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),

              child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(100),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                               borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child:  Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height ,
                                margin: EdgeInsets.all(0),
                                decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    image: DecorationImage(

                                        fit: BoxFit.fill,
                                        image: ExtendedNetworkImageProvider(
                                          widget.category.image,
                                          cache: true,
                                        ))
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(height: Constants.screenAwareSize(2, context),),
                        ],
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                 color:Colors.black12.withOpacity(0.5),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Container(
                                    margin:const EdgeInsets.only(bottom: 5.0) ,
                                    alignment: Alignment.center,
                                    child: Text("${widget.category.name}",  style: GoogleFonts.elMessiri(fontSize: widget.fontsize,
                                        fontWeight: FontWeight.bold,
                                       // backgroundColor: ,
                                        color: Colors.white

                                    ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  )
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
