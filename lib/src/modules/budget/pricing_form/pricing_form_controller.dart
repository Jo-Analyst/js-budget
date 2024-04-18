import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/modules/budget/pricing_form/pricing_form_page.dart';

mixin PricingFormController on State<PricingFormPage> {
  final salaryExpectationEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final termEC = TextEditingController();
  final profitMarginEC = MoneyMaskedTextController();
  final otherTaxesEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final electricityBillEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final waterBillEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final rentEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final dasEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  void disposeForm() {
    salaryExpectationEC.dispose();
    termEC.dispose();
    profitMarginEC.dispose();
    otherTaxesEC.dispose();
    electricityBillEC.dispose();
    waterBillEC.dispose();
    rentEC.dispose();
    dasEC.dispose();
  }
}
