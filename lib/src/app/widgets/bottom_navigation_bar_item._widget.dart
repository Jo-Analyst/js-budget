import 'package:flutter/material.dart';

class BottomNavigationBarItemWidget {
  static List<BottomNavigationBarItem> items() {
    return const [
      BottomNavigationBarItem(
        label: "Início",
        icon: Icon(Icons.home_filled),
      ),
      BottomNavigationBarItem(
        label: "Resumo",
        icon: Icon(Icons.auto_graph),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet_outlined),
        label: "Orçamento",
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.person),
      //   label: "Perfil",
      // ),
    ];
  }
}
