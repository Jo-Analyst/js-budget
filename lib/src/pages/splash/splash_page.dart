import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Injector.get<ProfileController>();
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
    await controller.findProfile();
    Timer(const Duration(seconds: 7), () async {
      if (controller.model.value != null) {
        controller.model.value = controller.model.value;
        nav.pushReplacementNamed('/my-app');
        return;
      }

      nav.pushReplacementNamed('/profile/form');
    });
  }
}
