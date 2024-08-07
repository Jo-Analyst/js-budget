// import 'package:js_budget/src/utils/content_message.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/backup/backup_controller.dart';
import 'package:js_budget/src/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  final backupController = Injector.get<BackupController>();
  final selectedDirectory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Backup"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.backup,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const Text(
              "Para a segurança do seu sistema, gere o backup para uma futura restauração.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () async {
                  await backupController.toGenerateBackup();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: backupController.isLoadingBackup.watch(context)
                      ? loadingFourRotatingDots(context, 20)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.backup,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Backup",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
