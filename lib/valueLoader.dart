
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:pokemon/models/pokemon_entry_model.dart';

class valueLoader{

  List<Entry> pkm = [];

  Future<List<Entry>> loadCSV ()  async {
    final _rawData = await rootBundle.loadString('assets/csv/pokedex2.csv');
    List<List<dynamic>> data = CsvToListConverter(eol: '\n').convert(_rawData);
    //await Future.delayed(const Duration(seconds: 1));
    //TODO trova un modo migliore di avere tutta la lista
    print(data.length);

    data.forEach((pokemon) async{
      String a = "000" + pokemon[0].toString();
      //speed = pokemon[36]
      //Special Defense = 35
      //special Attack = 34
      //Defense = 33
      //Attack = 32
      //Hit Points = 31
      //Ability 1 = 40
      //Ability 2 = 41
      //Abilità nascosta = 42
      //Altezza in metri = 44
      //Peso in kg = 46
      //percentuale cattura = 54
      //colore pokedex = 57
      // gender ratio = 58
      // evolution level = 62
      double height = pokemon[44].toDouble();
      double weight = pokemon[46].toDouble();
      String description = pokemon[63];
      String species = pokemon[64];

      pkm.add(new Entry(pokemon[1], pokemon[38], pokemon[39], a.substring(a.length-4)+".png", false, pokemon[36], pokemon[35], pokemon[34], pokemon[33],
          pokemon[32], pokemon[31], pokemon[40], pokemon[41], pokemon[42], height, weight, pokemon[57], pokemon[58], pokemon[62], description, species, number: pokemon[0]));
    });
    return pkm;
  }
  


}