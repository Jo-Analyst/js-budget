import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo pedido'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              // Data
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: FieldDatePicker(
                    // controller: dateEC,
                    initialDate: DateTime.now(),
                    labelText: 'Data',
                    onSelected: (date) {
                      setState(() {
                        // expenseDate = date;
                      });
                      // dateEC.text = UtilsService.dateFormat(date);
                    },
                  ),
                ),
              ),

              // Cliente
              const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.person),
                    title: Text(
                      'Cliente',
                      style: textStyleSmallDefault,
                    ),
                    trailing: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),

              // Produtos
              const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.local_offer),
                    title: Text(
                      'Produtos',
                      style: textStyleSmallDefault,
                    ),
                    trailing: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),

              // Serviços
              const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(FontAwesomeIcons.screwdriverWrench),
                    title: Text(
                      'Serviços',
                      style: textStyleSmallDefault,
                    ),
                    trailing: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),

              // Forma de pagamento
              const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.payment),
                    title: Text(
                      'Forma de pagamento',
                      style: textStyleSmallDefault,
                    ),
                    trailing: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),

              // Condição de pagamento
              const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.payments_outlined),
                    title: Text(
                      'Condição de pagamento',
                      style: textStyleSmallDefault,
                    ),
                    trailing: Icon(
                      Icons.add,
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
