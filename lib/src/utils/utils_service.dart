import 'package:intl/intl.dart';

class UtilsService {
  static String moneyToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "PT-BR");
    return numberFormat.format(price);
  }

  static String monthFormat(DateTime date) {
    DateFormat dateFormat = DateFormat("MMMM 'de' yyyy", 'pt_BR');
    String formattedDate = dateFormat.format(date);
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }
}
