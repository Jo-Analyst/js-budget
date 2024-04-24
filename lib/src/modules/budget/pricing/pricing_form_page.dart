import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/budget/pricing/preview_page_for_confirmation.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_form_controller.dart';
import 'package:js_budget/src/modules/expenses/fixed_expenses/fixed_expense_controller.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/modules/widget/custom_show_dialog.dart';
import 'package:js_budget/src/pages/menu/widgets/custom_expansion_tile.dart';
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
  final expenseController = Injector.get<FixedExpenseController>();
  final profileController = Injector.get<ProfileController>();
  final pricingController = Injector.get<PricingController>();
  final formKey = GlobalKey<FormState>();
  String timeIncentive = 'Dia';

  List<Map<String, dynamic>> fixedExpense = [
    {'icon': Icons.lightbulb, 'type': 'Conta de luz', 'isChecked': true},
    {'icon': Icons.local_drink, 'type': 'Conta de água', 'isChecked': true},
    {'icon': Icons.home, 'type': 'Aluguel', 'isChecked': true},
    {'icon': Icons.money_off, 'type': 'DAS/SIMEI', 'isChecked': true},
  ];

  void toggleExpenseCheckStatus(Map<String, dynamic> expense) {
    setState(() {
      fixedExpense
          .where((fixedExp) => fixedExp['type'] == expense['type'])
          .forEach((item) => item['isChecked'] = !item['isChecked']);
    });
  }

  Future<void> calculateAverageExpense() async {
    pricingController.fixedExpenseItemsBudget.clear();
    for (var expense in fixedExpense) {
      double valueExpense = await _calculateExpenseValue(expense['type']);
      expense['value-average'] = valueExpense;
      pricingController.fixedExpenseItemsBudget.add(
        FixedExpenseItemsBudgetModel(
          value: valueExpense,
          type: expense['type'],
        ),
      );
      setInFieldsAverageExpense(expense['type']);
    }
    _addDefaultExpenseItems();
    for (var item in pricingController.fixedExpenseItemsBudget) {
      print(item.toJson());
    }
  }

  Future<double> _calculateExpenseValue(String type) async {
    double valueExpense = 0;
    if (type == 'Conta de luz' || type == 'Conta de água') {
      List<ExpenseModel> model = await expenseController.findExpenseType(type);
      valueExpense = model.fold(0, (prev, element) => prev + element.value);
      if (model.isNotEmpty) {
        valueExpense /= model.length;
      }
    } else {
      ExpenseModel? model = await expenseController.findLastExpenseType(type);
      valueExpense = model?.value ?? 0;
    }
    return valueExpense;
  }

  void _addDefaultExpenseItems() {
    const defaultItems = ['Outros', 'Prelabore', 'Salário do funcionário'];
    for (var item in defaultItems) {
      pricingController.fixedExpenseItemsBudget.add(
        FixedExpenseItemsBudgetModel(
          value: 0.0,
          type: item,
        ),
      );
    }
  }

  void setInFieldsAverageExpense(String type) {
    switch (type) {
      case 'Conta de luz':
        electricityBillEC.updateValue(fixedExpense[0]['isChecked']
            ? fixedExpense[0]['value-average']
            : 0);
      case 'Conta de água':
        waterBillEC.updateValue(fixedExpense[1]['isChecked']
            ? fixedExpense[1]['value-average']
            : 0);
      case 'Aluguel':
        rentEC.updateValue(fixedExpense[2]['isChecked']
            ? fixedExpense[2]['value-average']
            : 0);
      case 'DAS/SIMEI':
        dasEC.updateValue(fixedExpense[3]['isChecked']
            ? fixedExpense[3]['value-average']
            : 0);
    }
  }

  @override
  void initState() {
    super.initState();
    termEC.text = '1';
    calculateAverageExpense();
    preworkEC.updateValue(profileController.model.value!.salaryExpectation);
    employeeSalaryEC.updateValue(1412);
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
              if (formKey.currentState!.validate() &&
                  pricingController
                      .validate(pricingController.materialItemsBudget)) {
                // Navigator.of(context).pushNamed('/budget/pricing/preview');
                showModalBottomSheet(
                  scrollControlDisabledMaxHeightRatio: .95,
                  context: context,
                  builder: (context) {
                    return const PreviewPageForConfirmation();
                  },
                );
              }
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
              // Card Materiais
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ColumnTile(
                    title: 'Materiais',
                    trailing: IconButton(
                      onPressed: () async {
                        final materials = await Navigator.of(context)
                                .pushNamed('/material', arguments: true)
                            as List<MaterialModel>?;

                        if (materials == null) return;

                        pricingController.addMaterialInListMaterial(materials);
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
                        itemCount: pricingController.materialItemsBudget.length,
                        itemBuilder: (context, index) {
                          final materialItem =
                              pricingController.materialItemsBudget[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${pricingController.materialItemsBudget[index].quantity}x',
                                      style: TextStyle(
                                        fontFamily: 'Anta',
                                        color: Colors.black,
                                        fontSize:
                                            textStyleSmallDefault.fontSize,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        final quantity = await showAlertDialog(
                                            context,
                                            "Alteração da quantidade do material '${materialItem.material.name}'",
                                            buttonTitle: 'Editar');
                                        if (quantity != null) {
                                          pricingController
                                              .materialItemsBudget[index]
                                              .quantity = quantity;
                                          pricingController
                                              .calculateSubTotalMaterial(
                                                  pricingController
                                                          .materialItemsBudget[
                                                      index],
                                                  materialItem.material.price);
                                        }
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              materialItem.material.name,
                              style: textStyleSmallDefault,
                            ),
                            subtitle: Text(
                              UtilsService.moneyToCurrency(pricingController
                                  .materialItemsBudget[index].value),
                              style: TextStyle(
                                  fontFamily: 'Anta',
                                  fontSize: textStyleSmallDefault.fontSize),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                pricingController.materialItemsBudget
                                    .removeWhere((element) =>
                                        element.material.id ==
                                        materialItem.material.id);

                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Card calcular Média
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomExpansionTileWidget(
                    initiallyExpanded: true,
                    addBorder: false,
                    title: 'Calcular média da despesa',
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
              // Formulário
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // Custos Fixos ou indiretos
                    Card(
                      child: ColumnTile(
                        title: 'Valor da depesa fixa',
                        children: [
                          TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: electricityBillEC,
                            readOnly: fixedExpense[0]['isChecked'],
                            decoration: const InputDecoration(
                                labelText: 'Conta de luz',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.lightbulb)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            onChanged: !fixedExpense[0]['isChecked']
                                ? (_) {
                                    pricingController.fixedExpenseItemsBudget[0]
                                        .value = electricityBillEC.numberValue;
                                  }
                                : null,
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
                            readOnly: fixedExpense[1]['isChecked'],
                            decoration: const InputDecoration(
                                labelText: 'Conta de água',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.local_drink)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            onChanged: !fixedExpense[1]['isChecked']
                                ? (_) {
                                    pricingController.fixedExpenseItemsBudget[1]
                                        .value = waterBillEC.numberValue;
                                  }
                                : null,
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
                            readOnly: fixedExpense[2]['isChecked'],
                            decoration: const InputDecoration(
                                labelText: 'Aluguel',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.home)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            onChanged: !fixedExpense[2]['isChecked']
                                ? (_) {
                                    pricingController.fixedExpenseItemsBudget[2]
                                        .value = rentEC.numberValue;
                                  }
                                : null,
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
                            readOnly: fixedExpense[3]['isChecked'],
                            decoration: const InputDecoration(
                                labelText: 'DAS/SIMEI',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.money_off)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                            onChanged: !fixedExpense[3]['isChecked']
                                ? (_) {
                                    pricingController.fixedExpenseItemsBudget[3]
                                        .value = dasEC.numberValue;
                                    print(pricingController
                                        .fixedExpenseItemsBudget[3]
                                        .toJson());
                                  }
                                : null,
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
                                labelText: 'Outros',
                                labelStyle: textStyleSmallDefault,
                                suffix: Icon(Icons.money_off)),
                            style: textStyleSmallDefault,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Outros custos
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          children: [
                            TextFormField(
                              readOnly: true,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              controller: preworkEC,
                              decoration: const InputDecoration(
                                  labelText: 'Pretensão Salarial',
                                  labelStyle: textStyleSmallDefault,
                                  suffix: Icon(Icons.price_change)),
                              keyboardType: TextInputType.number,
                              style: textStyleSmallDefault,
                            ),
                            TextFormField(
                              readOnly: true,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              controller: employeeSalaryEC,
                              decoration: const InputDecoration(
                                  labelText: 'Salário do funcionário',
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
                                    decoration: InputDecoration(
                                        labelText: 'Prazo*',
                                        labelStyle: textStyleSmallDefault,
                                        suffix: Text('$timeIncentive(s)')),
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
                                  child: DropdownButtonFormField<String>(
                                    value: timeIncentive,
                                    decoration: const InputDecoration(
                                      labelText: 'Estimulo de tempo',
                                    ),
                                    items: <String>['Dia', 'Hora']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        timeIncentive = value!;
                                      });
                                    },
                                    validator: Validatorless.required(
                                        'Tipo de despesa obrigatório'),
                                    style: textStyleSmallDefault,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
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
