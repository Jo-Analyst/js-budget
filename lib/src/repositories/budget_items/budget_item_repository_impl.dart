import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/repositories/fixed_expense_item_budget/fixed_expense_item_budget_repository_impl.dart';
import 'package:js_budget/src/repositories/material_item_budget/material_item_budget_repository_impl.dart';
import 'package:sqflite/sqflite.dart';
import './budget_item_repository.dart';

class BudgetItemRepositoryImpl implements BudgetItemRepository {
  final _materialItemBudget = MaterialItemBudgetRepositoryImpl();
  final _expenseItemBudget = FixedExpenseItemBudgetRepositoryImpl();

  @override
  Future<void> saveItem(
      Transaction txn, ItemsBudgetModel itemsBudget, int budgetId) async {
    int lastId = await txn.insert('items_budget', {
      'sub_value': itemsBudget.subValue,
      'unitary_value': itemsBudget.unitaryValue,
      'quantity': itemsBudget.quantity,
      'term': itemsBudget.term,
      'time_incentive': itemsBudget.timeIncentive,
      'percentage_profit_margin': itemsBudget.percentageProfitMargin,
      'profit_margin_value': itemsBudget.profitMarginValue,
      'product_id': itemsBudget.product?.id,
      'service_id': itemsBudget.service?.id,
      'budget_id': budgetId,
    });

    itemsBudget.materialItemsBudget.asMap().forEach((key, materialItem) {
      _materialItemBudget.saveMaterialItemBudget(txn, materialItem, lastId);
    });

    itemsBudget.fixedExpenseItemsBudget.asMap().forEach((key, expenseItem) {
      _expenseItemBudget.saveExpenseItemBudget(txn, expenseItem, lastId);
    });
  }

 

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findMaterialsByBudgetId(int budgetId) async {
    try {
      final db = await DataBase.openDatabase();
      final itemsBudget = await db.rawQuery(
          'SELECT SUM(material_items_budget.quantity) AS quantity, SUM(material_items_budget.value) AS value, materials.name FROM budgets INNER JOIN  items_budget ON items_budget.budget_id = budgets.id INNER JOIN material_items_budget ON material_items_budget.item_budget_id = items_budget.id INNER JOIN materials ON materials.id = material_items_budget.material_id WHERE items_budget.budget_id = $budgetId GROUP BY materials.id');

      return Right(itemsBudget);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
