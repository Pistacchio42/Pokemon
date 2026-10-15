import 'dart:collection';

import 'package:flutter/material.dart';

class Entry{

  final int number;
  final String name;
  final String type1;
  final String type2;
  final String sprite;
  bool caught;

  final int speed;
  final int specialDef;
  final int specialAtk;
  final int def;
  final int atk;
  final int hitPoints;
  final String ability1;
  final String ability2;
  final String secretAbility;
  final double height;
  final double weight;
  final String pokeDexColor;
  final String genderRatio;
  final String evoLevel;
  final String description;
  final String specie;

  final Map<String, Color> typeColor = {
    "Normal"    : Color(0xffabab9a),
    "Fire"      : Color(0xffff4221),
    "Water"     : Color(0xff3399ff),
    "Electric"  : Color(0xffffcc33),
    "Grass"     : Color(0xff77cc56),
    "Ice"       : Color(0xff66ccff),
    "Fighting"  : Color(0xffba5543),
    "Poison"    : Color(0xffab559a),
    "Ground"    : Color(0xffdebb54),
    "Flying"    : Color(0xff8799ff),
    "Psychic"   : Color(0xffff5498),
    "Bug"       : Color(0xffa8ba22),
    "Rock"      : Color(0xffbaa966),
    "Ghost"     : Color(0xff6666ba),
    "Dragon"    : Color(0xff7866ed),
    "Dark"      : Color(0xff785544),
    "Steel"     : Color(0xffa9a9ba),
    "Fairy"     : Color(0xffed98ed)
  };

  Entry(this.name, this.type1, this.type2, this.sprite, this.caught, this.speed,
      this.specialDef, this.specialAtk, this.def, this.atk, this.hitPoints,
      this.ability1, this.ability2, this.secretAbility, this.height, this.weight,
      this.pokeDexColor, this.genderRatio, this.evoLevel, this.description,this.specie, {required this.number});


  Stack getEntry (void Function() foo, context){
    return Stack(

      children: <Widget>[
        Container(
          height: 70,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Color(0xff3b4021),
          ),
        ),
        GestureDetector(
          onDoubleTap: ()=>{openMenu(foo,context)},
          child: Container(
            height: 60,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // Create a gradient background
                gradient: LinearGradient(
                  begin: Alignment(0.3, 0.4),
                  end: Alignment(0.3001, 0.4005),
                  colors: getColors(),
                )
            ),
            child: ListTile(
              dense: false,
              leading: SizedBox(
                child: Image.asset("assets/pkm/"+sprite),
              ),
              title: Text(name),
              subtitle: Text("#"+number.toString()),
              trailing: IconButton(onPressed: ()=>{toggleCaught(), foo()}, icon: caught? Image.asset("assets/balls/caught.png"):Image.asset("assets/balls/free.png")),
            ),
          ),
        ),
      ]
    );
  }

  List<Color> getColors(){
    if (type2 == "") return [?this.typeColor[this.type1],?this.typeColor[this.type1]];
    return [?this.typeColor[this.type1], ?this.typeColor[this.type2]];
  }

  Image caughtFunc(){
    return caught? Image.asset("assets/balls/caught.png"):Image.asset("assets/balls/free.png");
  }


  void toggleCaught() {
    print("$name caught!");
    caught=!caught;
  }

  Future<void> openMenu(void Function() foo, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The $specie pokémon'),
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Catch!'),
              onPressed: () {
                toggleCaught();
                foo();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}