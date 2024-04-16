import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/modules/budget/pricing_form/pricing_form_controller.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:validatorless/validatorless.dart';

class PricingFormPage extends StatefulWidget {
  const PricingFormPage({super.key});

  @override
  State<PricingFormPage> createState() => _PricingFormPageState();
}

class _PricingFormPageState extends State<PricingFormPage>
    with PricingFormController {
  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> fixedExpense = [
    {'type': 'Conta de luz', 'isChecked': true},
    {'type': 'Conta de água', 'isChecked': true},
    {'type': 'Aluguel', 'isChecked': true},
    {'type': 'DAS/SIMEI', 'isChecked': true},
    {'type': 'Outros impostos ', 'isChecked': false},
  ];

  void toggleExpenseCheckStatus(Map<String, dynamic> expense) {
    setState(() {
      fixedExpense
          .where((fixedExp) => fixedExp['type'] == expense['type'])
          .forEach((item) => item['isChecked'] = !item['isChecked']);
    });

    print(fixedExpense);
  }

  @override
  void initState() {
    super.initState();
    termEC.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    final description = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(description),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                              onPressed: () async {
                                final materials = await Navigator.of(context)
                                    .pushNamed('/material', arguments: true);

                                if (materials != null) {
                                  print(materials);
                                }
                              },
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
                  child: ColumnTile(
                    title: 'Despesa Fixa',
                    children: fixedExpense
                        .map(
                          (expense) => ListTile(
                            onTap: () {
                              toggleExpenseCheckStatus(expense);
                            },
                            title: Text(
                              expense['type'],
                              style: textStyleSmallDefault,
                            ),
                            trailing: Icon(
                              expense['isChecked']
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank_rounded,
                              size: 35,
                              color: Colors.black,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Form(
                key: formKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
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
                                controller: termEC,
                                decoration: const InputDecoration(
                                    labelText: 'Prazo*',
                                    labelStyle: textStyleSmallDefault,
                                    suffixText: 'Dia(s)'),
                                style: textStyleSmallDefault,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator:
                                    Validatorless.required('Informe o prazo'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: profitMarginEC,
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
                        Visibility(
                          visible: fixedExpense[4]['isChecked'],
                          child: TextFormField(
                            controller: otherTaxesEC,
                            decoration: const InputDecoration(
                              labelText: 'Outros impostos*',
                              labelStyle: textStyleSmallDefault,
                            ),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (otherTaxesEC.numberValue == 0) {
                                return 'Informe o valor de outros impostos';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
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
