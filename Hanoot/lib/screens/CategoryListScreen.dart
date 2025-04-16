import 'package:Hanoot/widgets/category/categoryList_card_ui.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/screens/product_list_screen.dart';
import 'package:Hanoot/states/categories_state.dart';
import 'package:Hanoot/widgets/ShimmerList.dart';
import 'package:provider/provider.dart';
class CategoryListScreen extends StatefulWidget {
  CategoriesState state ;
  String title ;
  CategoryListScreen({this.state,this.title});

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  int AxisCount = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final CategoriesState state = Provider.of<CategoriesState>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("التصنيفات",textAlign: TextAlign.center,),

        ),
        body: state.isLoading?
        ShimmerList():
        state.parentCategory!=null? SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use children total size
              children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),

                    itemCount : state.parentCategory.length,
                    shrinkWrap: true, // Use  children total size
                    itemBuilder : (context, index)=>Container(
                      padding: const EdgeInsets.only(top:0.0,bottom: 0.0,right: 4.0,left: 4.0),
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: CardListCategory(fontsize: AxisCount==1?23:18,
                        category: state.parentCategory[index],
                        onPressed:(){
                          List<Categories> sub = state.category.where((item) => item.parent==state.parentCategory[index].id&&item.count>0).toList() ;
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>     ProductListScreen(category:state.parentCategory[index],statecart: state,subcategory: sub,),
                              fullscreenDialog: true
                          ));
                        },
                      ),
                    )
                )
              ],
            )
        ):
            Container()
      ),
    );
  }
}
