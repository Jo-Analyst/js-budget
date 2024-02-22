import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
        child: Image.asset(
          'assets/images/logo_icon.png',
          width: 200,
        ),
      ),
    );
  }

  Future<void> _navigateToHome() async {
    var nav = Navigator.of(context);
    Timer(const Duration(seconds: 3), () async {
      nav.pushReplacementNamed('/home');
    });
  }
}
