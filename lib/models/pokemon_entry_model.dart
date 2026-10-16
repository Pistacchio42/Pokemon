import 'package:flutter/material.dart';

class Entry {
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
    "Normal": Color(0xffabab9a),
    "Fire": Color(0xffff4221),
    "Water": Color(0xff3399ff),
    "Electric": Color(0xffffcc33),
    "Grass": Color(0xff77cc56),
    "Ice": Color(0xff66ccff),
    "Fighting": Color(0xffba5543),
    "Poison": Color(0xffab559a),
    "Ground": Color(0xffdebb54),
    "Flying": Color(0xff8799ff),
    "Psychic": Color(0xffff5498),
    "Bug": Color(0xffa8ba22),
    "Rock": Color(0xffbaa966),
    "Ghost": Color(0xff6666ba),
    "Dragon": Color(0xff7866ed),
    "Dark": Color(0xff785544),
    "Steel": Color(0xffa9a9ba),
    "Fairy": Color(0xffed98ed),
  };

  Entry(
    this.name,
    this.type1,
    this.type2,
    this.sprite,
    this.caught,
    this.speed,
    this.specialDef,
    this.specialAtk,
    this.def,
    this.atk,
    this.hitPoints,
    this.ability1,
    this.ability2,
    this.secretAbility,
    this.height,
    this.weight,
    this.pokeDexColor,
    this.genderRatio,
    this.evoLevel,
    this.description,
    this.specie, {
    required this.number,
  });

  Stack getEntry(void Function() foo, context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color(0xff3b4021),
          ),
        ),
        GestureDetector(
          onTap: () => {openMenu(foo, context)},
          child: Container(
            height: 70,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              // Create a gradient background
              gradient: LinearGradient(
                begin: Alignment(0.3, 0.4),
                end: Alignment(0.3001, 0.4005),
                colors: getColors(),
              ),
            ),
            child: ListTile(
              dense: false,
              leading: Image.asset("assets/pkm/" + sprite),
              title: Text(name, style: massimoBoldMe(),),
              subtitle: Text("#"+sprite.substring(0,sprite.length-4)),
              trailing: IconButton(
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                onPressed: () => {toggleCaught(), foo()},
                icon: caught
                    ? Image.asset("assets/balls/caught.png")
                    : Image.asset("assets/balls/free.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Color> getColors() {
    if (type2 == "")
      return [?this.typeColor[this.type1], ?this.typeColor[this.type1]];
    return [?this.typeColor[this.type1], ?this.typeColor[this.type2]];
  }

  Image caughtFunc() {
    return caught
        ? Image.asset("assets/balls/caught.png")
        : Image.asset("assets/balls/free.png");
  }

  void toggleCaught() {
    print("$name caught!");
    caught = !caught;
  }

  Future<void> openMenu(void Function() foo, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Container(
            height: 600,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xffD6F6CD),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                    color: Color(0xff838471),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "INFO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  spacing: 10,
                  children: <Widget>[
                    //immagine
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset("assets/pkm/" + sprite),
                      decoration: BoxDecoration(
                        color: Color(0xffF8F7FF),
                        border: Border.all(color: Color(0xffAECA9C), width: 8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 1000,
                            padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFC7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("#"+sprite.substring(0,sprite.length-4)+" - $name", style: massimoBoldMe()),
                                Text("The $specie pokémon", style: massimoBoldMe()),
                              ],
                            ),
                          ),
                          getTypeBoxes(),
                          Text("HT $height m", style: massimoBoldMe()),
                          Text("WT $weight Kg", style: massimoBoldMe()),
                        ],
                      ),
                    ),
                    //Colonna dei dettagli, in ordine:numero nome, \n  specie Pokemon \n tipo/i  \n altezza \n peso
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(description),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F7FF),
                    border: Border.all(color: Color(0xff85ACF7), width: 8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                TextButton(
                  child: const Text('Catch!', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    toggleCaught();
                    foo();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row getTypeBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: <Widget>[
        singularCont(this.type1),
        if (this.type2 != null) singularCont(this.type2),
      ],
    );
  }

  Container singularCont(type) {
    if(type=="") return Container();
    return Container(
      alignment: Alignment.center,
      width: 70,
      height: 30,
      decoration: BoxDecoration(
        color: typeColor[type],
        border: Border.all(color: Color(0xff556553), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            type,
            style: TextStyle(
              fontSize: 15,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = Color(0xff636065),
            ),
          ),
          // Solid text as fill.
          Text(type, style: TextStyle(fontSize: 15, color: Colors.white)),
        ],
      ),
    );
  }

  TextStyle massimoBoldMe() {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  }
}
