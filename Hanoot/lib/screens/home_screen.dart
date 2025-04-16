import 'package:Hanoot/screens/suppliers_list.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/widgets/category/categor_card_ui.dart';
import 'package:Hanoot/widgets/home_screen/Lists/household.dart';
import 'package:Hanoot/widgets/home_screen/Lists/suppliers.dart';
import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/routes/name_routers.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/screens/product_list_screen.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/categories_state.dart';
import 'package:Hanoot/states/home_state.dart';
import 'package:Hanoot/states/wishlist_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/ProductCard.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_category.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_product.dart';
import 'package:Hanoot/widgets/home_screen/Lists/vegetables.dart';
import 'package:Hanoot/widgets/home_screen/banner/banner_items.dart';
import 'package:Hanoot/widgets/menu_side_bar.dart';
import 'package:Hanoot/widgets/product_list_by_category.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin{
  ScrollController _scrollController =ScrollController();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  void onRefreshProducts()async{
    Provider.of<HomeState>(context,listen: false).getProducts();
  }
  _RefreshProducts()async{
    Provider.of<HomeState>(context,listen: false).getProducts();
    Future.delayed(Duration(milliseconds: 1500));
    refreshController.refreshCompleted();
  }
  _loadMoreProducts()async{
    Provider.of<HomeState>(context,listen: false).loadMoreProducts();
    Future.delayed(Duration(milliseconds: 1500));
    refreshController.loadComplete();
  }
  @override
  void afterFirstLayout(BuildContext context) {
    onRefreshProducts();
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
    });

  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context)  {
    return  Consumer<HomeState>(builder: (context,stateProduct,child){
      return SafeArea(child: Scaffold(
        key: _scaffoldKey,
        drawer: MenuSideBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          elevation: 0,
          leading:  Transform.scale(
            scale: 1.2,
            child:   IconButton(
                onPressed: (){
                  _scaffoldKey.currentState.openDrawer();
                  Scaffold.of(context).openDrawer();
                },
                icon:  Icon(Icons.menu_outlined,color: Theme.of(context).accentColor,)
            ),
          ),
            flexibleSpace: Container(
              width: 50,height: 70,
              child: Padding(child: Image.asset("assets/icons/app_icon.png",),padding: EdgeInsets.only(top:8,bottom: 2),),
            ),
          actions: <Widget>[

            Consumer<CartState>(builder: (context,stateCart,child){
              return InkWell(
                onTap: (){

                  Provider.of<AppState>(context,listen: false).setScreenIndex(3);

                  //  Navigator.of(context).pop();
                },
                child: Transform.scale(
                  scale: 1,
                  child:
                  Badge(
                      elevation: 0,
                      position: BadgePosition.topStart(top: 2,start: 0),
                      padding: EdgeInsetsDirectional.only(start: 4,end: 4,),
                      showBadge: stateCart.cartProducts.length!=0||stateCart.cartProducts!=null,
                      badgeContent: Text("${stateCart.cartProducts.length}",
                        style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 8),
                      ),
                      badgeColor: Colors.redAccent.withOpacity(0.8),
                      animationType: BadgeAnimationType.scale,
                      child: Shimmer.fromColors(
                          baseColor:Theme.of(context).accentColor.withOpacity(0.8), highlightColor: Theme.of(context).accentColor,
                          child: Icon(Icons.shopping_cart,color: Theme.of(context).primaryColor,size: 23,))),
                ),
              );

            },),
            Consumer<WishListState>(builder: (context,stateWishList,child){
              return Transform.scale(
                scale: 1,
                child:
                IconButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(wishListRouter);
                    },
                    icon:     Badge(
                        elevation: 0,
                        position: BadgePosition.topStart(top: 0,start: 0),
                        padding: EdgeInsetsDirectional.only(start: 4,end: 4,),
                        showBadge: stateWishList.wishListCartProducts.length!=0||stateWishList.wishListCartProducts.length!=null,
                        badgeContent: Text("${stateWishList.wishListCartProducts.length<10&&stateWishList.wishListCartProducts.length!=null?stateWishList.wishListCartProducts.length:"+10"}",
                          style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 8),
                        ),
                        badgeColor: Colors.redAccent.withOpacity(0.8),
                        animationType: BadgeAnimationType.scale,
                        child: Shimmer.fromColors(
                          baseColor:Theme.of(context).accentColor.withOpacity(0.8), highlightColor: Theme.of(context).accentColor,
                            child: Icon(Icons.favorite,color: Theme.of(context).accentColor,))),

                ),
              );

            },),

          ],
        ),
      ),
      body:   Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
    Consumer<CategoriesState>(builder: (context,state,child){
    return   Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5,),
                            Container(
                              height: Constants.screenAwareSize(230, context),
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right:0.0,left: 0.0),
                              child: BannerItems(),
                            ),
                            SizedBox(height: 10,),
                                state.isLoading?
                               Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right:10,left: 40,top: 10,bottom: 2),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("التصنيفات",style:GoogleFonts.elMessiri(fontSize: 20)),
                                          InkWell(
                                              onTap: (){
//                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>
//                                                    CategoryListScreen(state: state,),
//                                                    fullscreenDialog: true
//                                                ));
                                                Provider.of<AppState>(context,listen: false).setScreenIndex(1);
                                              },
                                              child: Text("اظهار الكل",
                                              style:GoogleFonts.elMessiri(color: Theme.of(context).accentColor,
                                              fontSize: 15)
                                              )
                                          ),

                                        ],
                                      ),
                                    ),
                                  ) ,
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,

                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:4,
                                      itemBuilder: (context,index){
                                        return
                                          Container(
                                              height: 130,
                                              child:  ShimmerCategoryUI()
                                          );
                                      },
                                      separatorBuilder: (context,index)=>SizedBox(width: 0.0,),
                                    ),
                                  ),
                                ],
                              )
                              :Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right:10,left: 40,top: 10,bottom: 2),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("التصنيفات",style:GoogleFonts.elMessiri(fontSize: 20)),
                                          InkWell(
                                              onTap: (){
//                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>
//                                                    CategoryListScreen(state: state,),
//                                                    fullscreenDialog: true
//                                                ));
                                                Provider.of<AppState>(context,listen: false).setScreenIndex(1);
                                              },
                                              child: Text("اظهار الكل",style:GoogleFonts.elMessiri(color: Theme.of(context).accentColor,fontSize: 15))),

                                        ],
                                      ),
                                    ),
                                  ) ,
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,

                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.parentCategoryHome.length !=null?state.parentCategoryHome.length:0,
                                      itemBuilder: (context,index){
                                        return
                                          Container(
                                            width: 100,
                                            height: 130,
                                            child: CategoryCardUI(
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductListCategory(categoryId: state.parentCategoryHome[index].id,isSeen: true,),
                                                    fullscreenDialog: true
                                                ));
                                              },
                                              category: state.parentCategoryHome[index],
                                            ),
                                          );
                                      },
                                      separatorBuilder: (context,index)=>SizedBox(width: 0.0,),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 5,),
                            PreferredSize(child: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: GestureDetector(
                                onTap: ()async{
//                                  Navigator.of(context).push(MaterialPageRoute(
//                                      fullscreenDialog: true,
//                                      builder: (_)=>ChangeNotifierProvider(
//                                        child: SearchScreen(),
//                                        create: (_)=>SearchState(),
//                                      )
//                                  ));
                                  await Provider.of<AppState>(context,listen: false).setScreenIndex(2);

                                },
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    height: Constants.screenAwareSize(35, context),
                                    width: MediaQuery.of(context).size.width,
                                    child: Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),

                                      child: Row(

                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Align(
                                              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text("البحث عن منتجات ...",style: GoogleFonts.elMessiri(fontWeight: FontWeight.w200,fontSize: 12,color: Theme.of(context).primaryColor),),),
                                            ),
                                          ),

                                          Spacer(),
                                          Shimmer.fromColors(
                                            baseColor: Theme.of(context).primaryColor.withOpacity(0.6),
                                            highlightColor: Theme.of(context).primaryColor.withOpacity(0.6),
                                            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    margin: EdgeInsets.only(left: 18,right: 18),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(color:Theme.of(context).primaryColor.withOpacity(0.5))
                                    ),
                                  ),
                                ),


                              ),
                            )
                              ,preferredSize: Size(70, 100),),
                            SizedBox(height: 10,),

                          ],
                        ),
                      ),

