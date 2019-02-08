import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWordsState extends State<RandomWords> {
  @override
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  TextEditingController _controller = new TextEditingController();
  FocusNode _textFocus = new FocusNode();

  void _pushSaved() {
    //Metodo passado como parametro no IconButton
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          //builder retorna um Scaffold, contendo a nova app bar para a nova rota
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            // Add 6 lines from here...
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          //setState dispara uma chamada para o metodo build resultando numa atualização da UI
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _onClickAdd,
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.pink,
        ),
        appBar: AppBar(
          title: Text('Gerador De Nomes'),
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: new Center(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: SizedBox(
                    child: new ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemBuilder: (context, i) {
                          //função chamada é chamada uma vez por palavra sugerida e coloca cada sugestão dentro da listView
                          if (i.isOdd)
                            return Divider(); //Adiciona uma linha de pixel antes de cada linha da lista

                          final index =
                              i ~/ 2; //divide por dois e retorna um inteiro()
                          if (index >= _suggestions.length) {
                            _suggestions.addAll(generateWordPairs().take(
                                10)); //Gera mais 10 palavras quando o usuario chega no fim do scroll
                          }
                          return _buildRow(_suggestions[index]);
                        }))),
          ],
        )));
  }

  onSave(GlobalKey<FormState> formState) {
    final first = this._controller.text.split(" ")[0];
    final secund = this._controller.text.split(" ")[1];
    this._saved.add(WordPair(first, secund));
    this._suggestions.add(WordPair(first, secund));
    formState.currentState?.reset();
    Navigator.of(context).pop();
  }

  void _onClickAdd() {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    final Size screenSize = MediaQuery.of(context).size;
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Adicionar Nomes Personalizados'),
            ),
            body: new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Form(
                key: _formKey,
                child: new ListView(
                  children: <Widget>[
                    new TextFormField(
                        controller: _controller,
                        focusNode: _textFocus,
                        keyboardType: TextInputType
                            .emailAddress, // Use email input type for emails.
                        decoration:
                            new InputDecoration(labelText: 'Digite um Nome',hintText: 'Nome e Sobrenome'),
                        onSaved: (String value) {
                          
                        }),
                    new Container(
                      width: screenSize.width,
                      child: new RaisedButton(
                        child: new Text('Salvar',
                            style: new TextStyle(color: Colors.blue)),
                        onPressed: () => onSave(_formKey),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  //Criar uma classe de state
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class MyApp extends StatelessWidget {
  final title = 'Startup Name Generator';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //linguagem que padroniza a web e o mobile
      title: title,
      home: RandomWords(),
    );
  }
}
