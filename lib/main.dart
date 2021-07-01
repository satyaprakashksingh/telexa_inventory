import 'package:flutter/material.dart';
import 'package:telexa_inventory/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   primaryColor: Color(0xFF0A0D22),
      //   scaffoldBackgroundColor: Color(0xFF0A0D22),
      //   canvasColor: Colors.transparent,
      // ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
