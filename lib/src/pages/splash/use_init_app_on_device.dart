import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/backup/backup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

class UseInitAppOnDevice extends StatefulWidget {
  const UseInitAppOnDevice({super.key});

  @override
  State<UseInitAppOnDevice> createState() => _UseInitAppOnDeviceState();
}

class _UseInitAppOnDeviceState extends State<UseInitAppOnDevice> {
  final controller = Injector.get<ProfileController>();
  final backupController = Injector.get<BackupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () => SystemNavigator.pop(),
            icon: const Icon(
              Icons.close,
              size: 35,
            ),
          ),
        ],
        title: const Text(
          "JS Planejar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_rectangular.jpeg",
                  width: 100,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Olá! Seja bem vindo. Este é o aplicativo que irá te auxiliar no seu negócio.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () async {
                        final nav = Navigator.of(context);
                        final result =
                            await backupController.restore() ?? false;

                        if (result) {
                          nav.pushReplacementNamed('/my-app');
                          await controller.findProfile();
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.restore),
                            SizedBox(width: 5),
                            Flexible(child: FlexibleText(text: "Restaurar")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/profile/form');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: FlexibleText(
                                text: "Continuar",
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
