// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

enum DetailType {
  productsAndService,
  materials,
}

class DetailWidget extends StatelessWidget {
  final List<ItemsBudgetModel> data;
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
              String title = dt.product != null
                  ? dt.product!.name
                  : dt.service!.description;
              return Column(
                children: [
                  ListTile(
                    leading: iconPayment,
                    title: Text(
                      title,
                      style: textStyleSmallFontWeight,
                    ),
                    subtitle: Text(
                      '${dt.quantity}x ${UtilsService.moneyToCurrency(dt.unitaryValue)}',
                      style: TextStyle(
                        fontSize: textStyleSmallDefault.fontSize,
                        fontFamily: 'Anta',
                      ),
                    ),
                    trailing: Text(
                      UtilsService.moneyToCurrency(dt.subValue),
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
