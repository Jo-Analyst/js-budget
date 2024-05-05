import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_form_page.dart';

mixin PricingFormController on State<PricingFormPage> {
  final preworkEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final termEC = TextEditingController();
  final percentageProfitMarginEC = MoneyMaskedTextController();
  final otherTaxesEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final electricityBillEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final waterBillEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final rentEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final dasEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final employeeSalaryEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  void disposeForm() {
    preworkEC.dispose();
    termEC.dispose();
    percentageProfitMarginEC.dispose();
    otherTaxesEC.dispose();
    electricityBillEC.dispose();
    waterBillEC.dispose();
    rentEC.dispose();
    dasEC.dispose();
    employeeSalaryEC.dispose();
  }
}
