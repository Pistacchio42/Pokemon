import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pokemon/models/pokemon_entry_model.dart';
import 'package:pokemon/valueLoader.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokéDecks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const MyHomePage(title: 'PoKéDeX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Entry> pokemons = [];
  bool toggle = false;

  @override
  void initState() {
    super.initState();
    valueLoader all = new valueLoader();
    all.loadCSV().then((value)=> {
      setState(() {
        pokemons=value;
      })
    });

    loadPokemons();

  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(List<bool> counter) async {
    final file = await _localFile;
    counter?? [];
    String pookes ="";
    counter.forEach((value)=>{
      pookes = pookes + (value?"t":"f"),
    });
    return file.writeAsString(pookes.substring(0, pookes.length-1));
  }

  Future<List<bool>> readCounter() async {
      final file = await _localFile;
      final String contents = await file.readAsString();
      List<bool> re = [];
      contents.runes.forEach((int rune) {
        var character=new String.fromCharCode(rune);
        re.add(character=="t");
      });

    return re;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc0e9f0),
      appBar: AppBar(
        backgroundColor: Color(0xffff0000),
        actions: [
          IconButton(onPressed: openSearchDialog, icon: Icon(Icons.search))
        ],
        title: Stack(
          children: <Widget>[
            // Stroked text as border.
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 7
                  ..color = Color(0xffffffe3)!,
              ),
            ),
            // Solid text as fill.
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xffff0000),
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: pokemons.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: <Widget>[
                        pokemons[index].getEntry(resetStage,context),
                      ],
                    );
                  }
                )
            ),
          ],
        ),
      ),
    );
  }

  openSearchDialog() {
  }

  void resetStage(){
    print("setstate");
    setState(() {});
    List<bool> caught= [];
    pokemons.forEach((value)=>{
      caught.add(value.caught)
    });
    writeCounter(caught);
  }

  Future<void> loadPokemons() async {
    List<bool>  caughtPokemon = await readCounter();
    setState(() {
      for (int i =0; i< pokemons.length; i++) pokemons[i].caught=caughtPokemon[i];
    });
  }

}
