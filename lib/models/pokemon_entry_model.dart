import 'dart:collection';

import 'package:flutter/material.dart';

class Entry{


  final double number;
  final String name;
  final String type1;
  final String type2;
  final String sprite;
  bool caught;
  final Map<String, Color> typeColor = {
    "Normal"    : Color(0xabab9a),
    "Fire"      : Color(0xff4221),
    "Water"     : Color(0x3399ff),
    "Electric"  : Color(0xffcc33),
    "Grass"     : Color(0x77cc56),
    "Ice"       : Color(0x66ccff),
    "Fighting"  : Color(0xba5543),
    "Poison"    : Color(0xab559a),
    "Ground"    : Color(0xdebb54),
    "Flying"    : Color(0x8799ff),
    "Psychic"   : Color(0xff5498),
    "Bug"       : Color(0xa8ba22),
    "Rock"      : Color(0xbaa966),
    "Ghost"     : Color(0x6666ba),
    "Dragon"    : Color(0x7866ed),
    "Dark"      : Color(0x785544),
    "Steel"     : Color(0xa9a9ba),
    "Fairy"     : Color(0xed98ed)
  };

  Entry(this.name, this.type1, this.type2, this.sprite, this.caught, {required this.number});


  ListTile getEntry (){
    return ListTile(
      dense: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)),
      tileColor: typeColor[this.type1],
      leading: SizedBox(
        height: 200,
        width: 100,
        child: Image.asset("assets/pkm/"+sprite),
      ),
      title: Text(name),
      subtitle: Text(number.toString()),
    );
  }

}