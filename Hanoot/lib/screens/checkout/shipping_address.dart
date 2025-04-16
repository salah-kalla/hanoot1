import 'package:Hanoot/states/paymen_state.dart';
import 'package:after_layout/after_layout.dart';
import "package:flutter/material.dart";
import 'package:Hanoot/models/address.dart';
import 'package:Hanoot/states/UserState.dart';
import 'package:Hanoot/states/cart_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddress extends StatefulWidget {
  Function onNext,onBack ;
  CartState cartState ;
  UserState userState ;
  ShippingAddress({this.cartState,this.onNext,this.onBack,this.userState});
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> with TickerProviderStateMixin,AfterLayoutMixin{
  Animation animation,afterAnimation ;
  AnimationController animationController ;
  @override
  void afterFirstLayout(BuildContext context) async{
    await Provider.of<CartState>(context, listen: false).getAddress();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
          () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        phone_number=  prefs.getString('phone_number');
        final addressValue =
        await Provider.of<CartState>(context, listen: false).getAddress();
        if (addressValue != null) {
          setState(() {
            address = addressValue;
            _countryController.text = address.Country;
            _cityController.text = address.city;
            _streetController.text = address.street;
            _zipController.text = address.zipCode;
            _stateController.text = address.state;
            _firstNameController.text = address.firstName;
            _lastNameController.text = address.lastName;

            _phoneController.text =address.phoneNumber;
          });
        } else {
          setState(() {
          });
        }
      },
    );
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 600));
    animation =Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    afterAnimation =Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve:Interval(0.2,1.0,curve:Curves.fastOutSlowIn)));
    animationController.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }

  /// Import method
  final _formKey = GlobalKey<FormState>();
  var phone_number = "";
  TextEditingController _cityController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  var cites = [
    'طرابلس',
//    'المنطقة الشرقية',
//    'المنطقة الجنوبية',
//    'المنطقة الوسطى',
//    'المنطقة الغربية'
  ];
  var BenghaziItem = ['وسط المدينة'];
  var MusrataItem = ['زسط المدينة'];

  String cityItem;

  String cityhint = "يرجى اختيار منطقة";

  String cityItemSelect = null;
  var TriploiItem = [
    "طرابلس المركز",
    "ابوستة",
    "أبوسليم",
    "الحشان",
    "الدريبي",
    "السبعة",
    "السراج",
    "السواني",
    "سيدي سليم",
    "الكريمية",
    "السياحية",
    "الصريم",
    "الظهرة",
    "الفرناج",
    "المدينة القديمة",
    "المنصورة",
    "النوفلين",
    "الهاني",
    "باب بن غشير",
    "بن عاشور",
    "تاجوراء",
    "جنزور",
    "حي الأندلس",
    "حي دمشق",
    "رأس حسن",
    "زاوية الدهماني",
    "زناتة",
    "سيدي المصري",
    "11-يونيو",
    "شارع الجمهورية",
    "شارع الزاوية",
    "شارع النصر",
    "شط الهنشير",
    "صلاح الدين",
    "الدعوة الإسلامية",
    "طريق السور",
    "طريق المطار",
    "عرادة",
    "عين زارة",
    "غوط الشعال",
    "فشلوم",
    "قرجي",
    "قرقارش",
    "سوق الجمعة",
    "النجيلة",
    "الهضبة الشرقية",
    "الهضبة الخضراء",
    "مشروع الهضبة",
    "شارع ولي العهد",
    "الفلاح",
    "ميزران",
    "شارع البلدية",
    "شارع عمر المختار",
    "غرغور",
    "خلة الفرجان"
  ];
  var WestItem = [ "غريان",
    "الزاويه",
    "زوارة", "ترهونة",
    "صبراته",
    "نالوت", "جادو", "الزنتان",
    "منطقة اخرى"
  ];
  var CentralItem = [ "مصراته",
    "زليتن",
    "الخمس"
    , "القره بوللي"
    , "قصر خيار"
    , "منطقة اخرى"
  ];
  var EastItem = [ "البريقة", "بنغازي"
    , "درنة"
    , "شحات"
    , "البيضاء"
    , "المرج"
    , "منطقة اخرى"
  ];
  var SouthItem = ["سبها"];
  var nullItem = ["يرجى اختيار منطقة من الأعلى"];
  Address address = Address();



  Future<void> updateState(Address address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await  prefs.setString('zip',  address.zipCode);
    setState(() {
      _cityController.text = address.city;
      _streetController.text = address.street;
      _zipController.text = address.zipCode;
      _stateController.text = address.state;
      _countryController.text = address.Country;
      this.address.Country = address.Country;
    });
  }

     bool checkToSave() {
    final LocalStorage storage = LocalStorage("intoAddress");
    List<Address> _list = [];
    try {
      var Addressdata = storage.getItem('shippingAddress');
      if (Addressdata != null) {
       address = Address.fromjson(Addressdata);
      }

    } catch (err) {
    }
    return true;
  }
  /// *** ///



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return address==null?
        Container()
    :
    AnimatedBuilder(animation: animationController,
        builder: (context,child){
      return Transform(
        transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
        child: Container(
          height: MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height/6),
          margin: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
             // mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                SizedBox(height: 20,),
                Text("عنوان الشحن",style: GoogleFonts.elMessiri(fontWeight: FontWeight.bold,fontSize: 20),),
                Divider(),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,

                                child: Container(
                                  height: 55,
                                  padding: EdgeInsets.all(2.0),
                                  child: TextFormField(
                                      style: GoogleFonts.elMessiri(fontSize: 13),
                                      controller: _firstNameController,
                                      //     initialValue: address.firstName,
                                      decoration:
                                      InputDecoration(labelText: "الأسم الأول",
                                        hintStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black),
                                        labelStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey),
                                      ),
                                      validator: (val) {
                                        return val.isEmpty
                                            ? " "
                                            : null;
                                      },
                                      onSaved: (String value) {
                                        address.firstName = value;
                                      }),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55,
                                  padding: EdgeInsets.all(2.0),
                                  child: TextFormField(
                                      style: GoogleFonts.elMessiri(fontSize: 13),
                                      controller: _lastNameController,
                                      // initialValue: address.lastName,
                                      validator: (val) {
                                        return val.isEmpty
                                            ? " "
                                            : null;
                                      },
                                      decoration:
                                      InputDecoration(labelText: "الأسم التاني",
                                        hintStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black),
                                        labelStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey),
                                      ),
                                      onSaved: (String value) {
                                        address.lastName = value;
                                      }),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //EDit for Gibran about Cites Selected
                          DropdownButtonFormField<String> (
                            hint: (cityItem!=null)?Text("${address.state}"): Text(
                              'تحديد المدينة من القائمة (اجباري)*',style: GoogleFonts.elMessiri(color: Colors.grey)
                            ),

                            items: cites.map((String dropdownStringItem){
                              return DropdownMenuItem<String>(

                                  value: dropdownStringItem,
                                  child: Text(dropdownStringItem));
                            }).toList(),
                            onChanged: (String NewvalueStringItem){
                              setState(() {
                                this.cityItem = NewvalueStringItem ;
                                //  address.state = cityItem;
                                cityItemSelect=null;
                                address.city=null;
                              });
                              address.state=cityItem;
                            },
                            validator: (value) => value == null ? ' ' : null,
                            value: cityItem,
                            // isDense: true,
                          ),
                          (cityItem=="طرابلس")? DropdownButtonFormField<String>

                            (  hint: (address.city!=null)?Text("${address.city}"): Text(
                            '${cityhint}',style: GoogleFonts.elMessiri(color: Colors.grey),
                          ),
                            items: TriploiItem.map((String dropdownStringItem){
                              return DropdownMenuItem<String>(

                                  value: dropdownStringItem,
                                  child: Text(dropdownStringItem));
                            }).toList(),
                            onChanged: (String NewvalueStringItem){
                              setState(() {

                                cityhint=address.city;

                                this.cityItemSelect = NewvalueStringItem ;
                                address.city =cityItemSelect;

                                if(cityItemSelect=="طرابلس المركز"){

                                  address.zipCode = "61400";
                                  cityhint="طرابلس المركز";


                                }else if (cityItemSelect=="ابوستة"){

                                  address.zipCode = "61400";
                                  cityhint="ابوستة";
                                }else if(cityItemSelect=="أبوسليم"){
                                  address.zipCode = "61400";

                                }
                                else  if(cityItemSelect=="الحشان"){
                                  address.zipCode = "61400";

                                }
                                else if(cityItemSelect=="الدريبي"){
                                  address.zipCode = "61400";


                                }else if(cityItemSelect=="السبعة"){
                                  address.zipCode = "61405";

                                }else if(cityItemSelect=="السراج"){
                                  address.zipCode = "61406";

                                }else if (cityItemSelect=="السواني"){
                                  address.zipCode = "61401";

                                }else if (cityItemSelect=="الكريمية"){
                                  address.zipCode = "61401";

                                }else if(cityItemSelect=="السياحية"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="الصريم"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="الظهرة"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="الفرناج"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="المدينة القديمة"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="المنصورة"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="النوفلين"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="الهاني"){
                                  address.zipCode = "61400";

                                } else if (cityItemSelect=="باب بن غشير"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="بن عاشور"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="تاجوراء"){
                                  address.zipCode = "62100";

                                }else if (cityItemSelect=="جنزور")
                                {
                                  address.zipCode = "62000";

                                }else if (cityItemSelect=="سيدي سليم")
                                {
                                  address.zipCode = "620004";

                                }else if (cityItemSelect=="شارع ولي العهد")
                                {
                                  address.zipCode = "620005";

                                }else if(cityItemSelect=="حي الأندلس"){
                                  address.zipCode = "61400";

                                } else if (cityItemSelect=="حي دمشق")
                                {
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="رأس حسن"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="زاوية الدهماني"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="زناتة"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="الدعوة الإسلامية"){
                                  address.zipCode = "61404";

                                }else if (cityItemSelect=="سيدي المصري"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="11-يونيو"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="شارع الجمهورية"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="شارع الزاوية"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="شارع النصر"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="شط الهنشير"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="صلاح الدين"){
                                  address.zipCode = "6140010";

                                }else if(cityItemSelect=="طريق السور"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="طريق المطار"){
                                  address.zipCode = "6140020";

                                }else if (cityItemSelect=="عرادة"){
                                  address.zipCode = "61400";

                                }
                                else if (cityItemSelect=="عين زارة"){
                                  address.zipCode = "6140040";

                                }else if( cityItemSelect=="غوط الشعال"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="فشلوم"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="قرجي"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="قرقارش"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="سوق الجمعة"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="النجيلة"){
                                  address.zipCode = "61402";

                                }else if(cityItemSelect=="الهضبة الشرقية"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="الهضبة الخضراء"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="مشروع الهضبة")
                                {
                                  address.zipCode = "6140022";

                                }else if (cityItemSelect=="الفلاح"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="ميزران"){
                                  address.zipCode = "61400";

                                }else if(cityItemSelect=="شارع البلدية"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="شارع عمر المختار"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="غرغور"){
                                  address.zipCode = "61400";

                                }else if (cityItemSelect=="خلة الفرجان"){
                                  address.zipCode = "61403";

                                }

                                //  if(cityItemSelect=="طرابلس"){
                                //     address.zipCode = "218";

                                //  } else if(cityItemSelect=="بنغازي"){
                                //     address.zipCode = "219";

                                //  }
                                //   else if(cityItemSelect=="سرت"){
                                //     address.zipCode = "300";

                                //  }
                                //   else if(cityItemSelect=="مصراته"){
                                //     address.zipCode = "200";

                                //  }
                              });

                            },
                            validator: (value) => ( address.city==null
                            ) ? 'هذا الحقل اجباري' : null,


                            value:  cityItemSelect,
                          ):(cityItem=="المنطقة الوسطى")?
                          DropdownButtonFormField<String>

                            (  hint: (address.city!=null)?Text("${address.city}"): Text(
                            'يرجى اختيار منطقة*',
                          ),
                            items: CentralItem.map((String dropdownStringItem){
                              return DropdownMenuItem<String>(

                                  value: dropdownStringItem,
                                  child: Text(dropdownStringItem));
                            }).toList(),
                            onChanged: (String NewvalueStringItem){
                              setState(() {

                                this.cityItemSelect = NewvalueStringItem ;
                                address.city =cityItemSelect;
                                if(cityItemSelect=="مصراته"){
                                  address.zipCode = "61900";

                                }else if (cityItemSelect=="الخمس"){
                                  address.zipCode = " 63300";

                                }else if (cityItemSelect=="زليتن"){
                                  address.zipCode = "61700";

                                }else if (cityItemSelect=="سرت"){
                                  address.zipCode = "61701";

                                }
                                else if (cityItemSelect=="القره بوللي"){
                                  address.zipCode = "616009";

                                }else if (cityItemSelect=="قصر خيار"){
                                  address.zipCode = "6160010";

                                }else if (cityItemSelect=="منطقة اخرى"){
                                  address.zipCode = "20615003";

                                }
                              });

                            },
                            validator: (value) => ( address.city==null
                            ) ? ' ' : null,


                            value:  cityItemSelect,
                          )
                              :(cityItem=="المنطقة الشرقية")?
                          DropdownButtonFormField<String>

                            (  hint: (address.city!=null)?Text("${address.city}"): Text(
                            'يرجى اختيار منطقة*',
                          ),
                            items: EastItem.map((String dropdownStringItem){
                              return DropdownMenuItem<String>(

                                  value: dropdownStringItem,
                                  child: Text(dropdownStringItem));
                            }).toList(),
                            onChanged: (String NewvalueStringItem){
                              setState(() {
                                this.cityItemSelect = NewvalueStringItem ;
                                address.city =cityItemSelect;
                                if(cityItemSelect=="بنغازي"){
                                  address.zipCode = "6140030";

                                }else if (cityItemSelect=="البريقة"){
                                  address.zipCode = "615009";


                                }else if (cityItemSelect=="درنة"){
                                  address.zipCode = "615003";


                                }else if (cityItemSelect=="شحات"){
                                  address.zipCode = "6150010";


                                }else if (cityItemSelect=="البيضاء"){
                                  address.zipCode = "615002";


                                }else if (cityItemSelect=="المرج"){
                                  address.zipCode = "615006";


                                }else if (cityItemSelect=="منطقة اخرى"){
                                  address.zipCode = "10615003";


                                }
                              });

                            },
                            validator: (value) => ( address.city==null
                            ) ? 'هذا الحقل اجباري' : null,


                            value:  cityItemSelect,
                          )
                              :(cityItem=="المنطقة الجنوبية")?
                          DropdownButtonFormField<String>

                            ( hint: (address.city!=null)?Text("${address.city}"): Text(
                            'يرجى اختيار منطقة*',
                          ),
                            items: SouthItem.map((String dropdownStringItem){
                              return DropdownMenuItem<String>(
                                  value: dropdownStringItem,
                                  child: Text(dropdownStringItem));
                            }).toList(),
                            onChanged: (String NewvalueStringItem){
                              setState(() {
                                this.cityItemSelect = NewvalueStringItem ;
                                address.city =cityItemSelect;
                                if(cityItemSelect=="سبها"){
                                  address.zipCode = "618002";

                                }
                              });

                            },
                            validator: (value) => ( address.city==null
                            ) ? " " : null,

                            value:  cityItemSelect,
                          ):(cityItem=="المنطقة الغربية")?
                          DropdownButtonFormField<String>

                            (  hint: (address.city!=null)?Text("${address.city}"): Text(
                            'يرجى اختيار منطقة*',
                          ),
                            items: WestItem.map((String dropdownStringItem){
                              return DropdownMenuItem<String>(

                                  value: dropdownStringItem,
                                  child: Text(dropdownStringItem));
                            }).toList(),
                            onChanged: (String NewvalueStringItem){
                              setState(() {
                                this.cityItemSelect = NewvalueStringItem ;
                                address.city =cityItemSelect;
                                if(cityItemSelect=="غريان"){
                                  address.zipCode = "617007";

                                }else if (cityItemSelect=="الزاويه"){
                                  address.zipCode = "61800";

                                }
                                else if (cityItemSelect=="صبراته"){
                                  address.zipCode = "6140023";

                                }
                                else if (cityItemSelect=="الزنتان"){
                                  address.zipCode = "617009";

                                }else if (cityItemSelect=="جادو"){
                                  address.zipCode = "6140050";

                                }else if (cityItemSelect=="نالوت"){
                                  address.zipCode = "617008";

                                }
                                else if (cityItemSelect=="ترهونة"){
                                  address.zipCode = "63600";

                                }else if (cityItemSelect=="زوارة"){
                                  address.zipCode = "63400";

                                }else if (cityItemSelect=="منطقة اخرى"){
                                  address.zipCode = "30615003";

                                }
                              });

                            },
                            validator: (value) => ( address.city==null
                            ) ? ' ': null,

                            value: cityItemSelect,

                          )

                              :    SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 55,
                            child: TextFormField(

                                controller: _streetController,
                                validator: (val) {
                                  return val.isEmpty
                                      ? " "
                                      : null;
                                },
                                decoration: InputDecoration(
                                    labelText: "وصف العنوان",
                                  hintStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black),
                                  labelStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey),

                                ),
                                onSaved: (String value) {
//                    address.street = _streetController.text ;
                                  address.street = value;
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ///////////////




                          Container(
                            height: 55,
                            child: TextFormField(
                                controller: _phoneController,

                                //  initialValue: phone_number,
                                decoration: InputDecoration(
                                    labelText: "رقم الهاتف",
                                  hintStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black),
                                  labelStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey),

                                ),
                                validator: (val) {
                                  return val.isEmpty
                                      ? " "
                                      : null;
                                },
                                keyboardType: TextInputType.phone,
                                onSaved: (String value) {
                                  address.phoneNumber = value;
                                }),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 55,
                          //  padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(

                                controller: _emailController,
                                keyboardType: TextInputType.phone,
                                decoration:
                                InputDecoration(labelText: "رقم هاتف احتياطي (يمكن تكرار نفس الرقم)",
                                  hintStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.black),
                                  labelStyle: GoogleFonts.elMessiri(fontSize: 12,color: Colors.grey),

                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return " ";
                                  }
                                },
                                onSaved: (String value) {
                                  address.email = value+"@hanoot.ly";
                                }),
                          ),



                          SizedBox(height: 30),
                          Row(children: [
                            Expanded(
                              child: Material(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(10),
                                elevation: 4,
                                child: FlatButton(
                                  onPressed: () {
                                    widget.onBack();
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("رجوع",style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: Material(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(10),
                                elevation: 4,
                                child: FlatButton(
                                  onPressed: ()async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      Provider.of<CartState>(context, listen: false)
                                          .setAddress(address);
                                      Provider.of<CartState>(context, listen: false)
                                          .getShippingMethod(address: address,token: widget.userState.user.cookie);
                                      Provider.of<CartState>(context, listen: false)
                                          .getPaymentMethods();
                                       widget.onNext();
                                    }

                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await  prefs.setString('zip',  address.zipCode);
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("متابعة الشحن",style: GoogleFonts.elMessiri(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                                        Icon(Icons.chevron_right,color: Colors.white,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
        });
  }


}