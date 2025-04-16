import 'package:flutter/material.dart';
import 'package:Hanoot/screens/detail_screen_products.dart';
import 'package:Hanoot/states/app_state.dart';
import 'package:Hanoot/states/search_state.dart';
import 'package:Hanoot/widgets/ProductCard.dart';
import 'package:Hanoot/widgets/Shimmer/shimmer_product.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appstate =Provider.of<AppState>(context);
    final state =Provider.of<SearchState>(context);
    return   Scaffold(
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                      Opacity(
                        opacity: 1.0,
                        child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Material(
                          //  color: Colors.white.withOpacity(0.9),
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.symmetric(horizontal: 8),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Theme.of(context).accentColor)
                               //   borderRadius: BorderRadius.circular(30)
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child:Padding(padding: EdgeInsets.only(right: 4),
                                      child:  TextField(

                                        controller: _searchController,
                                        onChanged: (value) {
                                          state.clearResult();
                                        },
                                        onSubmitted: (value) {
                                          state.setKeyword(value);
                                        },
                                        decoration: InputDecoration(
                                          focusedErrorBorder: InputBorder.none,
                                          hintText: "البحث عن منتجات",
                                          hintStyle: GoogleFonts.elMessiri(fontSize: 15),
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                      )),
                                  IconButton(
                                      icon: Material(
                                          elevation: 2,
                                        //  color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          child:   Shimmer.fromColors(
                                              baseColor: Theme.of(context).accentColor,
                                              highlightColor: Theme.of(context).accentColor.withOpacity(0.2),
                                              child: Icon(Icons.clear,size: 20,color: Theme.of(context).accentColor,))),
                                      onPressed: () {
                                        state.clearResult();
                                        _searchController.clear();
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      state.showKeywords&&state.keyWords.isNotEmpty
                          ? Container(child: buildKeywords(state))
                          : state.keyWords.isEmpty&&state.isRersultLoading!=true
                          ? buildEmptyView(context)
                          : state.isRersultLoading
                          ? ShimmerProduct(horizontal: false,)
                          : state.searchResult.length > 0
                          ? Container(child: buildResultView(state))
                          : Container(child: EmbtyRender(context)),
                    ]))
              ],
            ),
          )),

    );

  }
  Widget buildEmptyView ( BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top:70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(width: 110,height: 110,child:
            Image.asset("assets/icons/search2.png",color: Theme.of(context).accentColor,),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("لم تقم بالبحث عن منتجات حتى الآن، قم بالبحث الآن سنساعدك!",style: GoogleFonts.elMessiri(fontSize: 18),textAlign: TextAlign.center),
            ),

          ],
        ),
      ),
    );
  }
  GridView buildResultView(SearchState state) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: .6,
        ),
        itemCount: state.searchResult.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ProductDisplayCard(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailProducts(product:state.searchResult[index]),
                  fullscreenDialog: true
              ));
            },
            product: state.searchResult[index],
          );
        });
  }
  Widget buildKeywords(SearchState state) {
    return   Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width/(1/(MediaQuery.of(context).size.height/MediaQuery.of(context).size.width)),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  width: MediaQuery.of(context).size.width/(2/(MediaQuery.of(context).size.height/MediaQuery.of(context).size.width)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      (state.keyWords.isNotEmpty)?
                      InkWell(
                        onTap: () {
                            state.clearKeywords();
                        },
                        child: Text("حذف جميع النتائج",style: GoogleFonts.elMessiri(color: Theme.of(context).accentColor),),
                      ):Container(),
                      (state.keyWords.isNotEmpty)?
                      Text("أفضل النتائج"):Container(),
                    ],
                  ),
                ),
              ),
            ) ,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (state.keyWords.length<5)?state.keyWords.length:5,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    _searchController.text = state.keyWords[index];
                    state.setKeyword(state.keyWords[index]);
                  },
                  onLongPress: () {
                    state.removeKeyword(state.keyWords[index]);
                  },
                  title: Text("${state.keyWords[index]}"),
                  leading: Icon(Icons.search,color: Theme.of(context).accentColor,),
                  trailing: Icon(Icons.arrow_right,color: Theme.of(context).accentColor,),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        ],
      ),
    );
    }
  Widget KeywordsRender({SearchState state ,double width, BuildContext context}){
    final SizeScreen = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Container(
          width: SizeScreen.width,
          child:FittedBox(
            fit: BoxFit.cover,
            child: Container(
              width: SizeScreen.width/(2/(SizeScreen.height/SizeScreen.width)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("آفضل النتائج"),
                  (state.keyWords.isNotEmpty)?
                  InkWell(
                    onTap: (){
                    },
                    child: Text("حذف",style: GoogleFonts.elMessiri(color: Theme.of(context).primaryColor),),
                  ):Container(),

                ],
              ),

            ),

          ) ,
        ),
        Container(
          width: SizeScreen.width,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Container(
              width: SizeScreen.width/(2/(SizeScreen.height/SizeScreen.width)),
              child: Card(
                child: Column(
                  children: List.generate((state.keyWords.length<5)?state.keyWords.length:5, (index){
                    return ListTile(
                      title: Text(state.keyWords[index]),
                      onTap: (){
                   //     onPressed(state.keyWords[index]);
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
  Widget EmbtyRender(BuildContext context){
    final SizeScreen = MediaQuery.of(context).size;
    return Container(
      width: SizeScreen.width,
      child: FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.center,
        child: Container(
          width: SizeScreen.width,
          height: SizeScreen.height,
          margin: EdgeInsets.only(top: 150),
          child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/poor.png",width: 110,height: 110,),
              SizedBox(height: 10,),
              Container(
                width: 250,
                child: Text("لم يتم العثور على عناصر تحمل نفس الأسم",style:
                GoogleFonts.elMessiri(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
