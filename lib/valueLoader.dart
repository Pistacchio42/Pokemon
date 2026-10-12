
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:pokemon/models/pokemon_entry_model.dart';

class valueLoader{

  valueLoader() {
    _loadCSV().then((p){
      print(p!.elementAt(1).name);
    });
  }

  List<List<dynamic>> data = [];

  Future<List<Entry>?> _loadCSV() async {
    final _rawData = await rootBundle.loadString('assets/csv/pokedex.csv');
    data = CsvToListConverter(eol: '\n').convert(_rawData);
    await Future.delayed(const Duration(seconds: 1));
    List <Entry> pokemons = [];
    print(data.length);
    data.forEach((pokemon) async{
      pokemons.add(new Entry(pokemon[1], pokemon[38], pokemon[39], pokemon[0], false, number: pokemon[0]));
    });
    return pokemons;
  }
  


}