import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/modules/budget/budget_form/pricing_form/pricing_form_page.dart';

mixin PricingFormController on State<PricingFormPage> {
  final salaryExpectationEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final termEC = TextEditingController();
  final profitMarginEC = MoneyMaskedTextController();
  final otherTaxesEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
}
