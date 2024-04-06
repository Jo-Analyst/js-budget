import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/modules/order/order_form/order_form_controller.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class OrderFormPage extends StatefulWidget {
  const OrderFormPage({super.key});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage>
    with OrderFormController {
  final controller = Injector.get<OrderController>();

  List<ItemOrderModel> itemOrder = [];
  List<ProductModel>? products;
  List<ServiceModel>? services;
  OrderModel? order;
  DateTime orderDate = DateTime.now();
  int quantityProductSelected = 0, quantityServiceSelected = 0;
  ClientModel? client;

  @override
  void initState() {
    super.initState();
    dateEC.text = UtilsService.dateFormat(orderDate);
  }

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo pedido'),
        actions: [
          IconButton(
            onPressed: () async {
              if (!controller.validateFields(client, products, services)) {
                return;
              }

              await controller
                  .register(saveForm(order?.id ?? 0, client!, itemOrder));
              nav.pop();
            },
            icon: const Icon(Icons.save, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              // Card de Data
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: FieldDatePicker(
                    controller: dateEC,
                    initialDate: orderDate,
                    labelText: 'Data',
                    onSelected: (date) {
                      setState(() {
                        orderDate = date;
                      });
                      dateEC.text = UtilsService.dateFormat(date);
                    },
                  ),
                ),
              ),

              // Card de Cliente
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

              // Card de Produtos
              GestureDetector(
                onTap: () async {
                  products = await nav.pushNamed('/product', arguments: true)
                          as List<ProductModel>? ??
                      products;

                  if (products != null) {
                    for (var product in products!) {
                      itemOrder.add(ItemOrderModel(product: product));
                    }
                  }

                  setState(() {
                    quantityProductSelected = products?.length ?? 0;
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
                        quantityProductSelected > 0
                            ? '$quantityProductSelected produtos'
                            : 'Produtos',
                        style: textStyleSmallDefault,
                      ),
                      trailing: quantityProductSelected > 0
                          ? IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 30,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  quantityProductSelected = 0;
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

              // Card de Serviços
              GestureDetector(
                onTap: () async {
                  services = await nav.pushNamed('/service', arguments: true)
                          as List<ServiceModel>? ??
                      services;

                  if (services != null) {
                    for (var service in services!) {
                      itemOrder.add(ItemOrderModel(service: service));
                    }
                  }

                  setState(() {
                    quantityServiceSelected = services?.length ?? 0;
                  });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(FontAwesomeIcons.screwdriverWrench),
                      title: Text(
                        quantityServiceSelected > 0
                            ? '$quantityServiceSelected Serviços'
                            : 'Serviços',
                        style: textStyleSmallDefault,
                      ),
                      trailing: quantityServiceSelected > 0
                          ? IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 30,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  quantityServiceSelected = 0;
                                  services = null;
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
            ],
          ),
        ),
      ),
    );
  }
}
