import 'package:flutter/material.dart';
import 'screens/Home.dart';

class App extends StatelessWidget {
  build(context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Home(),
    );
  }
}