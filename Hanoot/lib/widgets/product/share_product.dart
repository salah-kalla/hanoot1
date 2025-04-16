import 'package:flutter_share/flutter_share.dart';
import 'package:Hanoot/models/products.dart';
import 'package:flutter/material.dart';

class ShareProduct extends StatefulWidget {
  final Product product ;

  const ShareProduct({Key key, this.product}) : super(key: key);

  @override
  _ShareProductState createState() => _ShareProductState();
}

class _ShareProductState extends State<ShareProduct> {
  Future<void> share() async {
    await FlutterShare.share(
        title: '${widget.product.permalink}',
        text: ' ',
        linkUrl: '${widget.product.permalink}',
        chooserTitle: ''
    );
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
      return IconButton(
          onPressed: () {
            setState(() {
              share() ;
            });
          },
          icon: Container(
            height: 45,
            width: 65,
            decoration: BoxDecoration(
               color: Colors.black,

              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.share,
                color:Theme.of(context).accentColor),
          )
      );

  }
}
