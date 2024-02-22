import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
}
