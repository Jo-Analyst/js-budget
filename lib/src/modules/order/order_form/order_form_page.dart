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
import 'package:js_budget/src/modules/widget/custom_show_dialog.dart';
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
  final List<ProductModel> _products = [];
  List<ProductModel> get products =>
      _products..sort((a, b) => a.name.compareTo(b.name));

  final List<ServiceModel> _services = [];
  List<ServiceModel> get services =>
      _services..sort((a, b) => a.description.compareTo(b.description));

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
              if (!controller.validateFields(client, _products, _services)) {
                return;
              }

              for (var product in products) {
                itemOrder.add(ItemOrderModel(product: product));
              }

              for (var service in services) {
                itemOrder.add(ItemOrderModel(service: service));
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
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              client = await nav.pushNamed('/client',
                                  arguments: true) as ClientModel;
                              setState(() {});
                            },
                            icon: const Icon(
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
                child: ColumnTile(
                    leading: const Icon(Icons.local_offer),
                    trailing: IconButton(
                      onPressed: () async {
                        final produts = await nav.pushNamed('/product',
                                arguments: true) as List<ProductModel>? ??
                            _products;

                        if (_products.isEmpty) {
                          _products.addAll(produts);
                        } else {
                          var productsForAdd = produts
                              .where((prod) => !_products
                                  .any((product) => product.id == prod.id))
                              .toList();
                          _products.addAll(productsForAdd);
                        }

                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    title: 'Produtos',
                    children: products
                        .map(
                          (product) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 30,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
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
                                          final quantity = await showAlertDialog(
                                              context,
                                              "Alteração da quantidade do produto '${product.name}'",
                                              buttonTitle: 'Editar');
                                          if (quantity != null) {
                                            ProductModel productModel =
                                                ProductModel(
                                              id: product.id,
                                              name: product.name,
                                              description: product.description,
                                              unit: product.unit,
                                              quantity: quantity,
                                            );

                                            _products.removeWhere((prod) =>
                                                prod.id == product.id);
                                            _products.add(productModel);

                                            setState(() {});
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
                                product.name,
                                style: textStyleSmallDefault,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _products.removeWhere(
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
                        .toList()),
              ),

              // Card de Serviços
              Card(
                child: ColumnTile(
                  leading: const Icon(FontAwesomeIcons.screwdriverWrench),
                  trailing: IconButton(
                    onPressed: () async {
                      final services = await nav.pushNamed('/service',
                              arguments: true) as List<ServiceModel>? ??
                          _services;

                      if (_services.isEmpty) {
                        _services.addAll(services);
                      } else {
                        var servicesForAdd = services
                            .where((serv) => !_services
                                .any((service) => service.id == serv.id))
                            .toList();
                        _services.addAll(servicesForAdd);
                      }

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  title: 'Serviços',
                  children: services
                      .map(
                        (service) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
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
                                        final quantity = await showAlertDialog(
                                            context,
                                            "Alteração da quantidade do serviço '${service.description}'",
                                            buttonTitle: 'Editar');

                                        if (quantity != null) {
                                          ServiceModel serviceModel =
                                              ServiceModel(
                                            id: service.id,
                                            description: service.description,
                                            price: service.price,
                                            quantity: quantity,
                                          );

                                          _services.removeWhere(
                                              (serv) => serv.id == service.id);
                                          _services.add(serviceModel);
                                          setState(() {});
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
                              service.description,
                              style: textStyleSmallDefault,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                _services.removeWhere(
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
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