//                      Beauty(),
//                      SizedBox(height: 5,),
//                      Electronic(),
//                      SizedBox(height: 1,),
//                      SuperMarket(),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(right:10,left: 40,top: 10,bottom: 2),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("أحدث المنتجات",style:GoogleFonts.elMessiri(fontSize: 20)),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductListCategory(categoryId:-1,isSeen: true,),
                                        fullscreenDialog: true
                                    ));
                                  },
                                  child: Text("اظهار الكل",style:GoogleFonts.elMessiri(color: Theme.of(context).accentColor,fontSize: 15))),

                            ],
                          ),
                        ),
                      ) ,
                      stateProduct.isLoading?
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child:
                          ShimmerProduct(horizontal: false,)):
                      stateProduct.products!=null?
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/1.5,
                          margin: EdgeInsets.only(top: 20),
                          child:
                          SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: !stateProduct.endPage,
                              onRefresh: _RefreshProducts,
                              onLoading: _loadMoreProducts,
                              header: WaterDropHeader(),
                              footer: CustomFooter(builder: (context,status){
                                if(status==LoadStatus.loading){
                                  return Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Center(
                                      child:Container(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator()),
                                    ),
                                  );
                                }
                                return Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Center(
                                    child:Container(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator()),
                                  ),
                                );

                              }),
                              //  physics: NeverScrollableScrollPhysics(),
                              physics:ScrollPhysics(),

                              controller: refreshController,
                              child:GridView.builder(
                                scrollDirection: Axis.horizontal,
                                // physics:ScrollPhysics(),

                                physics: NeverScrollableScrollPhysics(),

                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.5,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing:2,

                                ),


                                itemBuilder: (context, index)=>

                                    ProductDisplayCard(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailProducts(product:stateProduct.products[index],fromHome: true,),
                                          fullscreenDialog: true
                                      ));
                                    },
                                      product: stateProduct.products[index],
                                    ),

