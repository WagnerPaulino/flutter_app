import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWordsState extends State<RandomWords> {
@override
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {//função chamada é chamada uma vez por palavra sugerida e coloca cada sugestão dentro da listView
          if (i.isOdd) return Divider();//Adiciona uma linha de pixel antes de cada linha da lista

          final index = i ~/ 2;//divide por dois e retorna um inteiro()
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));//Gera mais 10 palavras quando o usuario chega no fim do scroll
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
        ),
        body: _buildSuggestions(),
      );
  }
}

class RandomWords extends StatefulWidget {//Criar uma classe de state
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class MyApp extends StatelessWidget {
final title = 'Startup Name Generator';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//linguagem que padroniza a web e o mobile
        title: title,
        home: RandomWords(),
    );
  }
}

