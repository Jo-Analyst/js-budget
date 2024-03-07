import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/personal_expenses/personal_expense_form_controller.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class PersonalExpenseFormPage extends StatefulWidget {
  const PersonalExpenseFormPage({super.key});

  @override
  State<PersonalExpenseFormPage> createState() =>
      _PersonalExpenseFormPageState();
}

class _PersonalExpenseFormPageState extends State<PersonalExpenseFormPage>
    with PersonalExpenseFormController {
  final formKey = GlobalKey<FormState>();
  String expenseValue = 'R\$ 0,00';
  DateTime expenseDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    expenseDateEC.text = UtilsService.dateFormat(expenseDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesa Pessoal'),
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
                    labelText: 'Tipo de Despesa',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: textStyleSmallDefault,
                  keyboardType: TextInputType.text,
                  validator:
                      Validatorless.required('Tipo de despesa obrigatório'),
                ),
                TextFormField(
                  controller: expenseValueEC,
                  decoration: const InputDecoration(
                    labelText: 'Valor da Despesa',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
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
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Método de pagamento',
                  ),
                  items: <String>[
                    'Dinheiro',
                    'Pix',
                    'Crédito',
                    'Débito',
                    'Outro'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                TextFormField(
                  controller: observationEC,
                  decoration: const InputDecoration(
                    labelText: 'Notas/Observações',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
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
