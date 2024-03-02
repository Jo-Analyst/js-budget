import 'package:intl/intl.dart';

class UtilsService {
  static String moneyToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "PT-BR");
    return numberFormat.format(price);
  }
}

