import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final controller = Injector.get<OrderController>();
  final pricingController = Injector.get<PricingController>();

  BudgetModel budgetModel = BudgetModel(
      products: [],
      services: [],
      materialItemsBudget: [],
      fixedExpenseItemsBudget: []);
  void loadProductsAndServices() {
    var items = controller.model.value!.items;
    for (var item in items) {
      if (item.product != null) {
        budgetModel.products.add(item.product!);
      }

      if (item.service != null) {
        budgetModel.services.add(item.service!);
      }
    }
  }

  double sumPriceService() {
    double priceTotal = 0;
    for (var service in budgetModel.services) {
      priceTotal += service.price;
    }

    return priceTotal;
  }

  @override
  void initState() {
    super.initState();
    loadProductsAndServices();
  }

  int index = 0;

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
                      visible: budgetModel.products.isNotEmpty,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Produto(s)',
                                  style: textStyleSmallFontWeight),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: budgetModel.products.length,
                                itemBuilder: (context, index) {
                                  final product = budgetModel.products[index];
                                  return Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${product.quantity}x',
                                              style: TextStyle(
                                                  fontSize:
                                                      textStyleSmallDefault
                                                          .fontSize,
                                                  fontFamily: 'Anta'),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          product.name,
                                          style: textStyleSmallDefault,
                                        ),
                                        subtitle: product.price > 0
                                            ? Text(
                                                UtilsService.moneyToCurrency(
                                                    product.price),
                                                style: TextStyle(
                                                  fontFamily: 'Anta',
                                                  fontSize:
                                                      textStyleSmallDefault
                                                          .fontSize,
                                                ),
                                              )
                                            : null,
                                        trailing: IconButton(
                                          onPressed: () async {
                                            bool? isConfirmed = await Navigator
                                                        .of(context)
                                                    .pushNamed(
                                                        '/budget/pricing',
                                                        arguments: product
                                                            .name) as bool? ??
                                                false;

                                            if (isConfirmed) {
                                              budgetModel.materialItemsBudget!
                                                  .addAll(pricingController
                                                      .materialItemsBudget);
                                            }
                                            setState(() {
                                              budgetModel.products[index]
                                                  .price = pricingController
                                                      .totalToBeCharged *
                                                  product.quantity;
                                            });

                                            // pricingController.clearFields();
                                          },
                                          icon: product.price == 0
                                              ? const Icon(
                                                  Icons.add_chart,
                                                  size: 30,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.edit,
                                                  size: 25,
                                                  color: Colors.black,
                                                ),
                                          tooltip: 'Precificar',
                                        ),
                                      ),
                                      const Divider()
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Serviços
                    Visibility(
                      visible: budgetModel.services.isNotEmpty,
                      child: Card(
                        child: ColumnTile(
                          title: 'Serviço(s)',
                          children: budgetModel.services
                              .map(
                                (service) => Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        service.description,
                                        style: textStyleSmallDefault,
                                      ),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '${service.quantity}x',
                                            style: TextStyle(
                                                fontSize: textStyleSmallDefault
                                                    .fontSize,
                                                fontFamily: 'Anta'),
                                          ),
                                        ),
                                      ),
                                      trailing: Text(
                                        UtilsService.moneyToCurrency(
                                            service.price),
                                        style: TextStyle(
                                          fontFamily: 'Anta',
                                          fontSize:
                                              textStyleSmallDefault.fontSize,
                                        ),
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
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  Visibility(
                    visible: budgetModel.products.isNotEmpty,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Preço do produto(s)',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(0),
                          style: const TextStyle(
                            fontFamily: 'Anta',
                            fontSize: 23,
                            color: Color.fromARGB(255, 24, 113, 185),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: budgetModel.services.isNotEmpty,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Preço do serviço(s)',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(sumPriceService()),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Despesa',
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
