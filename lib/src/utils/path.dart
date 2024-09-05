import 'package:js_budget/src/utils/utils_service.dart';

const String directory = '/storage/emulated/0/js_planejar';

const String pathDatabase =
    '/data/user/0/com.example.js_budget/databases/js_budget.db';

String pathStorageDatabase() {
  final (year, month, day, hour, minutes, seconds) =
      UtilsService.extractDate(DateTime.now().toIso8601String());

  return '/storage/emulated/0/js_planejar/js_budget_${day.toString().padLeft(2, '0')}${month.toString().padLeft(2, '0')}${year.toString().padLeft(2, '0')}_${hour.toString().padLeft(2, '0')}${minutes.toString().padLeft(2, '0')}${seconds.toString().padLeft(2, '0')}.db';
}
