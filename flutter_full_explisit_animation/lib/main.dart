import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Explicit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _rotationAnimation;
  static final tween = Tween<double>(begin: 0, end: 1);
  static final rotationTween = Tween<double>(begin: 0, end: 2 * pi);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.fling();
            }
          });
    _animation = tween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInQuint));
    _rotationAnimation = tween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyan,
                ),
                width: 150,
                height: 150,
                child: const Center(child: Text('Animation')),
              ),
            ),
            Opacity(
              opacity: _animation.value,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple,
                ),
                width: 250,
                height: 250,
                child: const Center(
                  child: Text('Explicit Animation'),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _controller.forward();
                },
                child: const Text('Click here'))
          ],
        ),
      ),
    );
  }
}
