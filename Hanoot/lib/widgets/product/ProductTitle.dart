import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitle extends StatefulWidget {
  final Product product;
  ProductTitle(this.product);

  @override
  _ProductTitleState createState() => _ProductTitleState();
}

class _ProductTitleState extends State<ProductTitle> with AfterLayoutMixin{
  bool loading = true ;
  Services services = Services();
  Future getAuthor ()async{
    try{

      await services.getAuthor(id: widget.product.id);
      setState(() {
        loading = false ;
      });
    }catch(e){
      setState(() {
        loading = false ;
      });
    }
  }



  @override
  void afterFirstLayout(BuildContext context) {
   getAuthor();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final DetailState state = Provider.of<DetailState>(context);
    ProductVariation variation = state.currentVariation ;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex:8,
                child: Container(
                // width: MediaQuery.of(context).size.width,
                child: Text(widget.product.name,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
               //   style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold),
                ),
              ),),
              Spacer(),
              Expanded(
                  flex: 3,
                  child:  Text(variation==null?widget.product.price+" "+"د لـ ":variation.price+" "+"د لـ ",textAlign: TextAlign.left,
                  style: GoogleFonts.elMessiri(
                      fontSize: 22,
                   //   fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                  ),
                ),)
            ],
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: <Widget>[


            Container(
               // height: 30,
                 width: 60,
                 padding: EdgeInsets.all(4.0),
                 decoration: BoxDecoration(
                     color:Theme.of(context).accentColor,
                     borderRadius: BorderRadius.all(Radius.circular(10))
                 ),
                 child:  Row(
                   children: <Widget>[
                     Expanded(flex: 1,
                       child: Text("${widget.product.averageRating}",style:
                       GoogleFonts.elMessiri(fontSize: 14,color: Colors.white),textAlign: TextAlign.center,),
                     ),
                     Expanded(child:  Icon(Icons.star,color: Colors.white,size: 15,),flex: 1,)
                   ],
                 )
             ),

          ],
        ),

        ),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Expanded(
//              flex:8,
//              child: Container(
//                // width: MediaQuery.of(context).size.width,
//                child: Text(widget.product.name,
//                  softWrap: false,
//                  overflow: TextOverflow.ellipsis,
//                  style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold),
//                ),
//              ),),
//            Expanded(
//              flex: 3,
//              child:  Text(variation==null?widget.product.price+" "+"د لـ ":variation.price+" "+"د لـ ",textAlign: TextAlign.left,
//                style: GoogleFonts.elMessiri(
//                    fontSize: 22,
//                    color: Theme.of(context).primaryColor
//                ),
//              ),)
//
//          ],
//        ),
      ],
    );
  }


}
