import 'package:Hanoot/models/shipping_method.dart';

class Address{
  String firstName;
  String lastName;

  String email;
  String street;
  String city;
  String state;
  String Country;
  String phoneNumber;
  String zipCode;
  Address({this.city,this.Country,this.email,this.firstName,
    this.lastName,this.phoneNumber,this.state,this.street,this.zipCode
  });

  Address.fromjson(Map<String,dynamic> datajson){
   firstName=datajson['first_name'] ;
   lastName=datajson['last_name'] ;
   email=datajson['email'] ;
   street=datajson['address_1'] ;
   city=datajson['city'] ;
   state=datajson['state'].toString() ;
   Country=datajson['country'].toString() ;
   phoneNumber=datajson['phone'] ;
   zipCode=datajson['postcode'] ;

  }

  Address.fromlocaljson(Map<String,dynamic> datajson){
    try {
      firstName = datajson['first_name'];
      lastName = datajson['last_name'];
      email = datajson['email'];
      street = datajson['address_1'];
      city = datajson['city'];
      state = datajson['state'].toString();
      Country = datajson['country'].toString();
      phoneNumber = datajson['phone'];
      zipCode = datajson['postcode'];
    }catch(e){
    }
  }
  Map<String,dynamic> toJson(){
    return{
      "first_name":firstName,
      "last_name":lastName,
      "address_1":street,
      "address_2":"",
      "city":city,
      "state":state.toString(),
      "country":Country.toString(),
      "email":email,
      "phone":phoneNumber,
      "postcode":zipCode,

    };
}
bool isValid(){
    return firstName.isNotEmpty&&
  lastName.isNotEmpty&&
  email.isNotEmpty&&
  street.isNotEmpty&&
  state.isNotEmpty&&
  Country.isNotEmpty&&
  phoneNumber.isNotEmpty;
}
@override
  String toString() {
    return '\n First Name:$firstName\n LastName:$lastName\nemail:$email\nstreet:$street\ncity:$city\nState:$state\ncountry:$Country\nPhoneNumber$phoneNumber';
  }

}