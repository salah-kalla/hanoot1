import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Suppliers extends StatefulWidget {
 final Function onPressed;
final Categories category ;

 const Suppliers({Key key, this.onPressed,this.category}) : super(key: key);
  @override
  _SuppliersState createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 700));
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
          onTap:widget.onPressed ,
          child: Transform(
            transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
            child:Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.transparent,Constants.lightBG.withOpacity(.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter

                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width:80,
                  height:80 ,
                  padding: EdgeInsets.only(top:10,right: 4,left: 4,bottom: 5),
                  decoration: BoxDecoration(

//                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      image:
                      DecorationImage(

                          fit: BoxFit.fill,
                          image: ExtendedNetworkImageProvider(
                            widget.category.image,
                            cache: true,
                          )

                      ),

                  ),
                  child:   Align(alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.maxFinite,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.transparent,Constants.lightBG.withOpacity(.1)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ),
                        ),
                        child: Text("${widget.category.name}",textAlign:TextAlign.center,style: GoogleFonts.elMessiri(color: Theme.of(context).primaryColor,fontSize: 12),)),
                  ),
                ),
              ),
            )


          ),
        ));
  }
}
