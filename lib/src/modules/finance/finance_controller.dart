import 'package:js_budget/src/helpers/message.dart';

class FinanceController with Messages {
  bool validateFieldPersonalExpense(double valueExpense) {
    bool isValid = valueExpense > 0;

    if (!isValid) {
      showInfo('Não há despesa realizada neste mês');
    }

    return isValid;
  }

  bool validateFieldWorkshopExpense(double valueRevenue, double valueExpense) {
    bool isValid = valueRevenue > 0 || valueExpense > 0;

    if (!isValid) {
      showInfo('Não há despesa e receita realizada neste mês');
    }

    return isValid;
  }
}
