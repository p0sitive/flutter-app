
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyAppState2 createState() => _MyAppState2();
}

class _MyAppState2 extends State<MyApp2> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion = "asdasd"; //await Bugly.platformVersion;
      platformVersion = "asdasd"; //await Bugly.platformVersion;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  _onClick() {
    throw 'bugly flutter uncaught error test';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _onClick,
                  child: Text('Running on: $_platformVersion\n'),
                ),
                Text("text!!!!"),
                RaisedButton(
                  onPressed: () {
                    String sss;
                    sss.substring(2);

                    //加try-catch自己捕获
                    try {
                      throw("hhhh-->exception");
                    } catch (e, stack) {
                      debugPrint(stack.toString());
                    }
                  },
                  child: Text("clicked"),
                )
              ],
            )),
      ),
    );
  }
}