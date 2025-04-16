import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatelessWidget {
  final Function onTap,onRemovePressed,onPrimaryButtonPressed,ClearItem,RemoveQuantity,AddQuantity;
  final String primaryTitle ;
  final Product product ;
  final ProductVariation productVariation ;
  final int quantity ;
  //final WishListBool = true ;
  CartItem({this.productVariation,this.product,this.quantity,
  this.onPrimaryButtonPressed,this.onRemovePressed,this.onTap,this.primaryTitle, this.ClearItem,this.RemoveQuantity,this.AddQuantity
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: ExtendedImage.network(product.imageFeature,
          cache: true,
            fit:BoxFit.contain,
            constraints: BoxConstraints(
              maxHeight: Constants.screenAwareSize(60, context),
              maxWidth: Constants.screenAwareSize(60, context),

            ),

          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (productVariation == null)?Text(""):Text("$productVariation"),

Row(
  children: <Widget>[
    IconButton(icon: Icon(Icons.remove,color: Colors.redAccent,), onPressed: RemoveQuantity,),
    Text("Qty: $quantity"),
    IconButton(icon: Icon(Icons.add,color: Colors.green,), onPressed: AddQuantity,),

  ],
),
              Text("DL ${product.price}",
                style: GoogleFonts.elMessiri(fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          title: Text(
            product.name,
            style: GoogleFonts.elMessiri(
             // fontFamily: ""
              fontWeight: FontWeight.w400,
            ),

          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(icon: Icon(Icons.delete,color: Colors.redAccent,), onPressed: ClearItem,),


            ],
          ),
          isThreeLine: true,
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 2),
        child: Row(
          children: <Widget>[

            Expanded(
                child: RawMaterialButton(onPressed: onRemovePressed,
                child: Text("حذف"),
                ),

            ),
            Expanded(child: RawMaterialButton(onPressed: onPrimaryButtonPressed,
            fillColor: Theme.of(context).accentColor,
//              child: Text("$primaryTitle"),
              child: Text("اضف الى المفضلة"),
              textStyle: GoogleFonts.elMessiri(color: Colors.white),
              elevation: 0,
            ))
          ],
        ),
        )
        ,SizedBox(
          height: Constants.screenAwareSize(15, context),
        )
      ],
    );
  }
}
