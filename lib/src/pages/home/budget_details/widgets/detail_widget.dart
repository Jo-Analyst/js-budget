// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class DetailWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String title;
  const DetailWidget({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: Colors.white),
            ),
          ),
          Column(
            children: data
                .map(
                  (dt) => Column(
                    children: [
                      ListTile(
                        // contentPadding:
                        //     const EdgeInsets.symmetric(horizontal: 25),
                        title: Text(
                          dt['description'],
                          style: textTextSmallFonWeight,
                        ),
                        subtitle: Text(
                          '${dt['quantity']}x ${UtilsService.moneyToCurrency(dt['price'])}',
                          style: TextStyle(
                            fontSize: textTextSmallDefault.fontSize,
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
