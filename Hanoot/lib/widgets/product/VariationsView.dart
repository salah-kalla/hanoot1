
import 'package:flutter/material.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/widgets/product/ColorChooser.dart';
import 'package:Hanoot/widgets/product/DefaultChooser.dart';
import 'package:Hanoot/widgets/product/VariantChooser.dart';
class VariationsView extends StatelessWidget {
final Product product ;
VariationsView(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: product.attribute.map((value){
        if(value.name=="SIZE"||value.name=="size")
          return VariantChooser(
            title: value.name,
            options: value.options,
          );
        else if (value.name=="COLOR"||value.name=="color"||value.name=="colour"||value.name=="COLOUR")
          return ColorChooser(
            title: value.name,
            options: value.options,
          );
        return DefaultChooser(
          title: value.name,
          options: value.options,
        );
      }).toList(),
    );
  }
}
