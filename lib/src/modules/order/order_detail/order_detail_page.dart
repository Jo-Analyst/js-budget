import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido'),
        actions: [
          IconButton(
            onPressed: () async {
              var orderController = context.get<OrderController>(),
                  nav = Navigator.of(context);
              bool confirm = await showConfirmationDialog(
                    context,
                    'Deseja mesmo excluir  o pedido ${order.id.toString().padLeft(4, '0')}?',
                    buttonTitle: 'Sim',
                  ) ??
                  false;

              if (confirm) {
                await orderController.deleteOrder(order.id);
                nav.pop();
              }
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_chart,
              size: 30,
            ),
            tooltip: 'Adicionar orçamento',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: CustomListTileIcon(
                    leading: const Icon(Icons.assignment),
                    title: 'Pedido ${order.id.toString().padLeft(4, '0')}',
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: CustomListTileIcon(
                    leading: const Icon(Icons.person),
                    title: order.client.name,
                  ),
                ),
              ),

              // Container Produtos
              if (order.items.any((item) => item.product != null))
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Card(
                    child: ColumnTile(
                      color: Colors.transparent,
                      textColor: Colors.black,
                      title: 'Produtos',
                      children: [
                        Column(
                          children: order.items.map((items) {
                            return Visibility(
                              visible: items.product != null,
                              child: CustomListTileIcon(
                                leading: const Icon(Icons.local_offer),
                                title: items.product?.name ?? '',
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

              // Container Serviços
              if (order.items.any((item) => item.service != null))
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Card(
                    child: ColumnTile(
                      color: Colors.transparent,
                      textColor: Colors.black,
                      title: 'Serviços',
                      children: [
                        Column(
                          children: order.items.map((items) {
                            return Visibility(
                              visible: items.service != null,
                              child: CustomListTileIcon(
                                leading: const Icon(
                                    FontAwesomeIcons.screwdriverWrench),
                                title: items.service?.description ?? '',
                              ),
                            );
                          }).toList(),
                        ),
                      ],
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
