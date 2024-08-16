import 'package:flutter/material.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> cellHeader;
  final List<ItemsBudgetModel> cellRow;
  const CustomDataTable({
    super.key,
    required this.cellHeader,
    required this.cellRow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: cellHeader
              .map(
                (header) => Expanded(
                  child: Align(
                    child: RichText(
                      text: TextSpan(
                        text: header,
                        style: textStyleSmallFontWeight,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const Divider(),
        ListView.separated(
          separatorBuilder: (_, __) => const Divider(),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cellRow.length,
          itemBuilder: (context, index) {
            final row = cellRow[index];

            return Row(
              children: [
                Expanded(
                  child: Align(
                    child: RichText(
                      text: TextSpan(
                        text: row.product != null || row.service != null
                            ? row.product?.name ?? row.service!.description
                            : 'P|S Indefinido',
                        style: textStyleSmallDefault,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    child: RichText(
                      text: TextSpan(
                        text: row.quantity.toString(),
                        style: textStyleSmallDefault,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    child: RichText(
                      text: TextSpan(
                        text: UtilsService.moneyToCurrency(row.unitaryValue),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Anta',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    child: RichText(
                      text: TextSpan(
                        text: UtilsService.moneyToCurrency(row.subValue),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Anta',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
