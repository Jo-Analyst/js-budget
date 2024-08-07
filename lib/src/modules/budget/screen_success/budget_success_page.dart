import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

class BudgetSuccessPage extends StatelessWidget {
  const BudgetSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final budget = Injector.get<BudgetController>().model.value;

    void closeScreen() {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/my-app', (route) => false);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => closeScreen(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () => closeScreen(),
                icon: const Icon(
                  Icons.close,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Orçamento  criado com sucesso',
                  textAlign: TextAlign.center,
                  style: textStyleMediumFontWeight,
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 20, 87, 143),
                maxRadius: 100,
                child: Icon(
                  Icons.thumb_up,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 20, 87, 143),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: FlexibleText(
                    text:
                        'Pedido ${budget.orderId!.toString().padLeft(5, '0')}',
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                    colorText: Colors.white,
                  ),
                  subtitle: FlexibleText(
                    text: budget.client!.name,
                    fontWeight: textStyleMediumFontWeight.fontWeight,
                    colorText: const Color.fromARGB(255, 175, 172, 172),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/share');
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
