
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyBppH extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: new RandomWords());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final word = new WordPair.random();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(word.asCamelCase,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        background: new Paint()
                          ..color = Colors.cyan),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center),
                new RandomWords(),
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomState();
  }
}

class RandomState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _save = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Start Name"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _gotoPage),
          new IconButton(
              icon: new Icon(Icons.access_alarm), onPressed: _gotoPage2),
          new IconButton(
              icon: new Icon(Icons.accessibility), onPressed: _gotoPage3),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair suggestion) {
    final isSaved = _save.contains(suggestion);
    return new ListTile(
      title: new Text(
        suggestion.asCamelCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        try {
          String s;
          s.trim();
        } catch (e) {
          print(e);
        }
        _gotoPage3();
        setState(() {
          if (isSaved) {
            _save.remove(suggestion);
          } else {
            _save.add(suggestion);
          }
        });
      },
    );
  }

  void _gotoPage() {
    print("hhhhhhhhhhhhhhhh");
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _save.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  void _gotoPage2() {
    var a1 = 10 / 0;
    String a;
    a.trim();
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new MyHomePage(title: 'Flutter Demo Home Page');
    }));
  }

  _gotoPage3() {
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return BasicAppBarSample();
//    }));
    print("this could be a error!");
    String s;
    s.trim();
    throw 'flutter uncaught error test';
    throw new StateError('This is a Dart exception.');
  }
}
