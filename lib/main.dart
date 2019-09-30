import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/MyApp3.dart';
import 'package:flutter_app/Words.dart';
import 'package:flutter_app/catch_exception.dart';
import 'package:flutter_app/page.dart';

// 利用此全局的navigatorKey，可以实现没有context，也可以Navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Reports [error] along with its [stackTrace] to Sentry.io.
Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  // Errors thrown in development mode are unlikely to be interesting. You can
  // check if you are running in dev mode using an assertion and omit sending
  // the report.
  print(stackTrace);
  return;
}

Future<Null> main() async {
  //测试APP未捕获到的异常上报
  FlutterError.onError = (FlutterErrorDetails details) async {
    print("zone current print error");
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  print("222222222222");
  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    print("eeeeeeeeeeeeeeeerror!!!!!!!1");
    _reportError(error, stackTrace);
  });
}

class MyApp6 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp6> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter example app'),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _createTestButton("throw", _gotoPage("catch")),
              _createTestButton("words", _gotoPage("word")),
            ],
          ))),
      navigatorKey: navigatorKey,
      routes: {
        '/catch': (context) => MyApp2(),
        '/word': (context) => MyBppH(),
        '/page': (context) => BasicAppBarSample(),
        '/simple': (context) => MyApp3(),
      },
      onUnknownRoute: (RouteSettings sitting) {
        var name = sitting.name;
        print(name);
        return null;
      },
    );
  }

  Widget _createTestButton(String text, Function f) {
    return new RaisedButton(
      onPressed: f,
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Text(text),
    );
  }

  Function _gotoPage(String name) {
//    Navigator.pushNamed(context, "/catch");
    print(name);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        'catch': (context) => new MyApp2(),
        'word': (context) => new MyBppH(),
        'page': (context) => new BasicAppBarSample(),
        'simple': (context) => new MyApp3(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Demo"),
      ),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _createTestButton("catch", context),
            _createTestButton("word", context),
            _createTestButton("page", context),
            _createTestButton("simple", context),
          ],
        ),
      ),
    );
  }
}


Widget _createTestButton(String text,BuildContext context) {
  return new RaisedButton(
    onPressed: (){
      Navigator.pushNamed(context, text);
    },
    color: Colors.white,
    padding: const EdgeInsets.all(10.0),
    child: Text(text),
  );
}