import 'package:intl/intl.dart';

class UtilsService {
  static String moneyToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "PT-BR");
    return numberFormat.format(price);
  }

  static String dateFormat(DateTime date) {
    DateFormat dateFormat = DateFormat("dd 'de' MMMM 'de' yyyy", 'pt_BR');
    String formattedDate = dateFormat.format(date);
    final partilsDate = formattedDate.split(' ');
    String firstLetterCapitalized =
        '${partilsDate[0]} ${partilsDate[1]} ${partilsDate[2][0].toUpperCase() + partilsDate[2].substring(1)} ${partilsDate[3]} ${partilsDate[4]}';
    return firstLetterCapitalized;
  }

  static (int year, int month, int day, int hours, int minutes) extractDate(
      String date) {
    final dt = date.split('T')[0].split('-');
    final time = date.split('T')[1].split(':');
    int year = int.parse(dt[0]),
        month = int.parse(dt[1]),
        day = int.parse(dt[2]),
        hours = int.parse(time[0]),
        minutes = int.parse(time[1]);

    return (
      year,
      month,
      day,
      hours,
      minutes,
    );
  }

  static DateTime getExtractedDate(String date) {
    final (year, month, day, hours, minutes) = extractDate(date);
    return DateTime(year, month, day, hours, minutes);
  }
}
