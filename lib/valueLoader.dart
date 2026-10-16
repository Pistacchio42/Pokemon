
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:pokemon/models/pokemon_entry_model.dart';

class valueLoader{

  List<Entry> pkm = [];
  Map<String, int> reverseSearch = {};

  Future<List<Entry>> loadCSV ()  async {
    final _rawData = await rootBundle.loadString('assets/csv/pokedex2.csv');
    List<List<dynamic>> data = CsvToListConverter(eol: '\n').convert(_rawData);
    print(data.length);
    data.forEach((pokemon) async{

      reverseSearch[pokemon[1]] = pokemon[0];

      String a = "000" + pokemon[0].toString();
      double height = pokemon[44].toDouble();
      double weight = pokemon[46].toDouble();
      String description = pokemon[63];
      String species = pokemon[64];

      pkm.add(new Entry(pokemon[1], pokemon[38], pokemon[39], a.substring(a.length-4)+".png", false, pokemon[36], pokemon[35], pokemon[34], pokemon[33],
          pokemon[32], pokemon[31], pokemon[40], pokemon[41], pokemon[42], height, weight, pokemon[57], pokemon[58], pokemon[62], description, species, number: pokemon[0]));
    });
    return pkm;
  }

  Future<Map<String, int>> getReverseList () async{
    return reverseSearch;
  }
  


}