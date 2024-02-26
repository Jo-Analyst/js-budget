// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class DetailWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const DetailWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Container(
      color: const Color(0xFFF8F2F2),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Serviços',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: textTitleSmall.fontSize,
            ),
          ),
          const Divider(),
          Column(
            children: data
                .map(
                  (dt) => Column(
                    children: [
                      ListTile(
                        title: Text(
                          dt['description'],
                          style: textTitleSmall,
                        ),
                        subtitle: Text(
                          '${dt['quantity']}x ${UtilsService.moneyToCurrency(dt['price'])}',
                          style: TextStyle(
                            fontSize: textTitleSmall.fontSize,
                            fontFamily: 'Anta',
                          ),
                        ),
                        trailing: Text(
                          UtilsService.moneyToCurrency(dt['price-total']),
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
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
