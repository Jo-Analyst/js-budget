import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
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
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: FlexibleText(
              text: 'Matérias primas',
              fontWeight: textStyleMediumFontWeight.fontWeight,
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
                                title: FlexibleText(
                                  text: item.material.name,
                                ),
                                subtitle: FlexibleText(
                                  text:
                                      '${item.quantity}x ${UtilsService.moneyToCurrency((item.value / item.quantity))}',
                                  fontFamily: 'Anta',
                                ),
                                trailing: FlexibleText(
                                  text:
                                      UtilsService.moneyToCurrency(item.value),
                                  fontFamily: 'Anta',
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
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: FlexibleText(
              text: 'Custos Indiretos',
              fontWeight: textStyleMediumFontWeight.fontWeight,
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
                              title: FlexibleText(
                                text: expense.type,
                              ),
                              subtitle: FlexibleText(
                                text:
                                    '${totalTerm}x ${UtilsService.moneyToCurrency(expense.dividedValue)}',
                                fontFamily: 'Anta',
                              ),
                              trailing: FlexibleText(
                                text: UtilsService.moneyToCurrency(
                                    (totalTerm * expense.dividedValue)),
                                fontFamily: 'Anta',
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FlexibleText(
                    text: 'Margem de Lucros',
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                  ),
                ),
                Flexible(
                  child: FlexibleText(
                    text: UtilsService.moneyToCurrency(
                        budgetController.profitMargin.value),
                    fontFamily: 'Anta',
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                    maxFontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          // Fretes
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FlexibleText(
                    text: 'Fretes',
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                  ),
                ),
                Flexible(
                  child: FlexibleText(
                    text: UtilsService.moneyToCurrency(
                        budgetController.totalFreight.value),
                    fontFamily: 'Anta',
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                    maxFontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          // Serviços
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FlexibleText(
                    text: 'Serviços',
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                  ),
                ),
                Flexible(
                  child: FlexibleText(
                    text: UtilsService.moneyToCurrency(
                        budgetController.totalService.value),
                    fontFamily: 'Anta',
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                    maxFontSize: 20,
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
