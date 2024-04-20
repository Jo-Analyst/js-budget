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
import 'package:js_budget/src/pages/widgets/column_tile.dart';
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

              if (products != null) {
                for (var product in products!) {
                  itemOrder.add(ItemOrderModel(product: product));
                }
              }

              if (services != null) {
                for (var service in services!) {
                  itemOrder.add(ItemOrderModel(service: service));
                }
              }

              final model = await controller
                  .register(saveForm(order?.id ?? 0, client!, itemOrder));
              nav.pop(model);
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 20, 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
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
                              color: Colors.black,
                              size: 30,
                            ),
                    ),
                  ),
                ),
              ),

              // Card de Produtos
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: ColumnTile(
                    leading: const Icon(Icons.local_offer),
                    trailing: IconButton(
                      onPressed: () async {
                        products = await nav.pushNamed('/product',
                                arguments: true) as List<ProductModel>? ??
                            products;

                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                    title: 'Produtos',
                    children: products != null
                        ? products!
                            .map(
                              (product) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Stack(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 30,
                                        child: Text(
                                          '${product.quantity}x',
                                          style: TextStyle(
                                            fontFamily: 'Anta',
                                            color: Colors.black,
                                            fontSize:
                                                textStyleSmallDefault.fontSize,
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
                                            onTap: () {},
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
                                    product.name,
                                    style: textStyleSmallDefault,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      products!.removeWhere(
                                          (prod) => prod.id == product.id);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList()
                        : [],
                  ),
                ),
              ),

              // Card de Serviços
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: ColumnTile(
                    leading: const Icon(FontAwesomeIcons.screwdriverWrench),
                    trailing: IconButton(
                      onPressed: () async {
                        services = await nav.pushNamed('/service',
                                arguments: true) as List<ServiceModel>? ??
                            services;

                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                    title: 'Serviços',
                    children: services != null
                        ? services!
                            .map(
                              (service) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Stack(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 30,
                                        child: Text(
                                          '${service.quantity}x',
                                          style: TextStyle(
                                            fontFamily: 'Anta',
                                            color: Colors.black,
                                            fontSize:
                                                textStyleSmallDefault.fontSize,
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
                                            onTap: () {},
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
                                    service.description,
                                    style: textStyleSmallDefault,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      services!.removeWhere(
                                          (serv) => serv.id == service.id);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList()
                        : [],
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
