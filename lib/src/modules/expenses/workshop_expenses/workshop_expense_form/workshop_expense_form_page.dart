import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_controller.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_form/worshop_expense_form_controller.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class WorkshopExpenseFormPage extends StatefulWidget {
  const WorkshopExpenseFormPage({
    super.key,
  });

  @override
  State<WorkshopExpenseFormPage> createState() =>
      _WorkshopExpenseFormPageState();
}

class _WorkshopExpenseFormPageState extends State<WorkshopExpenseFormPage>
    with WorkshopExpenseFormController {
  final controller = Injector.get<WorkshopExpenseController>();
  final formKey = GlobalKey<FormState>();
  String expenseValue = 'R\$ 0,00';
  DateTime expenseDate = DateTime.now();
  String methodPayment = 'Dinheiro';
  String? typeExpense;
  ExpenseModel? expense;

  IconData iconMethodPayment(String methodPayment) {
    switch (methodPayment.toLowerCase()) {
      case 'dinheiro':
        return Icons.money_sharp;
      case 'pix':
        return Icons.pix;
    }

    return Icons.credit_card;
  }

  @override
  void initState() {
    super.initState();
    expenseDateEC.text = UtilsService.dateFormatText(expenseDate);
    expense = controller.model();

    if (expense != null) {
      initializeForm(expense!);
      methodPayment = expense!.methodPayment;
      typeExpense = (expense!.description == 'Conta de luz' ||
              expense!.description == 'Conta de água' ||
              expense!.description == 'Aluguel' ||
              expense!.description == 'DAS/SIMEI')
          ? expense!.description
          : 'Outro';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          expense == null
              ? 'Nova despesa da oficina'
              : "Editar despesa da oficina",
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var nav = Navigator.of(context);

                if (formKey.currentState?.validate() ?? false) {
                  await controller.save(
                    saveExpense(
                        expense?.id ?? 0,
                        methodPayment,
                        typeExpense != 'Outro'
                            ? typeExpense!
                            : otherEC.text.trim()),
                  );
                  nav.pop();
                  if (expense != null) {
                    nav.pop();
                  }
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: typeExpense,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Despesa*',
                        suffixIcon: Icon(Icons.paid),
                      ),
                      items: <String>[
                        'Conta de luz',
                        'Conta de água',
                        'Aluguel',
                        'DAS/SIMEI',
                        'Outro',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          typeExpense = value;
                        });
                      },
                      validator:
                          Validatorless.required('Tipo de despesa obrigatório'),
                      style: textStyleMediumDefault,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Visibility(
                          visible: typeExpense == 'Outro',
                          child: TextFormField(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            controller: otherEC,
                            decoration: const InputDecoration(
                              labelText: 'Descrição*',
                              labelStyle: TextStyle(fontFamily: 'Poppins'),
                              suffixIcon: Icon(Icons.attach_money),
                            ),
                            style: textStyleMediumDefault,
                            keyboardType: TextInputType.number,
                            validator:
                                Validatorless.required('Descrição obrigatório'),
                            onChanged: (value) {
                              expenseValue = value;
                            },
                          ),
                        ),
                        TextFormField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          controller: expenseValueEC,
                          decoration: const InputDecoration(
                            labelText: 'Valor da Despesa*',
                            labelStyle: TextStyle(fontFamily: 'Poppins'),
                            suffixIcon: Icon(Icons.attach_money),
                          ),
                          style: textStyleMediumDefault,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (expenseValueEC.numberValue == 0) {
                              return 'Valor da despesa obrigatório';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            expenseValue = value;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: methodPayment,
                          decoration: InputDecoration(
                            labelText: 'Método de pagamento',
                            suffixIcon: Icon(iconMethodPayment(methodPayment)),
                          ),
                          items: <String>[
                            'Dinheiro',
                            'Pix',
                            'Cartão de crédito',
                            'Cartão de débito',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              methodPayment = value!;
                            });
                          },
                        ),
                        FieldDatePicker(
                          controller: expenseDateEC,
                          initialDate: expenseDate,
                          labelText: 'Data da despesa',
                          onSelected: (date) {
                            setState(() {
                              expenseDate = date;
                            });
                            expenseDateEC.text =
                                UtilsService.dateFormatText(date);
                          },
                        ),
                        TextFormField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          controller: observationEC,
                          decoration: const InputDecoration(
                            labelText: 'Notas/Observações',
                            labelStyle: TextStyle(fontFamily: 'Poppins'),
                            suffixIcon: Icon(Icons.note_alt_outlined),
                          ),
                          style: textStyleMediumDefault,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
