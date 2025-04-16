import 'package:flutter/material.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class VariantChooser extends StatefulWidget {
  final String title ;
  final List options ;
  VariantChooser({this.title,this.options});
  @override
  _VariantChooserState createState() => _VariantChooserState();
}

class _VariantChooserState extends State<VariantChooser> {
  int selectedIndex = -1 ;
  int time = 1000;
  int offset = 50 ;
  Color baseColor, highlightColor, borderColor, accentColor ;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailState>(context);
    final theme = Theme.of(context);
    baseColor = theme.iconTheme.color;
    highlightColor = theme.primaryColor;
    accentColor = theme.accentColor.withOpacity(.85);
    borderColor = theme.textTheme.title.color.withOpacity(.7);
    return Container(
      height: Constants.screenAwareSize(33, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Padding(padding: const EdgeInsets.all(8.0),
          child: Text(widget.title),

          ),
          flex: 1,
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: widget.options.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_,index){
               offset+=80;
               time+=offset;
               return state.isVariantsLoading?
                   buildLoadingContainers(index,time):
                   buildVariantContainer(state,index);
              }),
          ),
        ],
      ),
    );
    return Container();
  }
  Widget buildLoadingContainers(pos,time){
    return Shimmer.fromColors(
        child: Container(
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(
            minWidth: Constants.screenAwareSize(30, context),
            minHeight: Constants.screenAwareSize(30, context),
          ),
          margin: EdgeInsets.only(right: 4,left: 4,top: 8,bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),

            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text("${widget.options[pos]}"),
          ),

          ),
        baseColor: baseColor,
        highlightColor: highlightColor,
      period: Duration(milliseconds: time),
        );
  }
  Widget buildVariantContainer (state,index){
    return GestureDetector(
      onTap: (){
        state.changeAttributesTo(widget.title,widget.options[index]);
        selectedIndex= index ;
        setState(() {
        });
      },
      child: Container(
        padding: EdgeInsets.all(0),
        constraints: BoxConstraints(
          minWidth: Constants.screenAwareSize(30, context),
          minHeight: Constants.screenAwareSize(30, context),
        ),
        margin: EdgeInsets.only(right: 4,left: 4,top: 8,bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedIndex==index?accentColor:borderColor

          )
        ),
        child: Center(
          child: Text("${widget.options[index]} ",textAlign: TextAlign.center,style: GoogleFonts.elMessiri(color:  selectedIndex==index?accentColor:borderColor),),
        ),
      ),
    );
  }
}
