import 'package:flutter/material.dart';
import 'package:js_budget/src/models/fixed_expense_model.dart';
import 'package:js_budget/src/pages/fixed_expenses/fixed_expense_form_controller.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class FixedExpenseFormPage extends StatefulWidget {
  final FixedExpenseModel? fixedExpense;
  const FixedExpenseFormPage({
    super.key,
    this.fixedExpense,
  });

  @override
  State<FixedExpenseFormPage> createState() => _FixedExpenseFormPageState();
}

class _FixedExpenseFormPageState extends State<FixedExpenseFormPage>
    with FixedExpenseFormController {
  final formKey = GlobalKey<FormState>();
  String expenseValue = 'R\$ 0,00';
  DateTime expenseDate = DateTime.now();
  String methodPayment = 'Dinheiro';
  String? typeExpense;

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
    expenseDateEC.text = UtilsService.dateFormat(expenseDate);
    if (widget.fixedExpense != null) {
      initializeForm(widget.fixedExpense!);
      methodPayment = widget.fixedExpense!.methodPayment;
      typeExpense = widget.fixedExpense!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fixedExpense == null
              ? 'Nova despesa da oficina'
              : "Editar despesa da oficina",
        ),
        actions: [
          IconButton(
              onPressed: () {
                formKey.currentState!.validate();
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
                        'Aluguel'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                      validator:
                          Validatorless.required('Tipo de despesa obrigatório'),
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
                        TextFormField(
                          controller: expenseValueEC,
                          decoration: const InputDecoration(
                            labelText: 'Valor da Despesa*',
                            labelStyle: TextStyle(fontFamily: 'Poppins'),
                            suffixIcon: Icon(Icons.attach_money),
                          ),
                          style: textStyleSmallDefault,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (expenseValue == "R\$ 0,00") {
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
                            expenseDateEC.text = UtilsService.dateFormat(date);
                          },
                        ),
                        TextFormField(
                          controller: observationEC,
                          decoration: const InputDecoration(
                            labelText: 'Notas/Observações',
                            labelStyle: TextStyle(fontFamily: 'Poppins'),
                            suffixIcon: Icon(Icons.note_alt_outlined),
                          ),
                          style: textStyleSmallDefault,
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
