import 'package:Hanoot/models/category.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/strings.dart';

class CardListCategory extends StatefulWidget {
  final double fontsize ;
  final  Function onPressed ;
  Categories category ;
  CardListCategory({this.category,this.onPressed,this.fontsize});
  @override
  _CardListCategoryState createState() => _CardListCategoryState();
}

class _CardListCategoryState extends State<CardListCategory>  {
  // Animation animation,afterAnimation ;
  // AnimationController animationController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    // animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    // afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    // animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onPressed();
      },
      child: Container(
        padding: EdgeInsets.only(right:5.0,left:15.0,top: 6,bottom: 6.0),
        child:  Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            height: 90,
            width: MediaQuery.of(context).size.width-10.0,
            padding: EdgeInsets.only(left: 2,right: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${(isNotEmpty(widget.category.name)||widget.category.name!=null)?widget.category.name:''}",    softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.elMessiri(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(right:8.0,left: 8,top: 4,bottom: 4),
                    margin: EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom: 2.0),
                    height: 80,
                    width: 70,
                    decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(15.0),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color:Theme.of(context).accentColor.withOpacity(0.5)),
                        //   border: BoxBorder()
                        image: DecorationImage(

                            fit: BoxFit.fill,
                            image: ExtendedNetworkImageProvider(
                              (isNotEmpty(widget.category.image)||widget.category.image!=null)?widget.category.image:'',
                              cache: true,
                            ))
                    ),
//                              child:  ExtendedImage.network(widget.category.image,
//                                cache: true,
//                                fit:BoxFit.cover,
//                              ),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}