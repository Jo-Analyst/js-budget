import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class SummaryWorkshopBudgetPage extends StatelessWidget {
  const SummaryWorkshopBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetController = context.get<BudgetController>();
    final (workShopExpense, totalTerm, materialItem) =
        ModalRoute.of(context)!.settings.arguments as (
      List<WorkshopExpenseItemsBudgetModel>,
      int,
      List<MaterialItemsBudgetModel>
    );

    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
            fit: BoxFit.scaleDown, child: Text('Balanço Geral')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Matérias primas',
              style: textStyleSmallFontWeight,
            ),
          ),
          Flexible(
            flex: 6,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: materialItem
                      .map((item) => Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.build,
                                  size: 25,
                                ),
                                title: Text(
                                  item.material.name,
                                  style: textStyleSmallDefault,
                                ),
                                subtitle: Text(
                                  '${item.quantity}x ${UtilsService.moneyToCurrency((item.value / item.quantity))}',
                                  style: TextStyle(
                                    fontFamily: 'Anta',
                                    fontSize: textStyleSmallDefault.fontSize,
                                  ),
                                ),
                                trailing: Text(
                                  UtilsService.moneyToCurrency(item.value),
                                  style: TextStyle(
                                    fontFamily: 'Anta',
                                    fontSize: textStyleSmallDefault.fontSize,
                                  ),
                                ),
                              ),
                              const Divider(height: 0)
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          Divider(thickness: 16, color: Theme.of(context).primaryColor),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Custos Indiretos',
              style: textStyleSmallFontWeight,
            ),
          ),

          // Custos Indiretos
          Flexible(
            flex: 6,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: workShopExpense
                      .map(
                        (expense) => Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.monetization_on_outlined,
                                size: 30,
                              ),
                              title: Text(
                                expense.type,
                                style: textStyleSmallDefault,
                              ),
                              subtitle: Text(
                                '${totalTerm}x ${UtilsService.moneyToCurrency(expense.dividedValue)}',
                                style: TextStyle(
                                  fontFamily: 'Anta',
                                  fontSize: textStyleSmallDefault.fontSize,
                                ),
                              ),
                              trailing: Text(
                                UtilsService.moneyToCurrency(
                                    (totalTerm * expense.dividedValue)),
                                style: TextStyle(
                                  fontFamily: 'Anta',
                                  fontSize: textStyleSmallDefault.fontSize,
                                ),
                              ),
                            ),
                            const Divider(height: 0)
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),

          Divider(thickness: 16, color: Theme.of(context).primaryColor),

          // Margem de Lucros
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Margem de Lucros',
                  style: textStyleSmallFontWeight,
                ),
                Text(
                  UtilsService.moneyToCurrency(
                      budgetController.profitMargin.value),
                  style: TextStyle(
                    fontFamily: 'Anta',
                    fontWeight: textStyleSmallFontWeight.fontWeight,
                    fontSize: 23,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
