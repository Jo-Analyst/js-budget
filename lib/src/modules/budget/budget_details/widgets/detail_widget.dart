// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:js_budget/src/modules/widget/custom_icons.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';

enum DetailType {
  products,
  service,
  materials,
  payment,
  expense,
  outher,
  inconclusiveData
}

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
      case DetailType.products:
        title = dt.name;
        subTitle = '${dt.quantity}x ${UtilsService.moneyToCurrency(dt.price)}';
        value = dt.price * dt.quantity;
        icon = const Icon(Icons.local_offer);
      case DetailType.service:
        title = dt.description;
        subTitle = '${dt.quantity}x ${UtilsService.moneyToCurrency(dt.price)}';
        value = dt.price * dt.quantity;
        icon = const Icon(Icons.local_offer);
      case DetailType.inconclusiveData:
        title = dt['description'];
        subTitle =
            '${dt['quantity']}x ${UtilsService.moneyToCurrency(dt['price'])}';
        value = dt['price'] * dt['quantity'];
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
            : dt['type'].toLowerCase() == 'desconto'
                ? Icons.local_offer
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
              child: FlexibleText(
                text: title,
                fontWeight: textStyleMediumFontWeight.fontWeight,
              )),
          Column(
            children: data.map((dt) {
              final (title, subTitle, value, icon) = setValueInListTile(dt);
              return Column(
                children: [
                  ListTile(
                    leading: icon,
                    title: FlexibleText(
                      text: title,
                    ),
                    subtitle: subTitle.isEmpty
                        ? null
                        : FlexibleText(
                            text: subTitle,
                            fontFamily: 'Anta',
                          ),
                    trailing: FlexibleText(
                      text: UtilsService.moneyToCurrency(value),
                      colorText: Colors.green,
                      fontFamily: 'Anta',
                      fontWeight: textStyleMediumFontWeight.fontWeight,
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
