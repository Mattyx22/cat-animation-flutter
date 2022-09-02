import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    super.initState();

    boxController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if (boxController.status == AnimationStatus.completed) {
      boxController.reverse();
    } else if (boxController.status == AnimationStatus.dismissed) {
      boxController.forward();
    }
    });

    boxController.forward();

    catController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );

    catAnimation = Tween(begin: -35.0, end: -80.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation!'),
      ),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          top: catAnimation.value,
          left: 0,
          right: 0,
          child: const Cat(),
        );
      },
    );
  }

  Widget buildBox() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Positioned(
            left: 3,
            child: Transform.rotate(
              angle: boxAnimation.value,
              alignment: Alignment.topLeft,
              child: Container(
                height: 10,
                width: 125,
                color: Colors.brown,
              ),
            ),
          );
        });
  }

  Widget buildRightFlap() {
    return AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Positioned(
            right: 3,
            child: Transform.rotate(
              angle: -boxAnimation.value,
              alignment: Alignment.topRight,
              child: Container(
                height: 10,
                width: 125,
                color: Colors.brown,
              ),
            ),
          );
        });
  }
}
