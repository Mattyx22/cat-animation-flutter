import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  const Cat({Key? key}) : super(key: key);

  @override
  build (context) {
    return Image.network(
      'https://i.imgur.com/QwhZRyL.png',
    );
  }
}