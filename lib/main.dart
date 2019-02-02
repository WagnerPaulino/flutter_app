import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWordsState extends State<RandomWords> {
@override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}

class RandomWords extends StatefulWidget {//Criar uma classe de state
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class MyApp extends StatelessWidget {
final title = 'Welcome to Flutter';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//linguagem que padroniza a web e o mobile
      home: Scaffold(//Scaffot fornece um app bar padrão
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

