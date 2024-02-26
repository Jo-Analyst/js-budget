import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color(0xFFDEB887),
    toolbarHeight: 100,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFDEB887),
  ),
  primaryColor: const Color(0xFFDEB887),
  splashColor: const Color(0xFFDEB887),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleSmall: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
  ),
);

const textTitleSmall = TextStyle(fontSize: 18, fontFamily: 'Poppins');
const textTitleLarge = TextStyle(fontSize: 20, fontFamily: 'Poppins');
