import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/product_model.dart';
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
  List<ProductModel>? products;
  DateTime requesteDate = DateTime.now();
  int quantityProdutoSelected = 0;
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
                onTap: () async {
                  products = await nav.pushNamed('/product', arguments: true)
                      as List<ProductModel>?;

                  setState(() {
                    quantityProdutoSelected = products?.length ?? 0;
                  });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.local_offer),
                      title: Text(
                        quantityProdutoSelected > 0
                            ? '$quantityProdutoSelected produtos'
                            : 'Produtos',
                        style: textStyleSmallDefault,
                      ),
                      trailing: quantityProdutoSelected > 0
                          ? IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 30,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  quantityProdutoSelected = 0;
                                  products = null;
                                });
                              },
                            )
                          : const Icon(
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
