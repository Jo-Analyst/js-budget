import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class BudgetForm extends StatefulWidget {
  const BudgetForm({super.key});

  @override
  State<BudgetForm> createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final controller = Injector.get<OrderController>();
  final List<ProductModel> products = [
    // ProductModel(name: 'Guarda Roupa', description: '', unit: ''),
    // ProductModel(name: 'Mesa', description: '', unit: ''),
    // ProductModel(name: 'Cadeira', description: '', unit: ''),
  ];

  final List<ServiceModel> services = [
    // ServiceModel(description: 'asdasdgashjgh')
  ];

  void loadProductsAndServices() {
    var items = controller.model.value!.items;
    for (var item in items) {
      if (item.product != null) {
        products.add(item.product!);
      }

      if (item.service != null) {
        services.add(item.service!);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadProductsAndServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo orçamento'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.save,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Card(
                      child: ColumnTile(
                        title: 'Dados do Pedido',
                        children: [
                          CustomListTileIcon(
                            leading: const Icon(Icons.assignment),
                            title:
                                'Pedido ${controller.model.value!.id.toString().padLeft(5, '0')}',
                            subtitle:
                                'Cliente: ${controller.model.value!.client.name}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Produtos
                    Visibility(
                      visible: products.isNotEmpty,
                      child: Card(
                        child: ColumnTile(
                          title: 'Produto(s)',
                          children: products
                              .map(
                                (product) => Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        product.name,
                                        style: textStyleSmallDefault,
                                      ),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).pushNamed(
                                              '/budget/pricing',
                                              arguments: product.name);
                                        },
                                        icon: const Icon(
                                          Icons.add_chart,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                        tooltip: 'Precificar',
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Serviços
                    Visibility(
                      visible: services.isNotEmpty,
                      child: Card(
                        child: ColumnTile(
                          title: 'Serviço(s)',
                          children: services
                              .map(
                                (service) => Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        service.description,
                                        style: textStyleSmallDefault,
                                      ),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).pushNamed(
                                              '/budget/pricing',
                                              arguments: service.description);
                                        },
                                        icon: const Icon(
                                          Icons.add_chart,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                        tooltip: 'Precificar',
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Theme.of(context).primaryColor,
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  Visibility(
                    visible: products.isNotEmpty,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Valor do produto(s)',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(0),
                          style: const TextStyle(
                              fontFamily: 'Anta',
                              fontSize: 23,
                              color: Color.fromARGB(255, 24, 113, 185)),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: services.isNotEmpty,
                    child: const Divider(color: Colors.black45),
                  ),
                  Visibility(
                    visible: services.isNotEmpty,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Valor do serviço(s)',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(0),
                          style: const TextStyle(
                            fontFamily: 'Anta',
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 24, 113, 185),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Despesa da oficina',
                        style: textStyleSmallFontWeight,
                      ),
                      Text(
                        UtilsService.moneyToCurrency(0),
                        style: const TextStyle(
                          fontFamily: 'Anta',
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Valor a pagar',
                        style: textStyleSmallFontWeight,
                      ),
                      Text(
                        UtilsService.moneyToCurrency(0),
                        style: const TextStyle(
                          fontFamily: 'Anta',
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
