import 'package:flutter/material.dart';

Icon? iconPaymentsMethod(String methodPayment) {
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
    default:
      icons = Icons.payment;
      colorIcon = Colors.purple;
  }

  return Icon(icons, color: colorIcon, size: 30);
}
