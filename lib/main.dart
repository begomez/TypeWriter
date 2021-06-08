import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TyperText',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TyperText'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: TyperTextWidget(
          data: StreamableTextModel(
              msg: "The quick brown fox jumps over the lazy dog"),
        ),
      ),
    );
  }
}

/**
 * Widget that displays text using a typewriter effect
 */
class TyperTextWidget extends StatelessWidget {
  final StreamableTextModel data;

  const TyperTextWidget({@required this.data, Key key})
      : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        initialData: "",
        stream: this.data.toStream(),
        builder: (BuildContext cntxt, AsyncSnapshot<String> snap) {
          if (snap.hasData) {
            return Text(snap.data);
          } else {
            return Text(
              "",
              maxLines: 3,
            );
          }
        });
  }
}

/**
 * Helper data model
 */
class StreamableTextModel {
  static const INITIAL_DELAY = 1000;
  static const STEP_DELAY = 50;
  final String msg;

  const StreamableTextModel({this.msg = ""}) : assert(msg != null);

  factory StreamableTextModel.empty() => StreamableTextModel(msg: "");

  int _getDelayForIteration(int iteration) =>
      iteration == 0 ? INITIAL_DELAY : STEP_DELAY;

  Stream<String> toStream() async* {
    for (var i = 0; i < msg.length; i++) {
      await Future.delayed(
          Duration(milliseconds: this._getDelayForIteration(i)));

      yield msg.substring(0, i + 1);
    }
  }
}
