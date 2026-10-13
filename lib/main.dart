import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pokemon/models/pokemon_entry_model.dart';
import 'package:pokemon/valueLoader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  List<Entry> pokemons = [];

  @override
  void initState() {
    super.initState();
    //_counter=await readCounter();
    int x = 389;

    valueLoader all = new valueLoader();
    all.loadCSV().then((value)=> {
      print((value as List<Entry>).elementAt(100).sprite),
      pokemons=value
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the counter as a string to the file.
    return file.writeAsString('$counter');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the contents of the local file.
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (_) {
      // If an error was encountered, return 0.
      return 0;
    }
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    //writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: pokemons.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: <Widget>[
                        pokemons[index].getEntry(),
                      ],
                    );
                  }
                )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
