import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/repositories/budget/transform_budget_json.dart';
import 'package:js_budget/src/repositories/budget_items/budget_item_repository_impl.dart';
import 'package:js_budget/src/repositories/material/material_repository_impl.dart';
import 'package:js_budget/src/repositories/workshop_expense_item_budget/workshop_expense_item_budget_repository_impl.dart';
import 'package:js_budget/src/repositories/material_item_budget/material_item_budget_repository_impl.dart';
import 'package:js_budget/src/repositories/order/order_repository_impl.dart';
import 'package:js_budget/src/repositories/payment/payment_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

import 'budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final _budgetItem = BudgetItemRepositoryImpl();
  final _order = OrderRepositoryImpl();
  final _materialItemBudget = MaterialItemBudgetRepositoryImpl();
  final _materialBudget = MaterialRepositoryImpl();
  final _expenseItemBudget = WorkshopExpenseItemBudgetRepositoryImpl();
  final _payment = PaymentRepositoryImpl();

  @override
  Future<Either<RespositoryException, BudgetModel>> save(
      BudgetModel budget) async {
    try {
      final Map<String, dynamic> data = {
        "value_total": budget.valueTotal,
        'created_at': DateTime.now().toIso8601String(),
        'order_id': budget.orderId,
        'freight': budget.freight,
        'client_id': budget.client!.id,
      };
      final db = await DataBase.openDatabase();
      await db.transaction(
        (txn) async {
          int budgetId = await txn.insert('budgets', data);
          await _order.changeStatusOrder(txn, budget.orderId!);
          for (var item in budget.itemsBudget!) {
            await _budgetItem.saveItem(txn, item, budgetId);
          }

          if (budget.payment != null) {
            budget.payment!.budgetId = budgetId;
            budget.payment!.id =
                await _payment.savePayment(txn, budget.payment!);
          }

          data['id'] = budgetId;
          data.remove('client_id');
          data['client'] = budget.client;
          data['items_budget'] = budget.itemsBudget;
          data['payment'] = budget.payment;
        },
      );
      return Right(TransformBudgetJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final budgets = await db.rawQuery(
          'SELECT budgets.id, budgets.value_total, budgets.status, budgets.created_at, budgets.freight, budgets.order_id, items_budget.id AS item_budget_id, items_budget.sub_value, items_budget.unitary_value, items_budget.profit_margin_value, items_budget.term, items_budget.quantity, products.name AS product_name, services.description, services.price, material_items_budget.quantity AS material_quantity, material_items_budget.value, workshop_expense_items_budget.divided_value, workshop_expense_items_budget.accumulated_value, workshop_expense_items_budget.type, materials.name AS material_name, materials.id AS material_id, clients.name AS client_name, payments.id AS payment_id, payments.specie, payments.number_of_installments, payments.amount_paid, payments.amount_to_pay FROM budgets LEFT JOIN clients ON clients.id = budgets.client_id LEFT JOIN items_budget ON items_budget.budget_id = budgets.id LEFT JOIN material_items_budget on material_items_budget.item_budget_id = items_budget.id LEFT JOIN materials ON materials.id = material_items_budget.material_id LEFT JOIN workshop_expense_items_budget ON workshop_expense_items_budget.item_budget_id = items_budget.id LEFT JOIN products ON products.id = items_budget.product_id LEFT JOIN services ON services.id = items_budget.service_id LEFT JOIN payments ON payments.budget_id = budgets.id');

      return Right(budgets);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<int> findByOrderId(int orderId) async {
    final db = await DataBase.openDatabase();
    final budget =
        await db.rawQuery('SELECT id FROM budgets WHERE order_id = $orderId');
    return budget.isNotEmpty ? budget[0]['id'] as int : 0;
  }

  @override
  Future<Either<RespositoryException, Unit>> deleteBudget(
      int budgetId, int orderId) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await delete(txn, budgetId);
        await _order.changeStatusOrder(txn, orderId, budgetWasDeleted: true);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  Future<void> delete(Transaction txn, int budgetId) async {
    await txn.delete('budgets', where: 'id = ?', whereArgs: [budgetId]);
    await _materialItemBudget.deleteMaterialItem(txn, budgetId);
    await _expenseItemBudget.deleteWorkshopExpenseItem(txn, budgetId);
    await _payment.deletePayment(txn, budgetId);
    await _budgetItem.deleteItem(txn, budgetId);
  }

  @override
  Future<Either<RespositoryException, Unit>> changeStatusAndMaterial(
      String status, int budgetId,
      {required List<MaterialItemsBudgetModel> materials,
      bool? isDecrementation}) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.update('budgets', {'status': status},
            where: 'id = ?', whereArgs: [budgetId]);

        if (materials.isNotEmpty && isDecrementation != null) {
          _materialBudget.changeStockQuantity(
            txn,
            materials,
            isDecrementation: isDecrementation,
          );
        }
      });
      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
