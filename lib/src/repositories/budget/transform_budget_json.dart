import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

class TransformBudgetJson {
  static BudgetModel fromJson(Map<String, dynamic> budget) {
    return BudgetModel(
        id: budget['id'],
        amount: budget['amount'],
        discount: budget['discount'],
        status: 'Em aberto',
        itemsBudget: budget['items_budget'],
        createdAt: budget['created_at'],
        approvalDate: budget['approval_date'],
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
            amount: budget['amount'],
            discount: budget['discount'] ?? 0,
            createdAt: budget['created_at'],
            approvalDate: budget['approval_date'],
            orderId: budget['order_id'],
            freight: budget['freight'] ?? 0,
            status: budget['status'],
            client: ClientModel(
              id: budget['client_id'],
              name: budget['client_name'],
              document: budget['document'] ?? '',
              isALegalEntity: budget['is_a_legal_entity'],
              address: budget['city'] != null
                  ? AddressModel(
                      cep: budget['cep'],
                      district: budget['district'],
                      streetAddress: budget['street_address'],
                      numberAddress: budget['number_address'],
                      city: budget['city'],
                      state: budget['state'],
                    )
                  : null,
              contact: budget['tele_phone'] != null &&
                      budget['cell_phone'] != null &&
                      budget['email'] != null
                  ? ContactModel(
                      telePhone: budget['tele_phone'],
                      cellPhone: budget['cell_phone'],
                      email: budget['email'],
                    )
                  : null,
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

      if (budget['product_name'] != null || budget['description'] != null) {
        final items = ItemsBudgetModel(
          id: budget['item_budget_id'],
          budgetId: budget['id'],
          subValue: budget['sub_value'],
          unitaryValue: budget['unitary_value'],
          subDiscount: budget['sub_discount'] ?? 0,
          quantity: budget['quantity'] ?? 1,
          term: budget['term'],
          profitMarginValue: budget['profit_margin_value'],
          product: budget['product_name'] != null
              ? ProductModel.fromJson({
                  'id': budget['product_id'],
                  'name': budget['product_name'],
                  'description': '',
                  'unit': '',
                  'quantity': 1
                })
              : null,
          service: budget['description'] != null
              ? ServiceModel.fromJson({
                  'id': budget['service_id'],
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
          final (material, expense) = _getMaterialAndExpense(items, budgets);
          items.materialItemsBudget = material;
          items.workshopExpenseItemsBudget = expense;
          tempBudgets[index].itemsBudget!.add(items);
        }
      }
    }

    List<ItemsBudgetModel> itemsBudget =
        getItemsBudgetsWithProductAndServiceDeleted(budgets);

    // return tempBudgets;
    return _addItemWithProductAndServiceDeleted(tempBudgets, itemsBudget);
  }

  static List<BudgetModel> _addItemWithProductAndServiceDeleted(
      List<BudgetModel> budgets, List<ItemsBudgetModel> itemsBudget) {
    for (var budget in budgets) {
      for (var item in itemsBudget) {
        if (budget.id == item.budgetId) {
          budget.itemsBudget!.add(item);
        }
      }
    }

    return budgets;
  }

  static List<ItemsBudgetModel> getItemsBudgetsWithProductAndServiceDeleted(
      List<Map<String, dynamic>> budgets) {
    List<ItemsBudgetModel> tempItemsBudget = [];

    for (var budget in budgets) {
      if (budget['product_name'] == null &&
          budget['description'] == null &&
          (tempItemsBudget.isEmpty ||
              !tempItemsBudget
                  .any((item) => item.id == budget['item_budget_id']))) {
        final item = ItemsBudgetModel(
          id: budget['item_budget_id'],
          budgetId: budget['id'],
          subValue: budget['sub_value'],
          unitaryValue: budget['unitary_value'],
          subDiscount: budget['sub_discount'] ?? 0,
          quantity: budget['quantity'] ?? 1,
          term: budget['term'],
          profitMarginValue: budget['profit_margin_value'],
          materialItemsBudget: [],
          workshopExpenseItemsBudget: [],
        );

        final (material, workexpense) =
            _getMaterialAndExpenseWithProductAndServiceDeleted(item, budgets);
        item.materialItemsBudget = material;
        item.workshopExpenseItemsBudget = workexpense;
        tempItemsBudget.add(item);
      }
    }

    return tempItemsBudget;
  }

  static (
    List<MaterialItemsBudgetModel> material,
    List<WorkshopExpenseItemsBudgetModel> expense
  ) _getMaterialAndExpenseWithProductAndServiceDeleted(
      ItemsBudgetModel itemBudget, List<Map<String, dynamic>> budgets) {
    for (var budget in budgets) {
      if (itemBudget.id == budget['item_budget_id'] &&
          !itemBudget.materialItemsBudget.any((itemMaterial) =>
              itemMaterial.id == budget['material_item_id']) &&
          !itemBudget.materialItemsBudget.any(
              (element) => element.material.name == budget['material_name']) &&
          budget['value'] != null &&
          budget['product_name'] == null &&
          budget['description'] == null) {
        itemBudget.materialItemsBudget.add(
          MaterialItemsBudgetModel(
            id: budget['material_item_id'],
            quantity: budget['material_quantity'] ?? 1,
            value: budget['value'],
            itemBudgetId: itemBudget.id,
            material: MaterialModel(
              id: budget['material_id'] ?? 1,
              name: budget['material_name'] ?? 'Material indefinido',
            ),
          ),
        );
      }

      if (itemBudget.id == budget['item_budget_id'] &&
          !itemBudget.workshopExpenseItemsBudget
              .any((element) => element.type == budget['type']) &&
          budget['type'] != null &&
          budget['product_name'] == null &&
          budget['description'] == null) {
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

  static (
    List<MaterialItemsBudgetModel> material,
    List<WorkshopExpenseItemsBudgetModel> expense
  ) _getMaterialAndExpense(
      ItemsBudgetModel itemBudget, List<Map<String, dynamic>> budgets) {
    for (var budget in budgets) {
      if (itemBudget.id == budget['item_budget_id'] &&
          !itemBudget.materialItemsBudget.any((itemMaterial) =>
              itemMaterial.id == budget['material_item_id']) &&
          !itemBudget.materialItemsBudget.any((itemMaterial) =>
              itemMaterial.material.name == budget['material_name']) &&
          budget['value'] != null) {
        itemBudget.materialItemsBudget.add(
          MaterialItemsBudgetModel(
            id: budget['material_item_id'],
            quantity: budget['material_quantity'] ?? 1,
            value: budget['value'],
            itemBudgetId: itemBudget.id,
            material: MaterialModel(
              id: budget['material_id'] ?? 1,
              name: budget['material_name'] ?? 'Material indefinido',
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
