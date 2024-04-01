import 'package:flutter/material.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_request_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/request_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/themes/light_theme.dart';

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
      items: [
        ItemRequestModel(
          product: [
            ProductModel(name: 'Guarda Roupa', description: '', unit: 'unit')
          ],
          service: [ServiceModel(description: 'Montagem de guarda roupa')],
        ),
      ],
    ),
    RequestModel(
      id: 2,
      date: '31/03/2024',
      client: ClientModel(name: 'Joelmir Rogério Carvalho'),
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
    var filteredMaterials = request
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
                  '/material/save',
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
              child: filteredMaterials.isEmpty
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
                      children: filteredMaterials
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      requestSelected = e.id != idSelected;
                                      idSelected =
                                          requestSelected ? e.id : null;
                                    });
                                  },
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/request/details',
                                        arguments: e);
                                  },
                                  child: Card(
                                    color:
                                        idSelected != null && e.id == idSelected
                                            ? theme.primaryColor
                                            : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            e.client.name,
                                            style: textStyleSmallFontWeight,
                                          ),
                                          Divider(
                                            color: idSelected != null &&
                                                    e.id == idSelected
                                                ? Colors.black
                                                : null,
                                          ),
                                          ListTile(
                                            leading: Text(
                                              e.id.toString().padLeft(4, '0'),
                                              style: textStyleSmallFontWeight,
                                            ),
                                            title: Text(
                                              e.date,
                                              style: textStyleSmallDefault,
                                            ),
                                            subtitle: Wrap(
                                              children: e.items.isNotEmpty
                                                  ? e.items[0].product !=
                                                              null &&
                                                          e.items[0].product!
                                                              .isNotEmpty
                                                      ? [
                                                          Text(
                                                            e
                                                                .items[0]
                                                                .product![0]
                                                                .name,
                                                            style:
                                                                textStyleSmallDefault,
                                                          ),
                                                          if (e
                                                                  .items[0]
                                                                  .product!
                                                                  .length >
                                                              1)
                                                            Text(
                                                              ' e mais ${e.items[0].product!.length - 1} ${(e.items[0].product!.length - 1) > 1 ? 'items' : 'item'}',
                                                              style:
                                                                  textStyleSmallDefault,
                                                            )
                                                        ]
                                                      : [Container()]
                                                  : [],
                                            ),
                                            trailing: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 30,
                                                )
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
          // showModal(context, const NewTransaction());
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
