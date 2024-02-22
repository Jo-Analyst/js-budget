import 'package:flutter/material.dart';
import 'package:js_budget/app/home/home_page.dart';
import 'package:js_budget/app/pages/splash_page.dart';
import 'package:js_budget/app/routes/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JS Planejar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        RouterPage.home: (_) => const HomePage(),
        RouterPage.splash: (_) => const SplashPage(),
      },
    );
  }
}
