import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:signals/signals.dart';

class ItemBudgetController {
  final _data = ListSignal<ItemsBudgetModel>([]);
  ListSignal<ItemsBudgetModel> get data => _data;

  void add(List<ItemOrderModel> items) {
    _data.clear();
    for (var item in items) {
      if (item.product != null) {
        _data.add(ItemsBudgetModel(
            quantity: item.quantityProduct ?? 1,
            product: item.product,
            materialItemsBudget: [],
            fixedExpenseItemsBudget: []));
      }

      if (item.service != null) {
        _data.add(ItemsBudgetModel(
            quantity: item.quantityService ?? 1,
            service: item.service,
            materialItemsBudget: [],
            fixedExpenseItemsBudget: []));
      }
    }
  }

  void addMaterialsAndExpenses(int index, ProductModel product, int quantity,
      PricingController pricingController) {
    _data[index].materialItemsBudget.clear();
    _data[index].fixedExpenseItemsBudget.clear();

    _data[index]
        .materialItemsBudget
        .addAll(pricingController.materialItemsBudget);
    _data[index].quantity = quantity;
    _data[index]
        .fixedExpenseItemsBudget
        .addAll(pricingController.fixedExpenseItemsBudget);

    _data[index].term = pricingController.term;
    _data[index].timeIncentive = pricingController.timeIncentive;
    _data[index].percentageProfitMargin =
        pricingController.percentageProfitMargin;
    _data[index].profitMarginValue = pricingController.calcProfitMargin;
    _data[index].unitaryValue = pricingController.totalToBeCharged;
    _data[index].subValue = pricingController.totalToBeCharged * quantity;
  }
}
