import 'package:flutter/material.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/pages/home/widgets/show_modal_widget.dart';
import 'package:js_budget/src/modules/share/widget/option_share.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class BudgetSuccessPage extends StatelessWidget {
  const BudgetSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final budget = ModalRoute.of(context)!.settings.arguments as BudgetModel;
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
                  style: textStyleSmallFontWeight,
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
                  title: Text(
                    'Pedido ${budget.orderId!.toString().padLeft(5, '0')}',
                    style: TextStyle(
                      fontSize: textStyleSmallFontWeight.fontSize,
                      fontFamily: textStyleSmallFontWeight.fontFamily,
                      fontWeight: textStyleSmallFontWeight.fontWeight,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    budget.client!.name,
                    style: TextStyle(
                      fontSize: textStyleSmallFontWeight.fontSize,
                      fontFamily: textStyleSmallFontWeight.fontFamily,
                      fontWeight: textStyleSmallFontWeight.fontWeight,
                      color: const Color.fromARGB(255, 175, 172, 172),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      // await Modal.showModal(context, const OptionShare(),
                      //     scrollControlDisabledMaxHeightRatio: .2);
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
