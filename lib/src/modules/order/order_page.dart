import 'package:flutter/material.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
          product: [
            ProductModel(name: 'Guarda Roupa', description: '', unit: 'unit')
          ],
          service: [
            ServiceModel(description: 'Montagem de guarda roupa'),
            ServiceModel(description: 'Montagem de guarda roupa'),
          ],
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
          product: [
            ProductModel(name: 'Mesa', description: '', unit: 'unit'),
            ProductModel(name: 'Cadeira', description: '', unit: 'unit'),
            ProductModel(name: 'Banco', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
    OrderModel(
      id: 3,
      date: '31/03/2024',
      client: ClientModel(name: 'Bennedito Ferreira Carvalho '),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemOrderModel(
          product: [
            ProductModel(name: 'Cadeira', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
    OrderModel(
      id: 4,
      date: '31/03/2024',
      client: ClientModel(name: 'Noelly Cristina Ferreira Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemOrderModel(
          product: [
            ProductModel(name: 'Cama box', description: '', unit: 'unit'),
            ProductModel(name: 'Mesa', description: '', unit: 'unit'),
          ],
          service: null,
        ),
      ],
    ),
    OrderModel(
      id: 5,
      date: '31/03/2024',
      client: ClientModel(name: 'Maria Lídia Ferreira Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemOrderModel(
          product: [
            ProductModel(name: 'Harcker', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
    OrderModel(
      id: 6,
      date: '31/03/2024',
      client: ClientModel(name: 'Lorrayne Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemOrderModel(
          product: [
            ProductModel(name: 'Armário', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
  ];
  bool orderSelected = false;
  String search = '';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var filteredOrder = order
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      orderSelected =
                                          order.id != idSelected;
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
                                              order.id
                                                  .toString()
                                                  .padLeft(4, '0'),
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
                                            title: Text(
                                              order.date,
                                              style: textStyleSmallDefault,
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (order.items[0].product !=
                                                    null)

                                                  // Produto
                                                  Wrap(
                                                    children: order
                                                            .items.isNotEmpty
                                                        ? order.items[0]
                                                                        .product !=
                                                                    null &&
                                                                order
                                                                    .items[0]
                                                                    .product!
                                                                    .isNotEmpty
                                                            ? [
                                                                Text(
                                                                  order
                                                                      .items[0]
                                                                      .product![
                                                                          0]
                                                                      .name,
                                                                  style:
                                                                      textStyleSmallDefault,
                                                                ),
                                                                if (order
                                                                        .items[
                                                                            0]
                                                                        .product!
                                                                        .length >
                                                                    1)
                                                                  Text(
                                                                    ' e mais ${order.items[0].product!.length - 1} ${(order.items[0].product!.length - 1) > 1 ? 'produtos' : 'produto'}',
                                                                    style:
                                                                        textStyleSmallDefault,
                                                                  )
                                                              ]
                                                            : []
                                                        : [
                                                            Container(
                                                              color: Colors.red,
                                                              width: 100,
                                                              height: 100,
                                                            )
                                                          ],
                                                  ),
                                                if (order.items[0].service !=
                                                        null &&
                                                    order.items[0].product !=
                                                        null)
                                                  const Divider(),
                                                if (order.items[0].service !=
                                                    null)

                                                  // Serviço
                                                  Wrap(
                                                    children: order
                                                            .items.isNotEmpty
                                                        ? order.items[0]
                                                                        .service !=
                                                                    null &&
                                                                order
                                                                    .items[0]
                                                                    .service!
                                                                    .isNotEmpty
                                                            ? [
                                                                Text(
                                                                  order
                                                                      .items[0]
                                                                      .service![
                                                                          0]
                                                                      .description,
                                                                  style:
                                                                      textStyleSmallDefault,
                                                                ),
                                                                if (order
                                                                        .items[
                                                                            0]
                                                                        .service!
                                                                        .length >
                                                                    1)
                                                                  Text(
                                                                    ' e mais ${order.items[0].service!.length - 1} ${(order.items[0].service!.length - 1) > 1 ? 'serviços' : 'serviço'}',
                                                                    style:
                                                                        textStyleSmallDefault,
                                                                  )
                                                              ]
                                                            : []
                                                        : [
                                                            Container(
                                                              color: Colors.red,
                                                              width: 100,
                                                              height: 100,
                                                            )
                                                          ],
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
                                                  order.situation ??
                                                      'Aguardando',
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
