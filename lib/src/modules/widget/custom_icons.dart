import 'package:flutter/material.dart';

class CustomIcons {
  static Icon? paymentsMethod(String methodPayment) {
    IconData? icons;
    Color colorIcon = Colors.black;

    switch (methodPayment.toLowerCase()) {
      case 'nenhum':
        icons = Icons.money_off_csred_outlined;
      case 'pix':
        icons = Icons.pix;
        colorIcon = const Color.fromARGB(255, 40, 97, 42);
      case 'dinheiro':
        icons = Icons.monetization_on_outlined;
        colorIcon = Colors.blueGrey;
      case 'não definido':
        icons = Icons.attach_money;
      default:
        icons = Icons.payment;
        colorIcon = methodPayment.toLowerCase() == 'débito'
            ? const Color.fromARGB(255, 45, 76, 102)
            : Colors.red;
    }

    return Icon(icons, color: colorIcon, size: 30);
  }

  static Icon? workShopExpense(String type) {
    IconData? icons;
    Color colorIcon = Colors.black;
    switch (type) {
      case 'Conta de luz':
        icons = Icons.lightbulb;
        colorIcon = const Color(0xFFdaa520);
      case 'Conta de água':
        icons = Icons.local_drink;
        colorIcon = const Color(0xFF278163);
      case 'Aluguel':
        icons = Icons.home;
        colorIcon = Colors.grey;
      case 'DAS/SIMEI':
        icons = Icons.money_off;
        colorIcon = Colors.redAccent;
      default:
        icons = Icons.account_balance;
        colorIcon = Colors.greenAccent;
    }
    return Icon(icons, color: colorIcon, size: 30);
  }
}