//                    Text(state.products[index].inStock.toString()),
                                shrinkWrap: true,
                                itemCount: stateProduct.products.length!=null? stateProduct.products.length:0,

                              ) )):Container(),
                      SizedBox(height: 5,),
                      Vegetables(),
                      SizedBox(height: 5,),
                      Household(),
                      SizedBox(height: 10,),



                      state.supplierCategories.isNotEmpty? Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right:10,left: 40,top: 10,bottom: 2),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("أبرز العلامات التجارية",style:GoogleFonts.elMessiri(fontSize: 18)),
                                  InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>
                                            Supplier_Screen(state: state,),
                                            fullscreenDialog: true
                                        ));
                                      },
                                      child: Text("اظهار الكل",style:GoogleFonts.elMessiri(color: Theme.of(context).accentColor,fontSize: 15))),

                                ],
                              ),
                            ),
                          ) ,
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,

                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.supplierCategories.length !=null?state.supplierCategories.length:0,
                              itemBuilder: (context,index){
                                return
                                  Container(
                                    width: 140,
                                    height: 175,
                                    child: Suppliers(
                                      onPressed: (){
                                        List<Categories> sub = state.category.where((item) => item.parent==state.supplierCategories[index].id&&item.count>0).toList() ;
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>     ProductListScreen(category:state.supplierCategories[index],statecart: state,subcategory: sub,),
                                            fullscreenDialog: true
                                        ));
                                      },
                                      category: state.supplierCategories[index],
                                    ),
                                  );
                              },
                              separatorBuilder: (context,index)=>SizedBox(width: 2.0,),
                            ),
                          ),
                        ],
                      ):
                      Container(),
                      SizedBox(height: 10,),
                    ],
                  );}),

                ],
                semanticIndexOffset: 40
                ),

              )
            ],
          ),

        ],

      ),
    ));});
  }

}




