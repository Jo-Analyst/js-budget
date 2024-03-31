import 'package:flutter/material.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_request_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/request_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  int? indexSelected;

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
          service: null,
        ),
      ],
    ),
    RequestModel(
      id: 2,
      date: '31/03/2024',
      client: ClientModel(name: 'Joelmir Rogério Carvalho'),
      items: [
        ItemRequestModel(
          product: [ProductModel(name: 'Mesa', description: '', unit: 'unit')],
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
            ProductModel(name: 'Cama box', description: '', unit: 'unit')
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

  @override
  Widget build(BuildContext context) {
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
                      'Deseja mesmo excluir  o pedido?',
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
      body: request.isEmpty
          ? const Center(
              child: Text(
                'Não há pedidos.',
                style: textStyleSmallDefault,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListView.builder(
                itemCount: request.length,
                itemBuilder: (context, index) {
                  var theme = Theme.of(context);
                  final req = request[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          requestSelected = indexSelected != index;
                          indexSelected = requestSelected ? index : null;
                        });
                      },
                      child: Card(
                        color: indexSelected != null &&
                                req.id == request[indexSelected!].id
                            ? theme.primaryColor
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text(
                                req.client.name,
                                style: textStyleSmallFontWeight,
                              ),
                              Divider(
                                color: indexSelected != null &&
                                        req.id == request[indexSelected!].id
                                    ? Colors.black
                                    : null,
                              ),
                              ListTile(
                                leading: Text(req.id.toString().padLeft(4, '0'),
                                    style: textStyleSmallFontWeight),
                                title: const Text('28/03/2014',
                                    style: textStyleSmallDefault),
                                subtitle: const Text('Guarda Roupa',
                                    style: textStyleSmallDefault),
                                trailing: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                  );
                },
              ),
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
