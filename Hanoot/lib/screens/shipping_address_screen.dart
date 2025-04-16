
import 'package:flutter/material.dart';
import 'package:Hanoot/models/payment.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Hanoot/models/address.dart';
class ShippingAddressScreen extends StatefulWidget {
  final Function function ;
  ShippingAddressScreen({@required this.function});
  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final _fromkey = GlobalKey<FormState>();
  Address address = Address(
      firstName: "test",
      lastName: "user",
      email: "testuser@test.com",
      state: "Libya",
      street: "LY STREET",
      city: "Jaipur",
      zipCode: "0000",
      phoneNumber: "1234567",
      Country: "Libya"
  );
  PaymentMethod paymentMethod = PaymentMethod(
      id: "1",
      title: "cod",description: "cash on delivery",enabled: true
  );
  TextEditingController _cityController = TextEditingController(text: "Jaipur");
  TextEditingController _streetController = TextEditingController(text: "LY STREET");
  TextEditingController _zipController = TextEditingController(text: "0000");
  TextEditingController _stateController = TextEditingController(text: "Libya");
  TextEditingController _countryController = TextEditingController(text: "Libya");
  final FocusNode _firstNameNode = FocusNode(),
      _lastNameNode= FocusNode(),
      _stateNameNode= FocusNode(),
      _countryNode= FocusNode(),
      _numberNode= FocusNode(),
      _emailNode= FocusNode(),
      _cityNode= FocusNode(),
      _streetNode= FocusNode(),
      _zipNode= FocusNode();
  @override
  Widget build(BuildContext context) {
final accentColor = Theme.of(context).accentColor.withOpacity(.9);
    return SingleChildScrollView(
      child: Form(
          key: _fromkey,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                initialValue: address.firstName,
                textInputAction: TextInputAction.next,
                focusNode: _firstNameNode,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context,_firstNameNode,_lastNameNode);
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"first name is required":null;
                },
                onSaved: (String value){
                  address.firstName = value ;
                },
              ),
              TextFormField(

                initialValue: address.lastName,
                textInputAction: TextInputAction.next,
                focusNode: _lastNameNode,
                onFieldSubmitted: (_)=>
                  _fieldFocusChange(context,_firstNameNode,_lastNameNode),
                decoration: InputDecoration(
                  labelText: "Last Name",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"last name is required":null;
                },
                onSaved: (String value){
                  address.lastName = value ;
                },
              ),
              TextFormField(
                initialValue: address.phoneNumber,
                textInputAction: TextInputAction.next,
                focusNode: _numberNode,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context,_numberNode,_emailNode);
                },
                decoration: InputDecoration(
                  labelText: "Number",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"Phone is required":null;
                },
                onSaved: (String value){
                  address.phoneNumber = value ;
                },
              ),
              TextFormField(
                initialValue: address.email,
                textInputAction: TextInputAction.next,
                focusNode: _emailNode,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context,_emailNode,_countryNode);
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  if(val.isEmpty){
                    return "Email is required";
                  }
                  return null;

                },
                onSaved: (String value){
                  address.email = value ;
                },

              ),
              TextFormField(
                initialValue: address.Country,
                textInputAction: TextInputAction.next,
                focusNode: _countryNode,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context,_countryNode,_stateNameNode);
                },
                decoration: InputDecoration(
                  labelText: "Country Name",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"Country name is required":null;
                },
                onSaved: (String value){
                  address.Country = value ;
                },
              ),
              TextFormField(
              //  initialValue: address.s,
                controller: _stateController,
                textInputAction: TextInputAction.next,
                focusNode: _stateNameNode,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context,_stateNameNode,_cityNode);
                },
                decoration: InputDecoration(
                  labelText: "State/Provider",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"State is required":null;
                },
                onSaved: (String value){
                  address.state = value ;
                },

              ),
              TextFormField(
               // initialValue: address.Country,
                controller: _cityController,
                textInputAction: TextInputAction.next,
                focusNode: _cityNode,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context,_cityNode,_streetNode);
                },
                decoration: InputDecoration(
                  labelText: "City",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"City is required":null;
                },
                onSaved: (String value){
                  address.city = value ;
                },
              ),
              TextFormField(
              //  initialValue: address.Country,
                controller: _streetController,
                textInputAction: TextInputAction.next,
                focusNode: _streetNode,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context,_streetNode,_zipNode);
                },
                decoration: InputDecoration(
                  labelText: "Street Name",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"Street name is required":null;
                },
                onSaved: (String value){
                  address.street = value ;
                },
              ),
              TextFormField(
              //  initialValue: address.zipCode,
                controller: _zipController,
                textInputAction: TextInputAction.done,
                focusNode: _zipNode,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                decoration: InputDecoration(
                  labelText: "Zip Code",
                  labelStyle: GoogleFonts.elMessiri(color: accentColor),
                ),
                validator: (val){
                  return val.isEmpty?"Zip code is required":null;
                },
                onSaved: (String value){
                  address.zipCode = value ;
                },
              ),
      SizedBox(height: 20,),
      Row(
        children: <Widget>[
          Expanded(child: ButtonTheme(
            height: 45,
            child: RaisedButton(
                elevation: 0.0,
                onPressed: (){
              if(_fromkey.currentState.validate()){
                _fromkey.currentState.save();
                widget.function();

              }
            },
            color: Theme.of(context).accentColor,
              child: Text("Continue To Shipping",style: GoogleFonts.elMessiri(color: Colors.white),),
            ),
          ))
        ],
      )
            ],
      )),
    );
  }
  _fieldFocusChange(BuildContext context,FocusNode currentFocus, FocusNode nextFocus)
  {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
