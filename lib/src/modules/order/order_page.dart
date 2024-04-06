import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final controller = Injector.get<OrderController>();
  int? idSelected;

  final List<OrderModel> order = [
    OrderModel(
      id: 1,
      date: '31/03/2024',
      client: ClientModel(name: 'Valdirene Aparecida Ferreira'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemOrderModel(
          product:
              ProductModel(name: 'Guarda Roupa', description: '', unit: 'unit'),
          service: ServiceModel(description: 'Montagem'),
        ),
        ItemOrderModel(
          product: ProductModel(name: 'Mesa', description: '', unit: 'unit'),
          service: ServiceModel(description: 'Montagem'),
        ),
        ItemOrderModel(
          product: ProductModel(name: 'Cadeira', description: '', unit: 'unit'),
          service: ServiceModel(description: 'Montagem'),
        ),
      ],
    ),
    OrderModel(
      id: 2,
      date: '31/03/2024',
      client: ClientModel(name: 'Joelmir Rogério Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemOrderModel(
          product:
              ProductModel(name: 'Guarda Roupa', description: '', unit: 'unit'),
          service: ServiceModel(description: 'Montagem'),
        ),
        ItemOrderModel(
          product: ProductModel(name: 'Mesa', description: '', unit: 'unit'),
          service: ServiceModel(description: 'Montagem'),
        ),
        ItemOrderModel(
          product: ProductModel(name: 'Banco', description: '', unit: 'unit'),
          service: ServiceModel(description: 'Montagem'),
        ),
        ItemOrderModel(
          product: ProductModel(name: 'Banco', description: '', unit: 'unit'),
          service: ServiceModel(description: 'Montagem'),
        ),
      ],
    ),
  ];

  bool orderSelected = false;
  String search = '';

  Future<void> findOrders() async {
    await controller.findOrders();
  }

  @override
  void initState() {
    super.initState();

    findOrders();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var filteredOrder = controller.data
        .watch(context)
        .where((req) =>
            req.client.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          Visibility(
            visible: orderSelected,
            child: IconButton(
              tooltip: 'Editar',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/order/form',
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ),
          Visibility(
            visible: orderSelected,
            child: IconButton(
              tooltip: 'Excluir',
              onPressed: () async {
                var nav = Navigator.of(context);
                bool confirm = await showConfirmationDialog(
                      context,
                      'Deseja mesmo excluir  o pedido ${order[idSelected!].id.toString().padLeft(4, '0')}?',
                      buttonTitle: 'Sim',
                    ) ??
                    false;

                if (confirm) {
                  // controller.deleteMaterial(material.id);
                  nav.pop();
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar cliente',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
              child: filteredOrder.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.assignment,
                            size: 100,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.7),
                          ),
                          const Text(
                            'Não há nenhum pedido.',
                            style: textStyleSmallDefault,
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: filteredOrder
                          .map(
                            (order) => Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 5,
                                right: 15,
                              ),
                              child: GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    orderSelected = order.id != idSelected;
                                    idSelected =
                                        orderSelected ? order.id : null;
                                  });
                                },
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/order/details',
                                      arguments: order);
                                },
                                child: Card(
                                  color: idSelected != null &&
                                          order.id == idSelected
                                      ? theme.primaryColor
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Text(
                                            order.id.toString().padLeft(4, '0'),
                                            style: textStyleSmallFontWeight,
                                          ),
                                          title: Text(
                                            '${order.client.name.split(' ').first} ${order.client.name.split(' ').last}',
                                            style: textStyleSmallFontWeight,
                                          ),
                                        ),
                                        Divider(
                                          color: idSelected != null &&
                                                  order.id == idSelected
                                              ? Colors.black
                                              : null,
                                        ),
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                          title: Text(
                                            order.date,
                                            style: textStyleSmallDefault,
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Produto
                                              if (order.items.any((item) =>
                                                  item.product != null))
                                                Visibility(
                                                  visible: order.items
                                                          .where((item) =>
                                                              item.product !=
                                                              null)
                                                          .length ==
                                                      1,
                                                  replacement: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: order.items
                                                              .firstWhere((item) =>
                                                                  item.product !=
                                                                  null)
                                                              .product!
                                                              .name,
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' + ${order.items.where((item) => item.product != null).length - 1} produto(s)',
                                                        )
                                                      ],
                                                    ),
                                                    style:
                                                        textStyleSmallDefault,
                                                  ),
                                                  child: Text(
                                                    order.items
                                                        .firstWhere((item) =>
                                                            item.product !=
                                                            null)
                                                        .product!
                                                        .name,
                                                    style:
                                                        textStyleSmallDefault,
                                                  ),
                                                ),

                                              // Serviço
                                              if (order.items.any((item) =>
                                                      item.service != null) &&
                                                  order.items.any((item) =>
                                                      item.product != null))
                                                const Divider(),
                                              if (order.items.any((item) =>
                                                  item.service != null))
                                                Visibility(
                                                  visible: order.items
                                                          .where((item) =>
                                                              item.service !=
                                                              null)
                                                          .length ==
                                                      1,
                                                  replacement: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: order.items
                                                              .firstWhere((item) =>
                                                                  item.service !=
                                                                  null)
                                                              .service!
                                                              .description,
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' + ${order.items.where((item) => item.service != null).length - 1} serviço(s)',
                                                        )
                                                      ],
                                                    ),
                                                    style:
                                                        textStyleSmallDefault,
                                                  ),
                                                  child: Text(
                                                    order.items
                                                        .firstWhere((item) =>
                                                            item.service !=
                                                            null)
                                                        .service!
                                                        .description,
                                                    style:
                                                        textStyleSmallDefault,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                UtilsService.moneyToCurrency(
                                                    order.valueTotal ?? 0),
                                                style: TextStyle(
                                                    fontFamily: 'Anta',
                                                    fontSize:
                                                        textStyleSmallDefault
                                                            .fontSize,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                order.situation ?? 'Aguardando',
                                                style: TextStyle(
                                                    fontFamily:
                                                        textStyleSmallDefault
                                                            .fontFamily,
                                                    fontSize:
                                                        textStyleSmallDefault
                                                            .fontSize,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/order/form');
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
