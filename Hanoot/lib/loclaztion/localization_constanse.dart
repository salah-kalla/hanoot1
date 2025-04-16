import 'package:flutter/material.dart';
import 'package:Hanoot/loclaztion/demp_loclaziton.dart';
String getTranslated(BuildContext context,String key){
  return DemoLocalizations.of(context).getTranslatedValue(key);
}