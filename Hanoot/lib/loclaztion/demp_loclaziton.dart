import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {
 final Locale locale ;

  DemoLocalizations(this.locale);
 static DemoLocalizations of(BuildContext context) {
   return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
 }
 Map<String,String> _localizedValue ;
 Future load() async{
//   var jsonStringValue =
//       await rootBundle.loadString("lib/lang/${locale.languageCode}.json");
//   Map<String,dynamic> mappedjson = json.decode(jsonStringValue);
//   _localizedValue=mappedjson.map((key, value) => MapEntry(key, value.toString()));

}
String getTranslatedValue(String key){
   return _localizedValue[key];
}
static const LocalizationsDelegate<DemoLocalizations> delegate = DemoLocalizationsDelegate();
}
class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) async{
     DemoLocalizations loclaztion = new DemoLocalizations(locale);
     await loclaztion.load();
       return loclaztion ;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
