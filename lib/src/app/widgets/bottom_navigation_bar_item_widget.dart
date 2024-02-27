import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBarItemWidget {
  static List<BottomNavigationBarItem> items() {
    return const [
      BottomNavigationBarItem(
        label: "Início",
        icon: Icon(FontAwesomeIcons.house),
      ),
      BottomNavigationBarItem(
        label: "Finanças",
        icon: Icon(Icons.auto_graph),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: "Menu",
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.person),
      //   label: "Perfil",
      // ),
    ];
  }
}
