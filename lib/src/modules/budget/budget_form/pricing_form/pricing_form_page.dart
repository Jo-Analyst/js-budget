import 'package:flutter/material.dart';
import 'package:js_budget/src/modules/budget/budget_form/pricing_form/pricing_form_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class PricingFormPage extends StatefulWidget {
  const PricingFormPage({super.key});

  @override
  State<PricingFormPage> createState() => _PricingFormPageState();
}

class _PricingFormPageState extends State<PricingFormPage>
    with PricingFormController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guarda Roupa'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Materiais',
                            style: textStyleSmallFontWeight,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider()
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Despesa Fixa',
                            style: textStyleSmallFontWeight,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider()
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: salaryExpectationEC,
                      decoration: const InputDecoration(
                        labelText: 'Pretensão Salarial',
                        labelStyle: textStyleSmallDefault,
                      ),
                      keyboardType: TextInputType.number,
                      style: textStyleSmallDefault,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Prazo',
                                labelStyle: textStyleSmallDefault,
                                suffixText: 'Dia(s)'),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Margem de lucro',
                                labelStyle: textStyleSmallDefault,
                                suffixText: '%'),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
