// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class FinanceWidget extends StatelessWidget {
  final String title;
  final double value;
  final Color? textColor;

  const FinanceWidget({
    Key? key,
    required this.title,
    required this.value,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: lightThemeTitleSmall,
        ),
        Text(
          UtilsService.priceToCurrency(value),
          style: TextStyle(color: textColor, fontSize: 19),
        ),
      ],
    );
  }
}

// class ListTileWidget extends StatelessWidget {
//   const ListTileWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: const Text(
//         'Resumo',
//         style: lightThemeTitleSmall,
//       ),
//       subtitle: const Text(
//         'R\$ 25,00',
//         style: TextStyle(color: Colors.blue, fontSize: 19),
//       ),
//       trailing: IconButton(
//           onPressed: () {}, icon: const Icon(Icons.visibility_outlined)),
//     );
//   }
// }
