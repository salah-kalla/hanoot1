import 'package:flutter/material.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/states/homescreen/watches_state.dart';
import 'package:Hanoot/widgets/ProductCard.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_product.dart';
import 'package:Hanoot/widgets/product_list_by_category.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Watches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WatchesState>(
        builder: (context, state, child) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:10,left: 40,top: 10,bottom: 2),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("ساعات",style:GoogleFonts.elMessiri(fontSize: 20)),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductListCategory(categoryId:41,isSeen: true,),
                                fullscreenDialog: true
                            ));
                          },
                          child: Text("اظهار الكل",style:GoogleFonts.elMessiri(color: Theme.of(context).accentColor,fontSize: 15))),

                    ],
                  ),
                ),
              ) ,

              state.isLoading?
              Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,

                  child:
                  ShimmerProduct(horizontal: true,)):state.products.isNotEmpty?
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,

                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 2.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.products.length !=null?state.products.length:0,
                  itemBuilder: (context,index){
                    return

                      Container(
                        width: 130,
                        child: ProductDisplayCard(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailProducts(product:state.products[index]),
                              fullscreenDialog: true
                          ));
                        },
                          product: state.products[index],
                        ),
                      );
                  },
                  separatorBuilder: (context,index)=>SizedBox(width: 0.0,),
                ),
              ):
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,

                child: Center(
                  child: Text("لا يوجد منتجات",textAlign: TextAlign.center,),
                ),
              ),
            ],
          );
        });
  }
}
