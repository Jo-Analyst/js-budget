import 'package:flutter/material.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class BudgetForm extends StatefulWidget {
  const BudgetForm({super.key});

  @override
  State<BudgetForm> createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final List<ProductModel> products = [
    ProductModel(name: 'Guarda Roupa', description: '', unit: ''),
    ProductModel(name: 'Mesa', description: '', unit: ''),
    ProductModel(name: 'Cadeira', description: '', unit: ''),
  ];

  final List<ServiceModel> services = [
    ServiceModel(description: 'asdasdgashjgh')
  ];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              const Card(
                child: ColumnTile(
                  title: 'Dados do Pedido',
                  children: [
                    CustomListTileIcon(
                      leading: Icon(Icons.assignment),
                      title: 'Pedido 0001',
                      subtitle: 'Cliente: Valdirene Ferreira',
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
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed('/budget/pricing'),
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
                          (product) => Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  product.description,
                                  style: textStyleSmallDefault,
                                ),
                                trailing: IconButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed('/budget/pricing'),
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
    );
  }
}
