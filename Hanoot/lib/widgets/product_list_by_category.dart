import 'package:Hanoot/models/category.dart';
import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/products.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/services/base_services.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/states/categories_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/ProductCard.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_product.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListCategory extends StatefulWidget {
  final int categoryId ;
 bool isSeen = false ;
  final List<Categories> subcategory ;
  ProductListCategory({this.categoryId,this.isSeen,this.subcategory});
  @override
  _ProductListCategoryState createState() => _ProductListCategoryState();
}
class _ProductListCategoryState extends State<ProductListCategory> with AfterLayoutMixin{
  int _page = 1;
  bool endPage = false;
  bool isloading = true;
  List<Product> products=[];
  int categoryLoad ;
  dynamic minPrices=null ;
  dynamic maxPrices=null ;
  dynamic orderBys=null ;

  @override
  void afterFirstLayout(BuildContext context) async {
    onRefreshorders();

  }
  int AxisCount = 2;

  RefreshController refreshController = RefreshController();

  void onRefreshorders() async{
    try{

      setState(() {
        endPage = false;
        isloading = true;
      });
      final list = await Services().fetchProductsByCategory(categoryId: widget.categoryId,page: 1);
      _page = 1 ;
      setState(() {
        endPage = false;
        isloading = false;

        products =  list ;
      });
    }catch(e){
      setState(() {
        isloading = false;

      });
    }
  }
  void _onLoadMore()async{
    try{
      _page = _page+1;
      setState(() {
        endPage = false;
      });

      final list = await Services().fetchProductsByCategory(categoryId: categoryLoad,maxPrice: maxPrices,minPrice: minPrices,orderBy: orderBys,page: _page);
      setState(() {
        if(list.isEmpty)endPage=true ;
        isloading = false;
        products = [...products,...list];
      });


    }catch(e){
    }
    await Future.delayed(Duration(milliseconds: 1500));
    refreshController.loadComplete();
  }
  void _onrefresh() async{

    try{
      setState(() {
        endPage = false;
        //isloading = true;
         minPrices=null ;
         maxPrices=null ;
         orderBys=null ;
      });
      final list = await Services().fetchProductsByCategory(categoryId: widget.categoryId,minPrice: null,maxPrice: null,orderBy: null,page: 1);
      _page = 1 ;
      setState(() {
        products =  list ;
        isloading = false;

      });
    }catch(e){
      setState(() {
        isloading = false;
      });
    }
    await Future.delayed(Duration(milliseconds: 1500));
    refreshController.refreshCompleted();
  }
  void _FilterRefrech({categoryId, page, minPrice, maxPrice, orderBy, lang, order})async{
    try{
      setState(() {
        endPage = false;
        isloading = true;

      });
      final list = await Services().fetchProductsByCategory(categoryId:categoryId,page: page,minPrice: minPrice,maxPrice: maxPrice);
      _page = 1 ;
      setState(() {
        endPage = false;
        isloading = false;
        categoryLoad =categoryId ;
        maxPrices =maxPrice ;
        minPrices =minPrice ;
        orderBys =orderBy ;
        products =  list ;
      });
    }catch(e){
      setState(() {
        isloading = false;
      });
    }
  }
  void indexAxisCount({int index}){
    setState(() {
      AxisCount = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    categoryLoad = widget.categoryId;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CategoriesState state = Provider.of<CategoriesState>(context,listen: false);
    return Scaffold(
        appBar:(widget.isSeen==true&&widget.isSeen!=null)?
      AppBar(
        elevation: 4,
        title:Text("جميع المنتجات"),
        centerTitle: true,
        actions: <Widget>[
          Consumer<CartState>(builder: (context,stateCart,child){
            return Transform.scale(
              scale: 1,
              child:
              IconButton(
                onPressed: (){
                 Provider.of<AppState>(context,listen: false).setScreenIndex(3);
                 Navigator.of(context).pop();
                },
                icon:     Badge(
                    elevation: 0,
                    position: BadgePosition.topStart(top: 0,start: 0),
                    padding: EdgeInsetsDirectional.only(start: 4,end: 4,),
                    showBadge: stateCart.cartProducts.length!=0||stateCart.cartProducts.length!=null,
                    badgeContent: Text("${stateCart.cartProducts.length<10&&stateCart.cartProducts.length!=null?stateCart.cartProducts.length:"+10"}",
                      style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 8),
                    ),
                    badgeColor: Colors.redAccent.withOpacity(0.8),
                    animationType: BadgeAnimationType.scale,
                    child: Shimmer.fromColors(
                        baseColor: Theme.of(context).accentColor.withOpacity(0.8), highlightColor: Theme.of(context).accentColor,
                        child: Icon(Icons.shopping_basket,))),

              ),
            );

          },),
        ],

      ):null,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: isloading?
          ShimmerProduct(horizontal: false,):(products.isEmpty)?
           Center(
             child: Container(
               height: 150,
               width: 150,

               child: Image.asset("assets/icons/wind.png",color: Theme.of(context).accentColor.withOpacity(0.5),),
             ),
           )   
          :SmartRefresher(

            enablePullDown: true,
            enablePullUp: !endPage,
            onRefresh: _onrefresh,
            onLoading: ()=>_onLoadMore(),
            header: WaterDropHeader(),
            footer: CustomFooter(builder: (context,status){
              if(status==LoadStatus.loading){
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Center(
                    child: Text(" ... جاري التحميل"),
                  ),
                );
              }

              return Container(

              );                              }),
            controller: refreshController,
            child:ListView(
              children: <Widget>[

                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    childAspectRatio: AxisCount==3?0.6:0.65,
                    crossAxisCount: AxisCount,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,

                  ),


                  itemBuilder: (context, index)=>

                      ProductDisplayCard(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailProducts(product:products[index]),
                            fullscreenDialog: true
                        ));
                      },
                        product: products[index],
                      ),

//                    Text(state.products[index].inStock.toString()),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,

                ),
              ],
            )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _onShowFilter(state);
      },

      child: Icon(Icons.filter_list),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  Future _onShowFilter(CategoriesState state)async{
    showModalBottomSheet(context: (context), builder: (context){
      return Container(
           color: Color(0xFF737373),
           child:Container(
            padding: EdgeInsets.all(8),
            child: Filter(state: state,onPressed: _FilterRefrech,subcategory: widget.subcategory,categorId: widget.categoryId,indexCount: indexAxisCount,index: AxisCount,),decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
        ),
        ),
      );
    },

    );
  }

}
class Filter extends StatefulWidget {
  final CategoriesState state ;
   final  int index;
   final  int categorId;
  final List<Categories> subcategory ;
  final Function onPressed,indexCount ;
  const Filter({Key key, this.state,this.subcategory, this.onPressed,this.indexCount,this.index,this.categorId}) : super(key: key);
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> with TickerProviderStateMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
 int AxisCount = 2 ;
  @override
  void initState() {
    this.AxisCount = widget.index;
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }
  var categoryIndexSelected = -1 ;
  var minPrice=0.0 ,maxPrice=2000.0 ;
  var selectPrice = RangeValues(0.0, 1500);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (context,child)=>
            SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:8.0,left: 8.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.view_list,color: AxisCount==1?
                  Theme.of(context).accentColor:Colors.grey,size: AxisCount==1?30:null,), onPressed: (){
                    setState(() {
                      AxisCount =1 ;
                      widget.indexCount(index:1);
                    });
                  }),
                  InkWell(child: Container(
                      height:AxisCount==2?20: 17,
                      width: AxisCount==2?20:17,
                      child: Image.asset("assets/icons/grid.png",color: AxisCount==2?
                      Theme.of(context).accentColor:Colors.grey)), onTap: (){
                    setState(() {
                      AxisCount=2;
                      widget.indexCount(index:2);
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
                      widget.indexCount(index:3);
                    });
                  })
                ],
              ),
            ),
            Container(
              height: 30,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Transform(
                      transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                      child: Text("ترتيب العناصر حسب :",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),)),
                  Transform(
                      transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                      child: Icon(Icons.filter_list,color: Theme.of(context).accentColor)),
                ],
              ),
            ),
            SizedBox(height: 2,),
            if(widget.subcategory!=null)
              Transform(
                transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
                child: Align(alignment: Alignment.centerRight,
                  child:Text("التصنيف",textAlign: TextAlign.right,style: GoogleFonts.elMessiri(color: Colors.black),),
                ),
              ),
            Padding(padding: EdgeInsets.all(2),
                child:Divider(height: 1,color: Colors.grey,)
            ),
            Transform(
              transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
              child: Wrap(
                children: <Widget>[

                  if( widget.state.isLoading)
                    Container(),
                  if( widget.subcategory!=null)
                      Wrap(
                        children: <Widget>[
                          for(int index = 0;index<widget.subcategory.length;index++)
                            InkWell(
                              onTap: (){
                                setState(() {
                                  categoryIndexSelected=index;
                                });
                              },
                              child: Container(
                                width: 100,
                                height: 18,
                                padding: EdgeInsets.all(0),

                                constraints: BoxConstraints(
                                  minWidth: Constants.screenAwareSize(30, context),
                                  minHeight: Constants.screenAwareSize(23, context),
                                ),
                                margin: EdgeInsets.only(right: 4,left: 4,top: 2,bottom: 2),
                                decoration: BoxDecoration(
//                                    boxShadow: [
//                                      BoxShadow(
//                                        color: Colors.grey.withOpacity(0.4),
//                                        offset: Offset(0.0, 0.1), //(x,y)
//                                        blurRadius: 6.0,
//                                      ),],
                                    color: categoryIndexSelected==index?Theme.of(context).accentColor:Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:categoryIndexSelected==index?Colors.white:Theme.of(context).accentColor
                                    )
                                ),
                                child: Center(
                                  child: Text(widget.subcategory[index].name,textAlign:TextAlign.center,
                                    style: GoogleFonts.elMessiri(color: categoryIndexSelected==index?
                                    Colors.white:Theme.of(context).accentColor,fontSize: 11),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )

                ],
              ),
            ),
            SizedBox(height: 5,),
            Transform(
              transform: Matrix4.translationValues(afterAnimation.value*width, 0.0, 0.0),
              child: Align(alignment: Alignment.centerRight,
                child:Text("السعر",textAlign: TextAlign.right,style: GoogleFonts.elMessiri(color: Colors.black),),
              ),
            ),
            Padding(padding: EdgeInsets.all(8),
                child:Divider(height: 1,color: Colors.grey,)
            ),
            Transform(
              transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
              child: Container(
                height: 50,
                child:Row(
                  children: <Widget>[
                    Expanded(child: Text("${minPrice} "+"د،لـ",style: GoogleFonts.elMessiri(fontSize: 10,color: Colors.grey),),flex: 1,),
                    Expanded(child: RangeSlider(values: selectPrice, onChanged: (RangeValues newRange){
                      setState(() {
                        selectPrice = newRange ;
                        minPrice=newRange.start;
                        maxPrice=newRange.end;
                      });
                    },
                      activeColor: Theme.of(context).accentColor,
                      inactiveColor: Theme.of(context).accentColor.withOpacity(0.3),
                      min: 0.0,
                      max: 2000,
                      divisions: 20,
                      labels: RangeLabels(" ${selectPrice.start.toInt()} "+"د،لـ", " ${selectPrice.end.toInt()} "+"د،لـ"),
                    ) ,flex: 6,),
                    Expanded(child: Text("${maxPrice.toInt()} "+"د،لـ",style: GoogleFonts.elMessiri(fontSize: 10,color: Colors.grey),),flex: 1,),

                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  height: 30,
                  margin: EdgeInsets.all(5),
                  child: Material(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 4,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        widget.onPressed(categoryId:(categoryIndexSelected!=-1&&widget.subcategory!=null)?
                        widget.subcategory[categoryIndexSelected].id:widget.categorId,minPrice: minPrice,maxPrice:maxPrice,page:1);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor:Colors.white.withOpacity(0.7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("تطبيق",style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                              SizedBox(width: 10,),
                              Icon(Icons.filter_list,color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            )

          ],

        ),
      ),
    )
    );
  }
}
