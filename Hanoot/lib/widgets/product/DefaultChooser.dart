import 'package:flutter/material.dart';
import 'package:Hanoot/states/detail_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultChooser extends StatefulWidget {
  final String title ;
  final List options ;
  DefaultChooser({this.options,this.title});
  @override
  _DefaultChooserState createState() => _DefaultChooserState();
}

class _DefaultChooserState extends State<DefaultChooser> {
  int index = 0 ;
    String value = "SELECT";
    _DefaultChooserState();

  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);

    return GestureDetector(
      onTap: ()async{
        if(state.isVariantsLoading)return;
        var result = await _showOptions(widget.options,state);
        if(result!=null){
          value = result ;
          state.changeAttributesTo(widget.title, value);
          setState(() {

          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: Constants.screenAwareSize(25, context),
              width: Constants.screenAwareSize(50, context),
              child: Center(
                child: Text(widget.title,
                softWrap: true,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.elMessiri(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: Constants.screenAwareSize(25, context),
              width: Constants.screenAwareSize(50, context),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600]),

              ),
              child: Center(
                child: Text(value,
                softWrap: true,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.elMessiri(
                    fontWeight: FontWeight.w600,
                    decorationColor: Theme.of(context).textTheme.title.color,
                    decoration: state.isVariantsLoading?TextDecoration.lineThrough:TextDecoration.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showOptions(List options, DetailState state){
    return showModalBottomSheet(
      context:context,
      builder: (context){
return SafeArea(
  child:Column(
    mainAxisSize: MainAxisSize.min,
    children: options.map((value)=>ListTile(
      onTap: (){
        Navigator.of(context).pop(value);
      },
      title: Center(
        child: Text(value),

      ),
    )).toList(),
  ) ,
);
      }

    );
  }
}

