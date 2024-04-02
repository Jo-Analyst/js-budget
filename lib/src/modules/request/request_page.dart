import 'package:flutter/material.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_request_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/request_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  int? idSelected;

  final List<RequestModel> request = [
    RequestModel(
      id: 1,
      date: '31/03/2024',
      client: ClientModel(name: 'Valdirene Aparecida Ferreira'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemRequestModel(
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
    RequestModel(
      id: 2,
      date: '31/03/2024',
      client: ClientModel(name: 'Joelmir Rogério Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemRequestModel(
          product: [
            ProductModel(name: 'Mesa', description: '', unit: 'unit'),
            ProductModel(name: 'Cadeira', description: '', unit: 'unit'),
            ProductModel(name: 'Banco', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
    RequestModel(
      id: 3,
      date: '31/03/2024',
      client: ClientModel(name: 'Bennedito Ferreira Carvalho '),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemRequestModel(
          product: [
            ProductModel(name: 'Cadeira', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
    RequestModel(
      id: 4,
      date: '31/03/2024',
      client: ClientModel(name: 'Noelly Cristina Ferreira Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemRequestModel(
          product: [
            ProductModel(name: 'Cama box', description: '', unit: 'unit'),
            ProductModel(name: 'Mesa', description: '', unit: 'unit'),
          ],
          service: null,
        ),
      ],
    ),
    RequestModel(
      id: 5,
      date: '31/03/2024',
      client: ClientModel(name: 'Maria Lídia Ferreira Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemRequestModel(
          product: [
            ProductModel(name: 'Harcker', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
    RequestModel(
      id: 6,
      date: '31/03/2024',
      client: ClientModel(name: 'Lorrayne Carvalho'),
      situation: 'Aguardando',
      valueTotal: 0.0,
      items: [
        ItemRequestModel(
          product: [
            ProductModel(name: 'Armário', description: '', unit: 'unit')
          ],
          service: null,
        ),
      ],
    ),
  ];
  bool requestSelected = false;
  String search = '';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var filteredRequest = request
        .where((req) =>
            req.client.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          Visibility(
            visible: requestSelected,
            child: IconButton(
              tooltip: 'Editar',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/request/form',
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ),
          Visibility(
            visible: requestSelected,
            child: IconButton(
              tooltip: 'Excluir',
              onPressed: () async {
                var nav = Navigator.of(context);
                bool confirm = await showConfirmationDialog(
                      context,
                      'Deseja mesmo excluir  o pedido ${request[idSelected!].id.toString().padLeft(4, '0')}?',
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
              child: filteredRequest.isEmpty
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
                      children: filteredRequest
                          .map(
                            (request) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      requestSelected =
                                          request.id != idSelected;
                                      idSelected =
                                          requestSelected ? request.id : null;
                                    });
                                  },
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/request/details',
                                        arguments: request);
                                  },
                                  child: Card(
                                    color: idSelected != null &&
                                            request.id == idSelected
                                        ? theme.primaryColor
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Text(
                                              request.id
                                                  .toString()
                                                  .padLeft(4, '0'),
                                              style: textStyleSmallFontWeight,
                                            ),
                                            title: Text(
                                              '${request.client.name.split(' ').first} ${request.client.name.split(' ').last}',
                                              style: textStyleSmallFontWeight,
                                            ),
                                          ),
                                          Divider(
                                            color: idSelected != null &&
                                                    request.id == idSelected
                                                ? Colors.black
                                                : null,
                                          ),
                                          ListTile(
                                            title: Text(
                                              request.date,
                                              style: textStyleSmallDefault,
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (request.items[0].product !=
                                                    null)

                                                  // Produto
                                                  Wrap(
                                                    children: request
                                                            .items.isNotEmpty
                                                        ? request.items[0]
                                                                        .product !=
                                                                    null &&
                                                                request
                                                                    .items[0]
                                                                    .product!
                                                                    .isNotEmpty
                                                            ? [
                                                                Text(
                                                                  request
                                                                      .items[0]
                                                                      .product![
                                                                          0]
                                                                      .name,
                                                                  style:
                                                                      textStyleSmallDefault,
                                                                ),
                                                                if (request
                                                                        .items[
                                                                            0]
                                                                        .product!
                                                                        .length >
                                                                    1)
                                                                  Text(
                                                                    ' e mais ${request.items[0].product!.length - 1} ${(request.items[0].product!.length - 1) > 1 ? 'produtos' : 'produto'}',
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
                                                if (request.items[0].service !=
                                                        null &&
                                                    request.items[0].product !=
                                                        null)
                                                  const Divider(),
                                                if (request.items[0].service !=
                                                    null)

                                                  // Serviço
                                                  Wrap(
                                                    children: request
                                                            .items.isNotEmpty
                                                        ? request.items[0]
                                                                        .service !=
                                                                    null &&
                                                                request
                                                                    .items[0]
                                                                    .service!
                                                                    .isNotEmpty
                                                            ? [
                                                                Text(
                                                                  request
                                                                      .items[0]
                                                                      .service![
                                                                          0]
                                                                      .description,
                                                                  style:
                                                                      textStyleSmallDefault,
                                                                ),
                                                                if (request
                                                                        .items[
                                                                            0]
                                                                        .service!
                                                                        .length >
                                                                    1)
                                                                  Text(
                                                                    ' e mais ${request.items[0].service!.length - 1} ${(request.items[0].service!.length - 1) > 1 ? 'serviços' : 'serviço'}',
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
                                                      request.valueTotal ?? 0),
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
                                                  request.situation ??
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
          Navigator.of(context).pushNamed('/request/form');
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
