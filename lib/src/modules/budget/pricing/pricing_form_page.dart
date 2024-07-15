import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/budget/pricing/preview_page_for_confirmation.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_form_controller.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_controller.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/modules/widget/custom_icons.dart';
import 'package:js_budget/src/modules/widget/custom_show_dialog.dart';
import 'package:js_budget/src/pages/menu/widgets/custom_expansion_tile.dart';
import 'package:js_budget/src/pages/widgets/list_view_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class PricingFormPage extends StatefulWidget {
  const PricingFormPage({super.key});

  @override
  State<PricingFormPage> createState() => _PricingFormPageState();
}

class _PricingFormPageState extends State<PricingFormPage>
    with PricingFormController, TickerProviderStateMixin {
  final expenseController = Injector.get<WorkshopExpenseController>();
  final profileController = Injector.get<ProfileController>();
  final pricingController = Injector.get<PricingController>();
  final formKey = GlobalKey<FormState>();
  double electricityBill = 0, waterBill = 0, rent = 0, das = 0, other = 0;
  bool isEditEmployeeSalary = false;
  late SharedPreferences prefs;

  List<Map<String, dynamic>> workshopExpense = [
    {'type': 'Conta de luz', 'isChecked': true},
    {'type': 'Conta de água', 'isChecked': true},
    {'type': 'Aluguel', 'isChecked': true},
    {'type': 'DAS/SIMEI', 'isChecked': true},
  ];

  void toggleExpenseCheckStatus(Map<String, dynamic> expense) {
    setState(() {
      workshopExpense
          .where((exp) => exp['type'] == expense['type'])
          .forEach((item) => item['isChecked'] = !item['isChecked']);
    });
  }

  Future<void> calculateAverageExpense() async {
    pricingController.workshopExpenseItemsBudget.clear();
    for (var expense in workshopExpense) {
      double valueExpense = await _calculateExpenseValue(expense['type']);
      expense['value-average'] = valueExpense;
      pricingController.workshopExpenseItemsBudget.add(
        WorkshopExpenseItemsBudgetModel(
            value: valueExpense,
            type: expense['type'],
            dividedValue: valueExpense / 30,
            accumulatedValue: valueExpense / 30),
      );
      setInFieldsAverageExpense(expense['type']);
    }
    _addDefaultExpenseItems();
  }

  Future<double> _calculateExpenseValue(String type) async {
    double valueExpense = 0;
    if (type == 'Conta de luz' || type == 'Conta de água') {
      List<ExpenseModel> model =
          await expenseController.findExpenseDescription(type);
      valueExpense = model.fold(0, (prev, mdl) => prev + mdl.value);
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
      double dividedValue = 0, value = 0;
      if (item == 'Prelabore') {
        dividedValue = pricingController.timeIncentive == 'Dia'
            ? preworkEC.numberValue / 30
            : (preworkEC.numberValue / 30) / 8;
        value = preworkEC.numberValue;
      }

      if (item == 'Salário do funcionário') {
        dividedValue = pricingController.timeIncentive == 'Dia'
            ? employeeSalaryEC.numberValue / 30
            : (employeeSalaryEC.numberValue / 30) / 8;
        value = employeeSalaryEC.numberValue;
      }

      if (item == 'Outros') {
        dividedValue = pricingController.timeIncentive == 'Dia'
            ? otherTaxesEC.numberValue / 30
            : (otherTaxesEC.numberValue / 30) / 8;
        value = otherTaxesEC.numberValue;
      }

      pricingController.workshopExpenseItemsBudget.add(
        WorkshopExpenseItemsBudgetModel(
          value: value,
          type: item,
          dividedValue: dividedValue,
          accumulatedValue: dividedValue * int.parse(termEC.text),
        ),
      );
    }
  }

  void setInFieldsAverageExpense(String type) {
    switch (type) {
      case 'Conta de luz':
        electricityBillEC.updateValue(workshopExpense[0]['isChecked']
            ? workshopExpense[0]['value-average']
            : electricityBill);
        calculateExpense(0, electricityBillEC.numberValue);
      case 'Conta de água':
        waterBillEC.updateValue(workshopExpense[1]['isChecked']
            ? workshopExpense[1]['value-average']
            : waterBill);
        calculateExpense(1, waterBillEC.numberValue);
      case 'Aluguel':
        rentEC.updateValue(workshopExpense[2]['isChecked']
            ? workshopExpense[2]['value-average']
            : rent);
        calculateExpense(2, rentEC.numberValue);
      case 'DAS/SIMEI':
        dasEC.updateValue(workshopExpense[3]['isChecked']
            ? workshopExpense[3]['value-average']
            : das);
        calculateExpense(3, dasEC.numberValue);
    }
  }

  void initializeForm() {
    if (pricingController.workshopExpenseItemsBudget.isNotEmpty) {
      workshopExpense.asMap().forEach((key, expense) {
        expense['isChecked'] = false;
      });

      termEC.text = pricingController.term.toString();
      calculateExpenseByCompleted();

      for (var i in pricingController.workshopExpenseItemsBudget) {
        switch (i.type.toLowerCase()) {
          case 'conta de luz':
            electricityBill = i.value;
          case 'conta de água':
            waterBill = i.value;
          case 'aluguel':
            rent = i.value;
          case 'das/simei':
            das = i.value;
          case 'outros':
            other = i.value;
            calculateExpense(4, other);
            otherTaxesEC.updateValue(other);
        }
      }
    }

    percentageProfitMarginEC
        .updateValue(pricingController.percentageProfitMargin);
  }

  void changeEmployeeSalary() {
    for (var workShop in pricingController.workshopExpenseItemsBudget) {
      if (workShop.type == 'Salário do funcionário') {
        workShop.dividedValue = pricingController.timeIncentive == 'Dia'
            ? employeeSalaryEC.numberValue / 30
            : (employeeSalaryEC.numberValue / 30) / 8;
        workShop.accumulatedValue =
            workShop.dividedValue * int.parse(termEC.text);
        workShop.value = employeeSalaryEC.numberValue;
      }
    }
  }

  void calculateExpense(int index, double value) {
    pricingController.calculateExpensesByPeriodForEachExpense(
        index, pricingController.timeIncentive, value, pricingController.term);
  }

  void calculateExpenseByCompleted() {
    pricingController.workshopExpenseItemsBudget.asMap().forEach((i, item) {
      calculateExpense(i, item.value);
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('employeeSalary') == null) {
      await prefs.setDouble('employeeSalary', 0.0);
    }
    termEC.text = pricingController.term.toString();
    preworkEC.updateValue(profileController.model.value!.salaryExpectation);
    employeeSalaryEC.updateValue(prefs.getDouble('employeeSalary') as double);

    initializeForm();
    calculateAverageExpense();
  }

  @override
  Widget build(BuildContext context) {
    final description = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(description),
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    // Card Materiais
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListViewTile(
                          title: 'Materiais',
                          trailing: IconButton(
                            onPressed: () async {
                              final materials = await Navigator.of(context)
                                      .pushNamed('/material', arguments: true)
                                  as List<MaterialModel>?;

                              if (materials == null) return;

                              pricingController
                                  .addMaterialInListMaterial(materials);
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
                              itemCount:
                                  pricingController.materialItemsBudget.length,
                              itemBuilder: (context, index) {
                                final materialItem = pricingController
                                    .materialItemsBudget[index];
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
                                              fontSize: textStyleMediumDefault
                                                  .fontSize,
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
                                              final quantity =
                                                  await showAlertDialog(context,
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
                                                        materialItem
                                                            .material.price);
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
                                    style: textStyleMediumDefault,
                                  ),
                                  subtitle: Text(
                                    UtilsService.moneyToCurrency(
                                        pricingController
                                            .materialItemsBudget[index].value),
                                    style: TextStyle(
                                        fontFamily: 'Anta',
                                        fontSize:
                                            textStyleMediumDefault.fontSize),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      pricingController
                                          .deleteMaterial(materialItem);

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
                          children: workshopExpense
                              .map(
                                (expense) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    toggleExpenseCheckStatus(expense);
                                    setInFieldsAverageExpense(expense['type']);
                                  },
                                  leading: CustomIcons.workShopExpense(
                                      expense['type']),
                                  title: Text(
                                    expense['type'],
                                    style: textStyleMediumDefault,
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
                            child: ListViewTile(
                              title: 'Valor da depesa fixa',
                              children: [
                                TextFormField(
                                  onTapOutside: (_) =>
                                      FocusScope.of(context).unfocus(),
                                  controller: electricityBillEC,
                                  readOnly: workshopExpense[0]['isChecked'],
                                  decoration: const InputDecoration(
                                      labelText: 'Conta de luz',
                                      labelStyle: textStyleMediumDefault,
                                      suffix: Icon(Icons.lightbulb)),
                                  style: textStyleMediumDefault,
                                  keyboardType: TextInputType.number,
                                  onChanged: !workshopExpense[0]['isChecked']
                                      ? (_) {
                                          calculateExpense(
                                              0, electricityBillEC.numberValue);
                                          electricityBill =
                                              electricityBillEC.numberValue;
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
                                  readOnly: workshopExpense[1]['isChecked'],
                                  decoration: const InputDecoration(
                                      labelText: 'Conta de água',
                                      labelStyle: textStyleMediumDefault,
                                      suffix: Icon(Icons.local_drink)),
                                  style: textStyleMediumDefault,
                                  keyboardType: TextInputType.number,
                                  onChanged: !workshopExpense[1]['isChecked']
                                      ? (_) {
                                          calculateExpense(
                                              1, waterBillEC.numberValue);
                                          waterBill = waterBillEC.numberValue;
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
                                  readOnly: workshopExpense[2]['isChecked'],
                                  decoration: const InputDecoration(
                                      labelText: 'Aluguel',
                                      labelStyle: textStyleMediumDefault,
                                      suffix: Icon(Icons.home)),
                                  style: textStyleMediumDefault,
                                  keyboardType: TextInputType.number,
                                  onChanged: !workshopExpense[2]['isChecked']
                                      ? (_) {
                                          calculateExpense(
                                              2, rentEC.numberValue);
                                          rent = rentEC.numberValue;
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
                                  readOnly: workshopExpense[3]['isChecked'],
                                  decoration: const InputDecoration(
                                      labelText: 'DAS/SIMEI',
                                      labelStyle: textStyleMediumDefault,
                                      suffix: Icon(Icons.money_off)),
                                  style: textStyleMediumDefault,
                                  keyboardType: TextInputType.number,
                                  onChanged: !workshopExpense[3]['isChecked']
                                      ? (_) {
                                          calculateExpense(
                                              3, dasEC.numberValue);
                                          das = dasEC.numberValue;
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
                                      labelStyle: textStyleMediumDefault,
                                      suffix: Icon(Icons.money_off)),
                                  style: textStyleMediumDefault,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    calculateExpense(
                                        4, otherTaxesEC.numberValue);
                                    other = otherTaxesEC.numberValue;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Outros custos
                          Card(
                            child: ListViewTile(
                              title: 'Custos salariais',
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  onTapOutside: (_) =>
                                      FocusScope.of(context).unfocus(),
                                  controller: preworkEC,
                                  decoration: const InputDecoration(
                                      labelText: 'Pretensão Salarial',
                                      labelStyle: textStyleMediumDefault,
                                      suffix: Icon(Icons.price_change)),
                                  keyboardType: TextInputType.number,
                                  style: textStyleMediumDefault,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          readOnly: !isEditEmployeeSalary,
                                          onTapOutside: (_) =>
                                              FocusScope.of(context).unfocus(),
                                          controller: employeeSalaryEC,
                                          decoration: const InputDecoration(
                                            labelText: 'Salário do funcionário',
                                            labelStyle: textStyleMediumDefault,
                                          ),
                                          keyboardType: TextInputType.number,
                                          style: textStyleMediumDefault,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: () async {
                                          if (isEditEmployeeSalary) {
                                            await prefs.setDouble(
                                                'employeeSalary',
                                                employeeSalaryEC.numberValue);
                                            changeEmployeeSalary();
                                          }

                                          setState(() {
                                            isEditEmployeeSalary =
                                                !isEditEmployeeSalary;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            isEditEmployeeSalary
                                                ? Icons.check
                                                : Icons.edit,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onTapOutside: (_) =>
                                              FocusScope.of(context).unfocus(),
                                          controller: termEC,
                                          decoration: InputDecoration(
                                              labelText: 'Prazo*',
                                              labelStyle:
                                                  textStyleMediumDefault,
                                              suffix: Text(
                                                  '${pricingController.timeIncentive}(s)')),
                                          style: textStyleMediumDefault,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          onChanged: (value) {
                                            pricingController.term =
                                                value.isNotEmpty
                                                    ? int.parse(value)
                                                    : 1;

                                            calculateExpenseByCompleted();
                                          },
                                          validator: Validatorless.required(
                                              'Informe o prazo'),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          value:
                                              pricingController.timeIncentive,
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
                                            pricingController.timeIncentive =
                                                value!;

                                            calculateExpenseByCompleted();
                                          },
                                          validator: Validatorless.required(
                                              'Tipo de despesa obrigatório'),
                                          style: textStyleMediumDefault,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    onTapOutside: (_) =>
                                        FocusScope.of(context).unfocus(),
                                    controller: percentageProfitMarginEC,
                                    decoration: const InputDecoration(
                                        labelText: 'Margem de lucro',
                                        labelStyle: textStyleMediumDefault,
                                        suffixText: '%'),
                                    style: textStyleMediumDefault,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => pricingController
                                            .percentageProfitMargin =
                                        percentageProfitMarginEC.numberValue,
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
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            alignment: Alignment.centerRight,
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    pricingController.validate(
                        pricingController.materialItemsBudget,
                        isEditEmployeeSalary)) {
                  pricingController.calculateTotalMaterial();
                  pricingController.calculateTotalExpenses();
                  pricingController.calculateProfitMargin();
                  pricingController.calculateTotalToBeCharged();

                  // Navigator.of(context).pushNamed('/budget/pricing/preview');
                  var nav = Navigator.of(context);
                  bool isConfirmed = await showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        scrollControlDisabledMaxHeightRatio: .9,
                        context: context,
                        builder: (context) {
                          return const PreviewPageForConfirmation();
                        },
                      ) ??
                      false;

                  if (isConfirmed) {
                    nav.pop(isConfirmed);
                  }
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Próximo',
                    style: textStyleLargeDefault,
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                    size: 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
