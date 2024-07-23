import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/backup.dart';
import 'package:js_budget/src/utils/permission_use_app.dart';
import 'package:signals/signals.dart';
import 'package:file_picker/file_picker.dart';

class BackupController with Messages {
  final isLoadingBackup = signal<bool>(false),
      isLoadingRestore = signal<bool>(false);
  Future<void> toGenerateBackup() async {
    if (!await isGranted()) return;

    isLoadingBackup.value = true;
    final response = await Backup.toGenerate();
    isLoadingBackup.value = false;

    if (response != null) {
      showError(
          'Houve um problema ao realizar o backup. Tente novamente. Caso o problema persista, acione o suporte.');

      return;
    }

    showSuccess('Backup foi executado.');

    await Future.delayed(
      const Duration(milliseconds: 3200),
    );
  }

  void restore() async {
    if (!await isGranted()) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path ?? '';
      int filePathLength = filePath.split(".").length;
      String extension = filePath.split(".")[filePathLength - 1];
      if (extension != "db") {
        showError('Arquivo de backup inválido!');

        return;
      }

      isLoadingRestore.value = true;
      // await DB.openDatabase();
      final response = await Backup.restore(filePath);
      isLoadingRestore.value = false;
      if (response != null) {
        showError(
            'Houve um problema ao realizar a restauração. Caso o problema persista, acione o suporte.');

        return;
      }

      // navigateToHome();
    }
  }
}
