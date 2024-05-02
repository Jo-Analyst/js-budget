import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:signals/signals.dart';

class PricingController with Messages {
  double totalMaterialValue = 0,
      totalExpenseValue = 0,
      totalToBeCharged = 0,
      calcProfitMargin = 0,
      percentageProfitMargin = 0;
  int term = 1;
  String timeIncentive = 'Dia';

  final _materialItemsBudget = ListSignal<MaterialItemsBudgetModel>([]);
  ListSignal<MaterialItemsBudgetModel> get materialItemsBudget =>
      _materialItemsBudget
        ..sort(
          (a, b) => a.material.name
              .toLowerCase()
              .compareTo(b.material.name.toLowerCase()),
        );

  final fixedExpenseItemsBudget = ListSignal<FixedExpenseItemsBudgetModel>([]);

  bool validate(List<MaterialItemsBudgetModel> materials) {
    if (materials.isEmpty) {
      showInfo('Informe os materiais que será adicionado no orçamento');
    }

    return materials.isNotEmpty;
  }

  void addMaterialInListMaterial(List<MaterialModel> materials) {
    List<MaterialItemsBudgetModel> materialsForAdd = materials
        .map(
          (material) => MaterialItemsBudgetModel(
            value: material.price,
            material: material,
            quantity: 1,
          ),
        )
        .toList();

    if (materialItemsBudget.isEmpty) {
      _materialItemsBudget.addAll(materialsForAdd);
    } else {
      _materialItemsBudget.addAll(
        materialsForAdd.where(
          (materialToAdd) => !_materialItemsBudget.any(
            (existingMaterial) =>
                existingMaterial.material.id == materialToAdd.material.id,
          ),
        ),
      );
    }
  }

  void calculateSubTotalMaterial(
      MaterialItemsBudgetModel materialItemsBudget, double price) {
    materialItemsBudget.value = materialItemsBudget.quantity * price;
  }

  void calculateTotalMaterial() {
    totalMaterialValue = 0;
    _materialItemsBudget.asMap().forEach((_, materialItem) {
      totalMaterialValue += materialItem.value;
    });
  }

  void calculateTotalExpenses() {
    totalExpenseValue = 0;
    fixedExpenseItemsBudget.asMap().forEach((key, expenseItem) {
      totalExpenseValue += expenseItem.accumulatedValue;
    });
  }

  void calculateExpensesByPeriodForEachExpense(
      int index, String timeIncentive, double valueExpense, int termEC) {
    fixedExpenseItemsBudget[index].value = valueExpense;

    double dividedValue =
        timeIncentive == "Dia" ? valueExpense / 30 : (valueExpense / 30) / 8;

    fixedExpenseItemsBudget[index].dividedValue = dividedValue;
    fixedExpenseItemsBudget[index].accumulatedValue = dividedValue * termEC;
  }

  void deleteMaterial(MaterialItemsBudgetModel materialItem) {
    materialItemsBudget.removeWhere(
        (element) => element.material.id == materialItem.material.id);
    totalMaterialValue -= materialItem.value;
  }

  void calculateProfitMargin() {
    double totalCost = totalExpenseValue + totalMaterialValue;
    calcProfitMargin = totalCost * (percentageProfitMargin / 100);
  }

  void calculateTotalToBeCharged() {
    totalToBeCharged =
        totalExpenseValue + totalMaterialValue + calcProfitMargin;
  }

  void clearFields() {
    totalMaterialValue = 0;
    totalExpenseValue = 0;
    totalToBeCharged = 0;
    percentageProfitMargin = 0;
    calcProfitMargin;
    term = 1;
    timeIncentive = 'Dia';
    materialItemsBudget.clear();
    fixedExpenseItemsBudget.clear();
  }
}
