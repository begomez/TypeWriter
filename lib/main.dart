import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        height: 100,
        width: double.maxFinite,
        color: Colors.yellow,
        alignment: Alignment.center,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: StreamBuilder<String>(
          stream: this.getData(),
          initialData: "",
          builder: (BuildContext cntxt, AsyncSnapshot<String> inc) {
            if (inc.hasData) {
              //print(this.msg.toString());

              return Text(
                inc.data,
                //key: ObjectKey(this.msg.toString().hashCode),
                style: TextStyle(fontSize: 18, color: Colors.red),
              );
            } else {
              return Text("");
            }
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Stream<String> getData() async* {
    String msg = "You have pushed the button this many times....";

    for (var i = 0; i < msg.length; i++) {
      await Future.delayed(Duration(milliseconds: i == 0 ? 1000 : 50));
      yield msg.substring(0, i);
    }
  }
}
