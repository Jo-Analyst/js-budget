import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final dateEC = TextEditingController();
  DateTime requesteDate = DateTime.now();
  ClientModel? client;

  @override
  void initState() {
    super.initState();
    dateEC.text = UtilsService.dateFormat(requesteDate);
  }

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
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
                    controller: dateEC,
                    initialDate: requesteDate,
                    labelText: 'Data',
                    onSelected: (date) {
                      setState(() {
                        requesteDate = date;
                      });
                      dateEC.text = UtilsService.dateFormat(date);
                    },
                  ),
                ),
              ),

              // Cliente
              GestureDetector(
                onTap: () async {
                  client = await nav.pushNamed('/client', arguments: true)
                      as ClientModel;
                  setState(() {});
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.person),
                      title: Text(
                        client?.name ?? 'Cliente',
                        style: textStyleSmallDefault,
                      ),
                      trailing: client != null
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  client = null;
                                });
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 30,
                              ))
                          : const Icon(
                              Icons.add,
                              size: 30,
                            ),
                    ),
                  ),
                ),
              ),

              // Produtos
              GestureDetector(
                onTap: () {
                  nav.pushNamed('/product');
                },
                child: const Card(
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
              ),

              // Serviços
              GestureDetector(
                onTap: () {
                  nav.pushNamed('/service');
                },
                child: const Card(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
