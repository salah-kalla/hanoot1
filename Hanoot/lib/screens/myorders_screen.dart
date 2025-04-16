import 'package:Hanoot/states/app_state.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:Hanoot/screens/order_detial.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/order_state.dart';
import 'package:Hanoot/widgets/OrderCard.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_order.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrders extends StatefulWidget {
UserState userState ;
MyOrders({this.userState});

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> with AfterLayoutMixin<MyOrders>{
  RefreshController refreshController = RefreshController();

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    onRefreshorders();
  }
  void onRefreshorders(){
    Provider.of<OrderState>(context,listen: false).getMyOrders(userState: Provider.of<UserState>(context,listen: false));
  }

  void _onrefresh() async{
   Provider.of<OrderState>(context,listen: false).getMyOrders(userState: Provider.of<UserState>(context,listen: false));
   await Future.delayed(Duration(milliseconds: 1500));
   refreshController.refreshCompleted();
  }
  void _loadMore()async{

    Provider.of<OrderState>(context,listen: false).loadMore(userState: Provider.of<UserState>(context,listen: false));
    await Future.delayed(Duration(milliseconds: 1500));
    refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
  return  Consumer<OrderState>(
      builder: (context, stateOrder, child) =>Scaffold(
    appBar: AppBar(
      title: Text("طلباتي",style: GoogleFonts.elMessiri(color:Colors.white),),
      centerTitle: true,
      backgroundColor: Theme.of(context).accentColor,
    ),
    body:Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 60,
          child: Material(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(5),bottomRight: Radius.circular(5)),
            elevation: 4,
            color: Theme.of(context).accentColor,

          ),
        ),
        stateOrder.loading?
            ShimmerOrder():
        stateOrder.orders.isEmpty?
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Theme.of(context).accentColor.withOpacity(0.8),
                highlightColor:Theme.of(context).accentColor,
                child: Container(width: 120,height: 120,child:
                Image.asset("assets/icons/box.png",color: Theme.of(context).accentColor,),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("يبدو أنك لم تتخذ قرارك بعد!",style: GoogleFonts.elMessiri(fontSize: 18),textAlign: TextAlign.center),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-100,
                    child: Material(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 4,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          Provider.of<AppState>(context,listen: false).setScreenIndex(0);

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("تسوق الآن",style: GoogleFonts.elMessiri(color:Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(width: 15,),
                              Icon(Icons.shopping_cart,color:  Colors.black,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              )

            ],
          ),
        )
        :Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: !stateOrder.endPage,
              onRefresh: _onrefresh,
              onLoading: _loadMore,
              header: WaterDropHeader(),
              footer: CustomFooter(builder: (context,status){
                if(status==LoadStatus.loading){
                  return Center(
                    child: Text(" ... جاري التحميل"),
                  );
                }
                return Container();
              }),
              controller: refreshController,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: stateOrder.orders.length!=null?stateOrder.orders.length:0,
                itemBuilder: (context,index){
                  return  OrderCard(
                    order: stateOrder.orders[index],
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                          (BuildContext context) => OrderDetails(order: stateOrder.orders[index],)));
                    },
                  );
                },)

          ),
        ),
      ],
    )
  ));
  }
/*
GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  childAspectRatio: 2.4,
                  crossAxisCount: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,

                ),


                itemBuilder: (context, index)=>

                    OrderCard(
                      order: stateOrder.orders[index],
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (BuildContext context) => OrderDetails(order: stateOrder.orders[index],)));


                      },
                    ),

//                    Text(state.products[index].inStock.toString()),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: stateOrder.orders.length,

              ),
 */

}
