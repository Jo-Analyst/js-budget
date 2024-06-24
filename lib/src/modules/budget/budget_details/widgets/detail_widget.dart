import 'package:flutter/material.dart';
import 'package:js_budget/src/modules/widget/icon_payments_method.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

enum DetailType { productsAndService, materials, payment, freight }

class DetailWidget extends StatelessWidget {
  final List<dynamic> data;
  final String title;
  final DetailType detailType;
  final Icon? iconPayment;
  const DetailWidget({
    Key? key,
    required this.data,
    required this.title,
    required this.detailType,
    this.iconPayment,
  }) : super(key: key);

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
        icon = iconPaymentsMethod(dt.specie)!;
      case DetailType.freight:
        title = 'Frete';
        subTitle = '1x ${UtilsService.moneyToCurrency(data.first)}';
        value = data.first;
        icon = const Icon(Icons.local_shipping);
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
                    subtitle: Text(
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
