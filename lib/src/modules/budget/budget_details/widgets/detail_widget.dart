// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/modules/widget/custom_icons.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

enum DetailType { productsAndService, materials, payment, expense, outher }

class DetailWidget extends StatelessWidget {
  final List<dynamic> data;
  final String title;
  final DetailType detailType;
  final Icon? iconPayment;
  final int? term;
  const DetailWidget({
    super.key,
    required this.data,
    required this.title,
    required this.detailType,
    this.iconPayment,
    this.term,
  });

  (String title, String subtitle, double value, Icon icon) setValueInListTile(
      dynamic dt) {
    String title = '';
    String subTitle = '';
    double value = 0;
    Icon icon;

    switch (detailType) {
      case DetailType.productsAndService:
        title = dt.product != null ? dt.product!.name : dt.service!.description;
        subTitle =
            '${dt.quantity}x ${UtilsService.moneyToCurrency(dt.unitaryValue)}';
        value = value = dt.subValue;
        icon = const Icon(Icons.local_offer);
      case DetailType.materials:
        title = dt.material.name;
        subTitle =
            '${dt.quantity}x ${UtilsService.moneyToCurrency(dt.value / dt.quantity)}';
        value = dt.value;
        icon = const Icon(Icons.build);
      case DetailType.payment:
        title = dt.specie;
        subTitle =
            '${dt.numberOfInstallments}x ${UtilsService.moneyToCurrency(dt.amountToPay / dt.numberOfInstallments)}';
        value = value = dt.amountToPay;
        icon = CustomIcons.paymentsMethod(dt.specie)!;

      case DetailType.outher:
        title = dt['type'];
        subTitle = '';
        value = dt['value'];
        icon = Icon(dt['type'].toLowerCase() == 'frete'
            ? Icons.monetization_on
            : Icons.local_shipping);
      case DetailType.expense:
        title = dt.type;
        subTitle = '${term}x ${UtilsService.moneyToCurrency(dt.dividedValue)}';
        value = term! * dt.dividedValue as double;
        icon = CustomIcons.workShopExpense(dt.type)!;
    }

    return (title, subTitle, value, icon);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFFF8F2F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            color: Theme.of(context).primaryColor,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 19,
                fontFamily: textStyleSmallDefault.fontFamily,
              ),
            ),
          ),
          Column(
            children: data.map((dt) {
              final (title, subTitle, value, icon) = setValueInListTile(dt);
              return Column(
                children: [
                  ListTile(
                    leading: icon,
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: textStyleSmallFontWeight,
                      ),
                    ),
                    subtitle: subTitle.isEmpty
                        ? null
                        : Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: textStyleSmallDefault.fontSize,
                              fontFamily: 'Anta',
                            ),
                          ),
                    trailing: Text(
                      UtilsService.moneyToCurrency(value),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                        fontFamily: 'Anta',
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
