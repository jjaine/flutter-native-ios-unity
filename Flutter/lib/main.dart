import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'dart:io' show Platform;
import 'dart:async';

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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
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

enum UnityStatus { none, starting, running, stopping, error }

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('testing.ios.native/unity');
  Future<void> _startUnity() async {
    String returnStatus = await platform.invokeMethod('startUnity');

    setState(() {
      if (returnStatus == "running")
        status = UnityStatus.running;
      else
        status = UnityStatus.error;
    });
  }

  Future<void> _stopUnity() async {
    String returnStatus = await platform.invokeMethod('stopUnity');

    setState(() {
      if (returnStatus == "none")
        status = UnityStatus.none;
      else
        status = UnityStatus.error;
    });
  }

  UnityStatus status = UnityStatus.none;

  void _toggleUnity() {
    setState(() {
      if (status == UnityStatus.none) {
        status = UnityStatus.starting;
        _startUnity();
      }
      if (status == UnityStatus.running) {
        status = UnityStatus.stopping;
        _stopUnity();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    final String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    if (Platform.isIOS)
      return Scaffold(
        appBar: AppBar(title: Text("Unity testing!")),
        body: Center(
            child: SizedBox(
          width: 350,
          height: 350,
          child: UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleUnity,
          child: status == UnityStatus.none
              ? Icon(Icons.add)
              : status == UnityStatus.running
                  ? Icon(Icons.remove)
                  : null,
        ),
      );

    throw UnsupportedError("Unsupported platform view");
  }
}
