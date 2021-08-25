import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Dio dio = Dio();

  String baseUrl = "https://pokeapi.co/api/v2/";

  //1 - achar a base url
//2 - criar um client
//3  - criar um metodo future

  Future<Pokemon> getApiInfo() async {
    var resultado = await dio.get(baseUrl);

    Map<String,dynamic>  data =  resultado.data;

    Pokemon pokemon =  Pokemon(ability: data["ability"]);
    return pokemon;
  }
//4 - fazer a req

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(
      future: getApiInfo(),
      initialData: null,
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
        else{
          return  Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'A habilidade do pokemon é ${snapshot.data?.ability ?? "Sem habilidade"}',
                  ),
                ],
              ),
            ),
          );

        }
      }
    );
  }
}


class Pokemon {
  final String ability;

  Pokemon({
    required this.ability
});


  //metodo aqui dentro Map<String, dynamic >
}