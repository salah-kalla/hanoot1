import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/screens/product_list_screen.dart';
import 'package:Hanoot/states/categories_state.dart';
import 'package:Hanoot/widgets/home_screen/Lists/suppliers.dart';
import 'package:flutter/material.dart';
class Supplier_Screen extends StatefulWidget {
  final CategoriesState state;

  const Supplier_Screen({ this.state});

  @override
  _Supplier_ScreenState createState() => _Supplier_ScreenState();
}

class _Supplier_ScreenState extends State<Supplier_Screen> {
  int AxisCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الموردين"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:8.0,left: 8.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.view_list,color: AxisCount==1?
                  Theme.of(context).accentColor:Colors.grey,size: AxisCount==1?30:null,), onPressed: (){
                    setState(() {
                      AxisCount =1 ;
                    });
                  }),
                  InkWell(child: Container(
                      height:AxisCount==2?20: 17,
                      width: AxisCount==2?20:17,
                      child: Image.asset("assets/icons/grid.png",color: AxisCount==2?
                      Theme.of(context).accentColor:Colors.grey)), onTap: (){
                    setState(() {
                      AxisCount=2;
                    });
                  }),
                  SizedBox(width: 10,),
                  InkWell(child: Container(
                      height:AxisCount==3?20: 17,
                      width: AxisCount==3?20:17,
                      child: Image.asset("assets/icons/grid3.png",color: AxisCount==3?
                      Theme.of(context).accentColor:Colors.grey)), onTap: (){
                    setState(() {
                      AxisCount=3;
                    });
                  })
                ],
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                childAspectRatio:AxisCount==2?1.0:AxisCount==3?1:1.5,
                crossAxisCount: AxisCount,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,

              ),


              itemBuilder: (context, index)=>

                  Container(
                    width: 150,
                    height: 130,
                    child: Suppliers(
                      onPressed: (){
                        List<Categories> sub = widget.state.supplierCategories.where((item) => item.parent==widget.state.supplierCategories[index].id&&item.count>0).toList() ;
                        for(var item in sub){

                        }
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>     ProductListScreen(category:widget.state.supplierCategories[index],subcategory: sub,),
                            fullscreenDialog: true
                        ));
                      },
                      category: widget.state.supplierCategories[index],
                    ),
                  ),

              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.state.supplierCategories.length,

            ),
          ],
        ),
      ),
    );
  }
}
