import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    titleTextStyle: textStyleMediumDefault,
    color: Color(0xFFDEB887),
    toolbarHeight: 80,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFDEB887),
  ),
  primaryColor: const Color(0xFFDEB887),
  splashColor: const Color(0xFFDEB887),
  useMaterial3: true,
);

const textStyleSmallDefault = TextStyle(
  fontSize: 16,
  fontFamily: 'Poppins',
  color: Colors.black,
);
const textStyleSmallFontWeight = TextStyle(
  fontSize: 16,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
const textStyleMediumDefault = TextStyle(
  fontSize: 18,
  fontFamily: 'Poppins',
  color: Colors.black,
);
const textStyleMediumFontWeight = TextStyle(
  fontSize: 18,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
const textStyleLargeDefault = TextStyle(
  fontSize: 20,
  fontFamily: 'Poppins',
  color: Colors.black,
);
const textStyleLargeDefaultFontWeight = TextStyle(
  fontSize: 20,
  fontFamily: 'Poppins',
  color: Colors.black,
  fontWeight: FontWeight.w700,
);
