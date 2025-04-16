import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/models/category.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:Hanoot/states/categories_state.dart';
import 'package:Hanoot/states/product_list_state.dart';
import 'package:Hanoot/utils/constants.dart';
import 'package:Hanoot/widgets/ProductCard.dart';
import 'package:Hanoot/widgets/product_list_by_category.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListScreen extends StatefulWidget {
  final Categories category ;
  final List<Categories> subcategory ;
  CategoriesState statecart ;
  ProductListScreen({this.category,this.statecart,this.subcategory});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> with SingleTickerProviderStateMixin, AfterLayoutMixin{
  int initPosition = 0;
  RefreshController refreshController = RefreshController();
  @override
  void afterFirstLayout(BuildContext context) async{
    await onRefreshorders(context);
  }
  Future onRefreshorders(BuildContext context)async{
    await Provider.of<ProductListState>(context,listen: false).initProducts();

  }

  void _onrefresh() async{
    Provider.of<ProductListState>(context,listen: false).initProducts();
    await Future.delayed(Duration(milliseconds: 1500));
    refreshController.refreshCompleted();
  }
  void _onLoadMore(Categories categoruId)async{

    Provider.of<ProductListState>(context,listen: false).loadMoreCategoryProducts(ID: categoruId.id);

    setState(() async{
      await Future.delayed(Duration(milliseconds: 1500));
      refreshController.loadComplete();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        title: Text(widget.category.name),
        actions: <Widget>[
          Consumer<CartState>(builder: (context,stateCart,child){
            return Transform.scale(
              scale: 1,
              child:
              IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  Provider.of<AppState>(context,listen: false).setScreenIndex(3);
                  Navigator.of(context).pop();

                },
                icon: Badge(
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
                        baseColor: Theme.of(context).primaryColor.withOpacity(0.8), highlightColor: Colors.grey,
                        child: Icon(Icons.shopping_basket,))),

              ),
            );

          },),
        ],
      ),
      body: SafeArea(child:
      (widget.subcategory.length != 0 && widget.subcategory.isNotEmpty)
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTabView(
        initPosition: initPosition,
        itemCount: widget.subcategory.length,
        tabBuilder: (context, index) =>
              Tab(

                  text: widget.subcategory[index].name.toString()),
        pageBuilder: (context, index) =>
              Center(child:  ProductListCategory(categoryId:widget.subcategory[index].id,subcategory:widget.subcategory),
                     ),
        onPositionChange: (index) {
            initPosition = index;
        },
        onScroll: (position) => print('$position'),
      ),
          )

          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductListCategory(categoryId:widget.category.id,),
          )
      ),
    );
  }

  GridView buildCategoryProductsView(ProductListState state) {
    return GridView.builder(
        itemCount: state.products.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .6,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return ProductDisplayCard(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => DetailProducts(product: state.products[index]),
              fullscreenDialog: true,
            ));
          },
            product: state.products[index],
          );
        });
  }

  Container buildDecorationView(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17),
      child: Column(
        children: <Widget>[
          RichText(text: TextSpan(
              children: [
                TextSpan(
                    text: " ${widget.category.totalProduct}",
                    style:GoogleFonts.elMessiri(fontWeight: FontWeight.w100)
                )

              ]
          ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            height: 2,
            width: MediaQuery
                .of(context)
                .size
                .width / 4,
            color: Theme
                .of(context)
                .accentColor,
          )
        ],
      ),
    );
  }

  PreferredSize buildPreferenceView(BuildContext context,
      ProductListState state) {
    return PreferredSize(
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(child: FlatButton.icon(onPressed: () {
              _showoptions(context, [
                "POPULAR",
                "NEW",
                "PRICE: LOW TO HIGH",
                "PRICE: HIGH TO LOW"
              ]
              );
            }, icon: Icon(Icons.sort), label: Text("SORT MY"))),
            Container(width: 1,
              height: 15,
              color: Colors.black,
            ),
            Expanded(child: FlatButton.icon(onPressed: () {

            }, icon: Icon(Icons.tune), label: Text("FILTER"))

            )
          ],
        ),
      ),
      preferredSize: Size(100, Constants.screenAwareSize(40, context)),
    );
  }

  _showoptions(context, List<String> options) {
    return showModalBottomSheet(context: context, builder: (context) {
      return SafeArea(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((value) =>
              ListTile(
                onTap: () {
                  Navigator.of(context).pop(value);
                },
                title: Center(
                  child: Text(value, style: GoogleFonts.elMessiri(fontSize: 14),),),
              )
          ).toList()
      )
      );
    });
  }

}
class CustomTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Widget stub;
  final ValueChanged<int> onPositionChange;
  final ValueChanged<double> onScroll;
  final int initPosition;

  CustomTabView({
    @required this.itemCount,
    @required this.tabBuilder,
    @required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView> with TickerProviderStateMixin {
  TabController controller;
  int _currentCount;
  int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? 0;
    controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 :
        _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 50,
          alignment: Alignment.center,
          child: TabBar(
            unselectedLabelColor: Theme.of(context).accentColor,
            indicatorPadding: EdgeInsets.only(left: 30, right: 30),
            indicator: ShapeDecoration(
                color: Theme.of(context).accentColor,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Theme.of(context).accentColor.withOpacity(0.7),
                    ))),
            isScrollable: true,
            controller: controller,
            labelPadding: EdgeInsets.only(left:10,right: 10,top: 0,bottom: 0),
            labelColor:  Colors.white,
            labelStyle: GoogleFonts.elMessiri(fontSize: 14,),
            tabs: List.generate(
              widget.itemCount,
                  (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              widget.itemCount,
                  (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange(_currentPosition);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll(controller.animation.value);
    }
  }
}