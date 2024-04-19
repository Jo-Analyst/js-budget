import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/budget/pricing_form/pricing_form_controller.dart';
import 'package:js_budget/src/modules/expenses/fixed_expenses/fixed_expense_controller.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class PricingFormPage extends StatefulWidget {
  const PricingFormPage({super.key});

  @override
  State<PricingFormPage> createState() => _PricingFormPageState();
}

class _PricingFormPageState extends State<PricingFormPage>
    with PricingFormController {
  final controller = Injector.get<FixedExpenseController>();
  final formKey = GlobalKey<FormState>();
  List<MaterialModel>? materials = [];
  List<Map<String, dynamic>> fixedExpense = [
    {'icon': Icons.lightbulb, 'type': 'Conta de luz', 'isChecked': false},
    {'icon': Icons.local_drink, 'type': 'Conta de água', 'isChecked': false},
    {'icon': Icons.home, 'type': 'Aluguel', 'isChecked': false},
    {'icon': Icons.money_off, 'type': 'DAS/SIMEI', 'isChecked': false},
    {'icon': Icons.money_off, 'type': 'Outros impostos ', 'isChecked': false},
  ];

  void toggleExpenseCheckStatus(Map<String, dynamic> expense) {
    setState(() {
      fixedExpense
          .where((fixedExp) => fixedExp['type'] == expense['type'])
          .forEach((item) => item['isChecked'] = !item['isChecked']);
    });
  }

  void calculateAverageExpense() async {
    for (var expense in fixedExpense) {
      double valueExpense = 0;
      List<ExpenseModel> model =
          await controller.findExpenseType(expense['type']);
      for (var expenseModel in model) {
        valueExpense += expenseModel.value;
      }

      if (model.isNotEmpty) {
        valueExpense = expense['type'] == 'Conta de luz' ||
                expense['type'] == 'Conta de água'
            ? valueExpense / model.length
            : valueExpense;
      }

      expense['value-average'] = valueExpense;
    }
  }

  void setInFieldsAverageExpense(String type) {
    if (type == 'Conta de luz') {
      electricityBillEC.updateValue(
          fixedExpense[0]['isChecked'] ? fixedExpense[0]['value-average'] : 0);
    }

    if (type == 'Conta de água') {
      waterBillEC.updateValue(
          fixedExpense[1]['isChecked'] ? fixedExpense[1]['value-average'] : 0);
    }

    if (type == 'Aluguel') {
      rentEC.updateValue(
          fixedExpense[2]['isChecked'] ? fixedExpense[2]['value-average'] : 0);
    }

    if (type == 'DAS/SIMEI') {
      dasEC.updateValue(
          fixedExpense[3]['isChecked'] ? fixedExpense[3]['value-average'] : 0);
    }

    if (type == 'Outros impostos') {
      otherTaxesEC.updateValue(
          fixedExpense[3]['isChecked'] ? fixedExpense[4]['value-average'] : 0);
    }
  }

  @override
  void initState() {
    super.initState();
    termEC.text = '1';
    calculateAverageExpense();
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
                  child: ColumnTile(
                    title: 'Materiais',
                    trailing: IconButton(
                      onPressed: () async {
                        materials = await Navigator.of(context)
                                .pushNamed('/material', arguments: true)
                            as List<MaterialModel>;
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: materials?.length ?? 0,
                        itemBuilder: (context, index) {
                          final material = materials![index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              'assets/images/materia-prima.png',
                              width: 25,
                            ),
                            title: Text(
                              material.name,
                              style: textStyleSmallDefault,
                            ),
                            trailing: Text(
                              UtilsService.moneyToCurrency(material.price),
                              style: TextStyle(
                                  fontFamily: 'Anta',
                                  fontSize: textStyleSmallDefault.fontSize),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ColumnTile(
                    title: 'Calcular média da despesa fixa',
                    children: fixedExpense
                        .map(
                          (expense) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              toggleExpenseCheckStatus(expense);
                              setInFieldsAverageExpense(expense['type']);
                            },
                            leading: Icon(expense['icon']),
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
                child: Column(
                  children: [
                    Card(
                      child: ColumnTile(
                        title: 'Valor da depesa fixa',
                        children: [
                          TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: electricityBillEC,
                            decoration: const InputDecoration(
                                labelText: 'Conta de luz',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.lightbulb)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (electricityBillEC.numberValue == 0) {
                                return 'Informe o valor da eletricidade';
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: waterBillEC,
                            decoration: const InputDecoration(
                                labelText: 'Conta de água',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.local_drink)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (waterBillEC.numberValue == 0) {
                                return 'Informe o valor da conta de água';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: rentEC,
                            decoration: const InputDecoration(
                                labelText: 'Aluguel',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.home)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (rentEC.numberValue == 0) {
                                return 'Informe o valor do aluguel';
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: dasEC,
                            decoration: const InputDecoration(
                                labelText: 'DAS/SIMEI',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.money_off)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (dasEC.numberValue == 0) {
                                return 'Informe o valor de DAS/SIMEI';
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: otherTaxesEC,
                            decoration: const InputDecoration(
                                labelText: 'Outros impostos',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.money_off)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (otherTaxesEC.numberValue == 0) {
                                return 'Informe o valor de outros impostos';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          children: [
                            TextFormField(
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              controller: salaryExpectationEC,
                              decoration: const InputDecoration(
                                  labelText: 'Pretensão Salarial',
                                  labelStyle: textStyleSmallDefault,
                                  suffix: Icon(Icons.price_change)),
                              keyboardType: TextInputType.number,
                              style: textStyleSmallDefault,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onTapOutside: (_) =>
                                        FocusScope.of(context).unfocus(),
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
                                    validator: Validatorless.required(
                                        'Informe o prazo'),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    onTapOutside: (_) =>
                                        FocusScope.of(context).unfocus(),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
