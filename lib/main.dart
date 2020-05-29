import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Animation/delayed_animation.dart';

import './Pages/Welcome.dart';
import './Pages/signUp.dart';
import './Pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Welcome(),
      routes: <String, WidgetBuilder>{
        '/signUp': (BuildContext context) => new SignUpScreen(),
        '/homepage': (BuildContext context) => new Home(),
      },
    );
  }
}
