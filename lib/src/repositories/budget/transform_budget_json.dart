import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class TransformBudgetJson {
  static DateTime _getExtractedDate(String date) {
    final (year, month, day) = UtilsService.extractDate(date);
    return DateTime(year, month, day);
  }

  static BudgetModel fromJson(Map<String, dynamic> budget) {
    return BudgetModel(
        id: budget['id'],
        valueTotal: budget['value_total'],
        status: 'Em aberto',
        itemsBudget: budget['items_budget'],
        createdAt:
            UtilsService.dateFormat(_getExtractedDate(budget['created_at'])),
        client: budget['client'],
        freight: budget['freight'],
        orderId: budget['order_id'],
        payment: budget['payment']);
  }

  static List<BudgetModel> fromJsonAfterDataSearch(
      List<Map<String, dynamic>> budgets) {
    List<BudgetModel> tempBudgets = [];

    int? index;
    for (var budget in budgets) {
      int id = budget['id'];

      if (tempBudgets.isEmpty ||
          !tempBudgets.any((budget) => budget.id == id)) {
        tempBudgets.add(
          BudgetModel(
            id: budget['id'] ?? 0,
            valueTotal: budget['value_total'],
            createdAt: UtilsService.dateFormat(
                _getExtractedDate(budget['created_at'])),
            orderId: budget['order_id'],
            freight: budget['freight'] ?? 0,
            status: budget['status'],
            client: ClientModel(
              id: 0,
              name: budget['client_name'],
            ),
            payment: budget['specie'] != null
                ? PaymentModel.fromJson(
                    {
                      'id': budget['payment_id'],
                      'specie': budget['specie'],
                      'amount_to_pay': budget['amount_to_pay'],
                      'amount_paid': budget['amount_paid'],
                      'number_of_installments':
                          budget['number_of_installments'] as int
                    },
                  )
                : null,
          ),
        );
        index = index != null ? index + 1 : 0;
        tempBudgets[index].itemsBudget = [];
      }

      final items = ItemsBudgetModel(
        id: budget['item_budget_id'],
        budgetId: budget['id'],
        subValue: budget['sub_value'],
        unitaryValue: budget['unitary_value'],
        quantity: budget['quantity'] ?? 1,
        term: budget['term'],
        profitMarginValue: budget['profit_margin_value'],
        product: budget['product_name'] != null
            ? ProductModel.fromJson({
                'id': 0,
                'name': budget['product_name'],
                'description': '',
                'unit': '',
                'quantity': 1
              })
            : null,
        service: budget['description'] != null
            ? ServiceModel.fromJson({
                'id': 0,
                'description': budget['description'],
                'price': budget['price'],
                'quantity': 1
              })
            : null,
        materialItemsBudget: [],
        workshopExpenseItemsBudget: [],
      );

      if (tempBudgets[index!].itemsBudget!.isEmpty ||
          !tempBudgets[index]
              .itemsBudget!
              .any((item) => item.product?.name == budget['product_name'])) {
        final (material, expense) = getMaterialAndExpense(items, budgets);
        items.materialItemsBudget = material;
        items.workshopExpenseItemsBudget = expense;
        tempBudgets[index].itemsBudget!.add(items);
      }
    }

    return tempBudgets;
  }

  static (
    List<MaterialItemsBudgetModel> material,
    List<WorkshopExpenseItemsBudgetModel> expense
  ) getMaterialAndExpense(
      ItemsBudgetModel itemBudget, List<Map<String, dynamic>> budgets) {
    for (var budget in budgets) {
      if (itemBudget.id == budget['item_budget_id'] &&
          !itemBudget.materialItemsBudget.any(
              (element) => element.material.name == budget['material_name']) &&
          budget['product_name'] != null) {
        itemBudget.materialItemsBudget.add(
          MaterialItemsBudgetModel(
            quantity: budget['material_quantity'] ?? 1,
            value: budget['value'],
            itemBudgetId: itemBudget.id,
            material: MaterialModel(
              id: budget['material_id'] ?? 1,
              name: budget['material_name'],
            ),
          ),
        );
      }

      if (itemBudget.id == budget['item_budget_id'] &&
          !itemBudget.workshopExpenseItemsBudget
              .any((element) => element.type == budget['type']) &&
          budget['type'] != null) {
        itemBudget.workshopExpenseItemsBudget.add(
          WorkshopExpenseItemsBudgetModel(
            accumulatedValue: budget['accumulated_value'],
            dividedValue: budget['divided_value'],
            itemBudgetId: itemBudget.id,
            type: budget['type'],
          ),
        );
      }
    }
    return (
      itemBudget.materialItemsBudget,
      itemBudget.workshopExpenseItemsBudget
    );
  }
}
