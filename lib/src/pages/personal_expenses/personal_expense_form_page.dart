import 'package:flutter/material.dart';
import 'package:js_budget/src/models/personal_expense_model.dart';
import 'package:js_budget/src/pages/personal_expenses/personal_expense_form_controller.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class PersonalExpenseFormPage extends StatefulWidget {
  final PersonalExpenseModel? personalExpense;
  const PersonalExpenseFormPage({
    super.key,
    this.personalExpense,
  });

  @override
  State<PersonalExpenseFormPage> createState() =>
      _PersonalExpenseFormPageState();
}

class _PersonalExpenseFormPageState extends State<PersonalExpenseFormPage>
    with PersonalExpenseFormController {
  final formKey = GlobalKey<FormState>();
  String expenseValue = 'R\$ 0,00';
  DateTime expenseDate = DateTime.now();
  String methodPayment = 'Dinheiro';

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
    if (widget.personalExpense != null) {
      initializeForm(widget.personalExpense!);
      methodPayment = widget.personalExpense!.methodPayment;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova despesa pessoal'),
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: typeOfExpenseEC,
                  decoration: const InputDecoration(
                    labelText: 'Tipo da Despesa*',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    suffix: Icon(Icons.paid),
                  ),
                  style: textStyleSmallDefault,
                  keyboardType: TextInputType.text,
                  validator:
                      Validatorless.required('Tipo de despesa obrigatório'),
                ),
                TextFormField(
                  controller: expenseValueEC,
                  decoration: const InputDecoration(
                    labelText: 'Valor da Despesa*',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    suffix: Icon(Icons.attach_money),
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
                    suffix: Icon(iconMethodPayment(methodPayment)),
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
                    suffix: Icon(Icons.note_alt_outlined),
                  ),
                  style: textStyleSmallDefault,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
