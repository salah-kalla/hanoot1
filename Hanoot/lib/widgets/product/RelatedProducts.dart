import 'package:Hanoot/models/products.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package:Hanoot/services/base_services.dart';
import 'package:google_fonts/google_fonts.dart';

class RelatedProduct extends StatelessWidget {
  final Product product ;
  RelatedProduct(this.product);
  final _memoizer = AsyncMemoizer<List<Product>>();
  final services = Services();
  @override
  Widget build(BuildContext context) {
    Future<List<Product>> getRelativeProducts()=> _memoizer.runOnce((){
      return services.fetchProductsByCategory(
        categoryId: product.categoryId,
      );
    });
    return FutureBuilder<List<Product>>(
        future: getRelativeProducts(),
        builder: (BuildContext context, AsyncSnapshot <List<Product>> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
            return Container(
              height: 100,
              child: CircularProgressIndicator(),
            );
            case ConnectionState.done:
              if(snapshot.hasError){
                return Container(
                  height: 100,
                  child: Center(
                    child: Text("Error: ${snapshot.error}",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),),
                  ),

                );
              }else if(snapshot.data.length==0){
                return Container();
              }else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.symmetric(vertical: 18.0),
                    child: Text("You might like",
                    style: GoogleFonts.elMessiri(fontSize: 17,color: Theme.of(context).accentColor),
                    ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width*0.7,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
//                          for(var item in snapshot.data)
//                            if(item.id!=product.id)
//                              ProductDisplayCard(onPressed: (){},
//                              product: item,)

                        ],
                      ),
                    )
                  ],
                );
              }


          }
          return Container();
        });
  }
}
