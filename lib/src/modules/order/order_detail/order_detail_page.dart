import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/pages/widgets/list_view_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    final controller = Injector.get<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido'),
        actions: [
          Visibility(
            visible: order.status == 'Aguardando orçamento',
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ElevatedButton(
                onPressed: () {
                  controller.model.value = order;
                  Navigator.of(context)
                      .pushNamed('/budget/form', arguments: order);
                },
                child: const Text(
                  'Fazer orçamento',
                  style: textStyleSmallDefault,
                ),
              ),
            ),
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
                    title: 'Pedido ${order.id.toString().padLeft(5, '0')}',
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
                    child: ListViewTile(
                      title: 'Produtos',
                      children: [
                        Column(
                          children: order.items.map((items) {
                            return Visibility(
                              visible: items.product != null,
                              child: CustomListTileIcon(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 10),
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${items.product?.quantity}x',
                                      style: TextStyle(
                                          fontSize:
                                              textStyleSmallDefault.fontSize,
                                          fontFamily: 'Anta'),
                                    ),
                                  ),
                                ),
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
                    child: ListViewTile(
                      title: 'Serviços',
                      children: [
                        Column(
                          children: order.items.map((items) {
                            return Visibility(
                              visible: items.service != null,
                              child: CustomListTileIcon(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 10),
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${items.service?.quantity}x',
                                      style: TextStyle(
                                          fontSize:
                                              textStyleSmallDefault.fontSize,
                                          fontFamily: 'Anta'),
                                    ),
                                  ),
                                ),
                                title: items.service?.description ?? '',
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

              if (order.observation != null)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Card(
                    child: ListViewTile(
                      title: 'Observação',
                      children: [
                        ListTile(
                          title: Text(
                            order.observation!,
                            style: textStyleSmallDefault,
                          ),
                          leading: const Icon(Icons.note_alt_outlined),
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
