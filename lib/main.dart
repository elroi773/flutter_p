import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("앱임", style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue),
        body: Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.all(20), //바깥 여백
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black),
          ), //Style
          //margin: EdgeInsets.fromLTRB 왼쪽 위 오른쪽 아래
          child: Text('dddd'),
        ),
      ),
    );
  }
}
