import 'package:Hanoot/models/shipping_method.dart';

class User {


  int id;
  bool loggedIn;
  String name;
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String nicename;
  String userUrl;
  String picture;
  String cookie;
  Shipping shipping;
  Billing billing;
  bool isVender;

  User.fromWoJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      username = json['username'];
      firstName = json['first_name'];
      lastName = json['last_name'];
      email = json['email'];
      shipping = Shipping.fromJson(json['shipping']);
      billing = Billing.fromJson(json['billing']);
    } catch (e) {
    }
  }

  // from WooCommerce Json
  User.fromJsonFB(Map<String, dynamic> json) {
    try {
      var user = json['user'];
      loggedIn = true;
      id = json['wp_user_id'];
      name = user['name'];
      username = user['user_login'];
      cookie = json['cookie'];
      firstName = user["first_name"];
      lastName = user["last_name"];
      email = user["email"];
      picture = user["picture"]['data']['url'] ?? '';
    } catch (e) {
    }
  }
  // from WooCommerce Json
  User.fromJsonSMS(Map<String, dynamic> json) {
    try {
      var user = json['user'];
      loggedIn = true;
      id = json['wp_user_id'];
      name = json['user_login'];
      password = json['user_pass'];
      cookie = json['cookie'];
      username = json['user_login'];
      firstName = json['user_login'];
      lastName = '';
      email = user['email'] ?? user['id'];
    } catch (e) {
    }
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "loggedIn": loggedIn,
      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "email": email,
      "password": password,
      "picture": picture,
      "cookie": cookie,
      "isVendor": isVender,
      "nicename": nicename,
      "url": userUrl
    };
  }

  User.fromLocalJson(Map<String, dynamic> json) {
    try {
      loggedIn = json['loggedIn'];
      id = json['id'];
      name = json['name'];
      cookie = json['cookie'];
      username = json['username'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      email = json['email'];
      password = json['password'];
      picture = json['picture'];
      isVender = json['isVendor'];
      nicename = json['nicename'];
      userUrl = json['url'];
    } catch (e) {
    }
  }

  // from Create User
  User.fromAuthUser(Map<String, dynamic> json, String _cookie) {
    try {
      cookie = _cookie;
      id = json['id'];
      name = json['displayname'];
      username = json['username'];
      firstName = json['firstname'];
      lastName = json['lastname'];
      email = json['email'];
      password = json['password'];
      picture = json['avatar'];
      nicename = json['nicename'];
      userUrl = json['url'];
      loggedIn = true;
      var roles = json['role'] as List;
      var role = roles.firstWhere((item) => ((item == 'seller') || (item == 'wcfm_vendor')), orElse: () => null);
      if (role != null) {
        isVender = true;
      } else {
        isVender = false;
      }
    } catch (e) {
    }
  }

  @override
  String toString() => 'User { username: $id $name $email}';
}

class UserPoints {
  int points;
  List<UserEvent> events = [];

  UserPoints.fromJson(Map<String, dynamic> json) {
    points = json['points_balance'];
    for (var event in json['events']) {
      events.add(UserEvent.fromJson(event));
    }
  }
}

class UserEvent {
  String id;
  String userId;
  String orderId;
  String date;
  String description;
  String points;

  UserEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    date = json['date_display_human'];
    description = json['description'];
    points = json['points'];
  }
}

class Billing {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postCode;
  String country;
  String state;
  String email;
  String phone;

  Billing.fromJson(Map<String, dynamic> json) {
    try {
      firstName = json['first_name'];
      lastName = json['last_name'];
      company = json['company'];
      address1 = json['address_1'];
      address2 = json['address_2'];
      city = json['city'];
      postCode = json['postcode'];
      country = json['country'];
      state = json['state'];
      email = json['email'];
      phone = json['phone'];
    } catch (e) {
    }
  }
  Map<String,dynamic> toJson(){
    return{
      'first_name':firstName,
      'last_name':lastName,
      'company':company,
      'address_1':address1,
      'address_2':address2,
      'city':city,
      'postCode':postCode,
      'country':country,
      'state':state,
      'email':email,
      'phone':phone,
    };

  }
}

class Shipping {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postCode;
  String country;
  String state;
  String email;
  String phone;
  Shipping.fromJson(Map<String, dynamic> json) {
    try {
      firstName = json['first_name'];
      lastName = json['last_name'];
      company = json['company'];
      address1 = json['address_1'];
      address2 = json['address_2'];
      city = json['city'];
      postCode = json['postcode'];
      country = json['country'];
      state = json['state'];
      email = json['email'];
      phone = json['phone'];
    } catch (e) {
    }
  }
  Map<String,dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postCode': postCode,
      'country': country,
      'state': state,
      'email': email,
      'phone': phone,
    };
  }

}