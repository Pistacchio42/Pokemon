
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:pokemon/models/pokemon_entry_model.dart';

class valueLoader{

  List<Entry> pkm = [];

  Future<List<Entry>> loadCSV ()  async {
    final _rawData = await rootBundle.loadString('assets/csv/pokedex.csv');
    List<List<dynamic>> data = CsvToListConverter(eol: '\n').convert(_rawData);
    //await Future.delayed(const Duration(seconds: 1));
    //TODO trova un modo migliore di avere tutta la lista
    print(data.length);

    data.forEach((pokemon) async{
      String a = "000" + pokemon[0].toString();
      pkm.add(new Entry(pokemon[1], pokemon[38], pokemon[39], a.substring(a.length-4)+".png", false, number: pokemon[0]));
    });
    return pkm;
  }
  


}