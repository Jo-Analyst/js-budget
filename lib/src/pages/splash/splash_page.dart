import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final colorizeColors = [
    Colors.deepPurple,
    const Color.fromARGB(255, 20, 87, 143),
    const Color(0xFFDEB887),
    Colors.green,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0x00DEB887),
      backgroundColor: const Color(0xFFDEB887),
      body: Center(
        child: AnimatedTextKit(
          pause: Duration.zero,
          // isRepeatingAnimation: true,
          repeatForever: true,
          animatedTexts: [
            ColorizeAnimatedText(
              'JP Planejar',
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 80.0,
                fontFamily: 'Anta',
                fontWeight: FontWeight.bold,
              ),
              colors: colorizeColors,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToHome() async {
    var nav = Navigator.of(context);
    Timer(const Duration(seconds: 7), () async {
      nav.pushReplacementNamed('/my-app');
    });
  }
}