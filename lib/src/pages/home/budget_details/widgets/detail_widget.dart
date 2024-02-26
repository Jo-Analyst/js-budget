// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class DetailWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String title;
  final Icon? iconPayment;
  const DetailWidget({
    super.key,
    required this.data,
    required this.title,
    this.iconPayment,
  });

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
            color: const Color.fromARGB(255, 20, 87, 143),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 19,
                fontFamily: textTextSmallDefault.fontFamily,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: data
                .map(
                  (dt) => Column(
                    children: [
                      ListTile(
                        leading: iconPayment,
                        title: Text(
                          dt['description'] ?? dt['specie-payment'],
                          style: textTextSmallFonWeight,
                        ),
                        subtitle: Text(
                          dt['price'] != null
                              ? '${dt['quantity']}x ${UtilsService.moneyToCurrency(dt['price'])}'
                              : dt['form-of-payment'],
                          style: TextStyle(
                            fontSize: textTextSmallDefault.fontSize,
                            fontFamily:
                                iconPayment == null ? 'Anta' : 'Poppins',
                          ),
                        ),
                        trailing: Text(
                          UtilsService.moneyToCurrency(
                              dt['price-total'] ?? dt['amount-to-pay']),
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
