
// import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:Hanoot/models/user.dart' ;
import 'package:Hanoot/services/base_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState with ChangeNotifier{
  Services _service = Services();
  User user;
  bool loggedIn = false;
  bool loading = false;
  UserState() {
   // user = List();
    getUser();
  }
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.reference();
  void updateUser(Map<String, dynamic> json) {
    user.name = json['display_name'];
    user.email = json['user_email'];
    user.password = json['password'];
    user.userUrl = json['user_url'];
    user.nicename = json['user_nicename'];
    notifyListeners();
  }

  Future saveUserToFirestore() async {
    try {
      final token = await _firebaseMessaging.getToken();
    } catch (e) {
    }
  }
  Future<void> loginGoogle({Function success, Function fail}) async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      GoogleSignInAccount res = await _googleSignIn.signIn();
      GoogleSignInAuthentication auth = await res.authentication;
      user = await _service.loginGoogle(token: auth.accessToken);

      loggedIn = true;
      await saveUser(user);
      success(user);
      notifyListeners();
    } catch (err) {
      fail(
          "There is an issue with the app during request the data, please contact admin for fixing the issues " +
              err.toString());
    }
  }
  void loginUser() {
    _service.login(username: user.username, password: user.password).then((value) async{
      user = value;
      loggedIn = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      notifyListeners();
    });
  }

  /// Login by Firebase phone
  Future<void> loginFirebaseSMS({
    String phoneNumber,
    Function success,
    Function fail,
  }) async {
    try {
    user = await _service.loginSMS(token: phoneNumber);
      loggedIn = true;
      await saveUser(user);
      success(user);

      notifyListeners();
    } catch (err) {
      fail();
    }
  }

  /// Login by Facebook
  ///
///////////////////



  Future<void> saveUser(User user) async {
    final LocalStorage storage = LocalStorage("Hanoot");
    try {
      await saveUserToFirestore();
      // save to Preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);

      // save the user Info as local storage
      final ready = await storage.ready;

      if (ready) {
        await storage.setItem("userInfo", user);
      }
    } catch (err) {
    }
    notifyListeners();
  }

  Future<void> getUser() async {
    final LocalStorage storage = LocalStorage("Hanoot");
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem("userInfo");
        if (json != null) {

          user = User.fromLocalJson(json);
          loggedIn = true;
          notifyListeners();
        }
      }
    } catch (err) {
    }
    notifyListeners();

  }

  Future<void> createUser({
    username,
    password,
    firstName,
    lastName,
    isVender,
    Function success,
    Function fail,
  }) async {
    try {
      loading = true;
      notifyListeners();
      user = await _service.createUser(
          firstName: firstName, lastName: lastName, username: username, password: password, isVendor: isVender);
      loggedIn = true;
      await saveUser(user);
      success(user);

      loading = false;
      notifyListeners();
    } catch (err) {
      fail(err.toString());
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Verified', false);
    prefs.setString('phone_number',"0");
    prefs.setString('isvendor',"[subscriber]");
    user = null;
    loggedIn = false;
    final LocalStorage storage = LocalStorage("Hanoot");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.deleteItem("userInfo");
//        await storage.deleteItem("shippingAddress");
//        await storage.deleteItem("recentSearches");
//        await storage.deleteItem("wishlist");
//        await storage.deleteItem("opencart_cookie");
        storage.setItem("userInfo", null);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', false);
      }
    } catch (err) {
    }
    notifyListeners();
  }

  Future<void> login({username, password, Function success, Function fail}) async {
    try {
      loading = true;
      notifyListeners();
      user = await _service.login(
        username: username,
        password: password,
      );

      loggedIn = true;
      await saveUser(user);
      success(user);
      loading = false;
      notifyListeners();
    } catch (err) {
      loading = false;
      fail(err.toString());
      notifyListeners();
    }
  }

  Future<bool> isLogin() async {
    final LocalStorage storage = LocalStorage("Hanoot");
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem("userInfo");

        return json != null;
      }
      return false;
    } catch (err) {

      return false;
    }
  }
}