
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor){
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if(hexColor.length==6){
      hexColor = "FF"+hexColor;
    }
    return int.parse(hexColor,radix: 16);
  }
  HexColor(final String  hexColor) : super(_getColorFromHex(hexColor));
}
final colors = {
  "aliceblue":"#f0f8ff",
  "antiquewhite":"#faebd7",
  "aque":"#00ffff",
  "aquamarine":"#7fffd4",
  "azure":"#f0ffff",
};
final List<Color> color = <Color>[Colors.red, Colors.blue,Colors.amber, Colors.blue,Colors.amber, Colors.blue,Colors.amber, Colors.blue,Colors.amber,Colors.red, Colors.blue,Colors.amber,Colors.red, Colors.blue,Colors.amber];
final Map<String,Color> colorss = {
  "amber": Color(0xFFFFBF00),
  "amethyst": Color(0xFF9966CC),
  "apricot": Color(0xFFFBCEB1),
  "aquamarine": Color(0xFF7FFFD4),
  "azure": Color(0xFF007FFF),
  "baby blue": Color(0xFF89CFF0),
  "beige": Color(0xFFF5F5DC),
  "black": Color(0xFF000000),
  "blue": Color(0xFF0000FF),
  "blue-green": Color(0xFF0095B6),
  "blue-violet": Color(0xFF8A2BE2),
  "blush": Color(0xFFDE5D83),
  "bronze": Color(0xFFCD7F32),
  "brown": Color(0xFF964B00),
  "burgundy": Color(0xFF800020),
  "byzantium": Color(0xFF702963),
  "carmine": Color(0xFF960018),
  "cerise": Color(0xFFDE3163),
  "cerulean": Color(0xFF007BA7),
  "champagne": Color(0xFFF7E7CE),
  "chartreuse green": Color(0xFF7FFF00),
  "chocolate": Color(0xFF7B3F00),
  "cobalt blue": Color(0xFF0047AB),
  "coffee": Color(0xFF6F4E37),
  "copper": Color(0xFF6F4E37),
  "coral": Color(0xFFFF7F50),
  "crimson": Color(0xFFDC143C),
  "cyan": Color(0xFF00FFFF),
  "desert sand": Color(0xFFEDC9Af),
  "electric blue": Color(0xFF7DF9FF),
  "emerald": Color(0xFF50C878),
  "erin": Color(0xFF00FF3F),
  "gold": Color(0xFFFFD700),
  "gray": Color(0xFF808080),
  "green": Color(0xFF008000),
  "harlequin": Color(0xFF3FFF00),
  "indigo": Color(0xFF4B0082),
  "ivory": Color(0xFFFFFFF0),
  "jade": Color(0xFF00A86B),
  "jungle green": Color(0xFF29AB87),
  "lavender": Color(0xFFB57EDC),
  "lemon": Color(0xFFFFF700),
  "lilac": Color(0xFFC8A2C8),
  "lime": Color(0xFFBFFF00),
  "magenta": Color(0xFFFF00FF),
  "magenta rose": Color(0xFFFF00AF),
  "maroon": Color(0xFF800000),
  "mauve": Color(0xFFE0B0FF),
  "navy blue": Color(0xFF000080),
  "ochre": Color(0xFFCC7722),
  "olive": Color(0xFF808000),
  "orange": Color(0xFFFF6600),
  "orange-red": Color(0xFFFF4500),
  "orchid": Color(0xFFDA70D6),
  "peach": Color(0xFFFFE5B4),
  "pear": Color(0xFFD1E231),
  "periwinkle": Color(0xFFCCCCFF),
  "persian blue": Color(0xFF1C39BB),
  "pink": Color(0xFFFD6C9E),
  "plum": Color(0xFF8E4585),
  "prussian blue": Color(0xFFCC8899),
  "puce": Color(0xFFCC8899),
  "purple": Color(0xFF800080),
  "raspberry": Color(0xFFE30B5C),
  "red": Color(0xFFFF0000),
  "red-violet": Color(0xFFC71585),
  "rose": Color(0xFFFF007F),
  "ruby": Color(0xFFE0115F),
  "salmon": Color(0xFFFA8072),
  "sangria": Color(0xFF92000A),
  "sapphire": Color(0xFF0F52BA),
  "scarlet": Color(0xFFFF2400),
  "silver": Color(0xFFC0C0C0),
  "slate gray": Color(0xFF708090),
  "tan": Color(0xFFD2B48C),
  "taupe": Color(0xFF483C32),
  "teal": Color(0xFF008080),
  "turquoise": Color(0xFF40E0D0),
  "ultramarine": Color(0xFF3F00FF),
  "violet": Color(0xFF7F00FF),
  "viridian": Color(0xFF40826D	),
  "white": Color(0xFFFFFFFF),
  "yellow": Color(0xFFFFFF00),
};
const Gray = Color(0xFF546E7A);
const Green = Color(0xffF4F5F5);

const yellow = Color(0xffF1F2F3);
const Blue = Color(0xff121212);
const Black = Color(0xff1E1E1E);
const Red = Colors.red;