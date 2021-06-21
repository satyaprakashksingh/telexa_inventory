import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telexa Inventory'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black26,
      ),
      body: Container(
        child: IconButton(
          icon: Icon(Icons.scanner),
          onPressed: () {},
        ),
      ),
    );
  }
}
