import 'package:flutter/material.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:Hanoot/utils/color.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ColorChooser extends StatefulWidget {
  final String title;
  final List options ;
  ColorChooser({this.options,this.title});

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  int selectedIndex = -1 ;
  int time = 1000;
  int offset = 50 ;
  bool isSafe = true ;
  var index = 0 ;

  Color baseColor, hightlightColor, borderColor, accentColor ;

  @override
  Widget build(BuildContext context) {
    widget.options.forEach((value){
      value = value.replaceAll(" "," ").toLowerCase();
      if(colors.containsKey(value)==false){
        setState(() {
          isSafe = false ;
        });
      }

    });
    final state = Provider.of<DetailState>(context);
    final theme = Theme.of(context);
    baseColor = theme.iconTheme.color;
    hightlightColor=theme.primaryColor;
    accentColor = theme.accentColor.withOpacity(.85);
    borderColor = theme.textTheme.title.color.withOpacity(.7);
    return Container(
      height: Constants.screenAwareSize(40, context),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Padding(padding: const EdgeInsets.all(8.0),
          child: Text(widget.title),),
            flex: 1,
          ),
          Expanded(

            child:ListView.builder(itemCount: widget.options.length,
          shrinkWrap: true,
            scrollDirection: Axis.horizontal,
              itemBuilder:(_,pos){

            return state.isVariantsLoading?Container(width: 33,height: 20,
              padding: EdgeInsets.only(right: 1,left: 1,top: 11,bottom: 11),
              child: buildLoadingContainers(pos),):
            Container(width: 33,height: 20,
              padding: EdgeInsets.only(right: 1,left: 1,top: 11,bottom: 11),
              child: buildVariantContainers(state,pos),)
              ;

              }
          ),
            flex: 4,
          ),
        ],
      ),
    );
  }
  Widget buildLoadingContainers(pos){
    return Shimmer.fromColors(child: Center(
      child:  Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50)
        ),
      ),
    ), baseColor: colorss["${widget.options[pos].toString().toLowerCase()}"].withOpacity(0.4), highlightColor:colorss["${widget.options[pos].toString().toLowerCase()}"],
    period: Duration(milliseconds: time),
    );
  }
  Widget buildVariantContainers(state,pos){
  return  InkWell(

      onTap: (){
        state.changeAttributesTo(widget.title,widget.options[pos]);
        selectedIndex = pos ;
        setState(() {

        });
      },
      child:Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
                border: Border.all(color: selectedIndex==pos?accentColor:Colors.grey[200]),

            color: colorss["${widget.options[pos].toString().toLowerCase()}"].withOpacity(0.8),
            borderRadius: BorderRadius.circular(50)
        ),
      ),



    );

  }
}

class SemiClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

  final path = Path();
//  path.lineTo(size.width, 0.0);
//  path.lineTo(size.width/2, size.height);
  path.close();
    // TODO: implement getClip
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}