import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/budget/item_budget/item_budget_controller.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/modules/budget/widget/payment_methods_widget.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/modules/widget/custom_icons.dart';
import 'package:js_budget/src/pages/home/widgets/show_modal_widget.dart';
import 'package:js_budget/src/pages/widgets/list_view_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final numberOfInstallmentsEC = TextEditingController();
  final freightEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final orderController = Injector.get<OrderController>();
  final pricingController = Injector.get<PricingController>();
  final budgetController = Injector.get<BudgetController>();
  final itemBudgetController = Injector.get<ItemBudgetController>();

  double valueTotalProduct = 0, valueTotalBudget = 0;
  int numberOfInstallments = 1;
  String methodPayment = 'Nenhum';
  BudgetModel budgetModel = BudgetModel();

  void loadProductsAndServices() {
    var items = orderController.model.value!.items;
    itemBudgetController.add(items);
  }

  double sumPriceService() {
    double priceTotal = 0;
    for (var data in itemBudgetController.data) {
      if (data.service != null) {
        priceTotal += data.service!.price;
      }
    }

    return priceTotal;
  }

  void changeValueServiceInItemsBudget() {
    for (var data in itemBudgetController.data) {
      if (data.service != null) {
        data.subValue = data.service!.price * data.service!.quantity;
        data.unitaryValue = data.service!.price;
      }
    }
  }

  void initializeBudget() {
    budgetModel.orderId = orderController.model.value!.id;
    budgetModel.client = orderController.model.value!.client;
    calculateBudget();
  }

  void calculateBudget() {
    valueTotalBudget =
        sumPriceService() + valueTotalProduct + freightEC.numberValue;
    budgetModel.valueTotal = valueTotalBudget;
    setState(() {});
  }

  void changeValuePricing(int index) {
    if (itemBudgetController.data[index].subValue > 0) {
      pricingController.term = itemBudgetController.data[index].term;
      pricingController.percentageProfitMargin =
          itemBudgetController.data[index].percentageProfitMargin;
      pricingController.timeIncentive =
          itemBudgetController.data[index].timeIncentive;
      pricingController.materialItemsBudget
          .addAll(itemBudgetController.data[index].materialItemsBudget);
      pricingController.workshopExpenseItemsBudget
          .addAll(itemBudgetController.data[index].workshopExpenseItemsBudget);
    }
  }

  @override
  void initState() {
    super.initState();
    loadProductsAndServices();
    changeValueServiceInItemsBudget();
    initializeBudget();
    numberOfInstallmentsEC.text = numberOfInstallments.toString();
  }

  @override
  void dispose() {
    super.dispose();
    numberOfInstallmentsEC.dispose();
    freightEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo orçamento'),
        actions: [
          IconButton(
            onPressed: () async {
              bool isValid =
                  budgetController.validateFields(itemBudgetController.data);

              var nav = Navigator.of(context);

              if (isValid) {
                budgetModel.itemsBudget = itemBudgetController.data;
                budgetModel.freight = itemBudgetController.data
                        .any((itemBudget) => itemBudget.product != null)
                    ? freightEC.numberValue
                    : null;
                budgetModel.payment = methodPayment != 'Nenhum'
                    ? PaymentModel(
                        specie: methodPayment,
                        amountToPay: valueTotalBudget,
                        numberOfInstallments: numberOfInstallments,
                      )
                    : PaymentModel(
                        specie: 'Não definido',
                        amountToPay: valueTotalBudget,
                      );

                final isError = await budgetController.save(budgetModel);

                if (!isError) {
                  nav.pushNamed(
                    '/budget/screen-success',
                  );
                }
              }
            },
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
                    // Dados do pedido
                    Card(
                      child: ListViewTile(
                        title: 'Dados do Pedido',
                        children: [
                          CustomListTileIcon(
                            leading: const Icon(Icons.assignment),
                            title:
                                'Pedido ${orderController.model.value!.id.toString().padLeft(5, '0')}',
                            subtitle:
                                'Cliente: ${orderController.model.value!.client.name}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Produtos
                    Visibility(
                      visible: itemBudgetController.data
                          .any((itemBudget) => itemBudget.product != null),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Produto(s)',
                                  style: textStyleMediumFontWeight),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: itemBudgetController.data
                                    .where((item) => item.product != null)
                                    .length,
                                itemBuilder: (context, index) {
                                  final product =
                                      itemBudgetController.data[index].product;
                                  return Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${product!.quantity}x',
                                              style: TextStyle(
                                                fontSize: textStyleMediumDefault
                                                    .fontSize,
                                                fontFamily: 'Anta',
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          product.name,
                                          style: textStyleMediumDefault,
                                        ),
                                        subtitle: itemBudgetController
                                                    .data[index].subValue >
                                                0
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'V.Un. ${UtilsService.moneyToCurrency(itemBudgetController.data[index].unitaryValue)}',
                                                    style: TextStyle(
                                                      fontFamily: 'Anta',
                                                      fontSize:
                                                          textStyleMediumDefault
                                                              .fontSize,
                                                    ),
                                                  ),
                                                  Text(
                                                    'V.Tot. ${UtilsService.moneyToCurrency(itemBudgetController.data[index].subValue)}',
                                                    style: TextStyle(
                                                      fontFamily: 'Anta',
                                                      fontSize:
                                                          textStyleMediumDefault
                                                              .fontSize,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : null,
                                        trailing: IconButton(
                                          onPressed: () async {
                                            changeValuePricing(index);

                                            bool? isConfirmed = await Navigator
                                                        .of(context)
                                                    .pushNamed(
                                                        '/budget/pricing',
                                                        arguments: product
                                                            .name) as bool? ??
                                                false;

                                            if (isConfirmed) {
                                              itemBudgetController
                                                  .addMaterialsAndExpenses(
                                                      index,
                                                      product,
                                                      product.quantity,
                                                      pricingController);

                                              setState(() {
                                                valueTotalProduct =
                                                    budgetController
                                                        .sumValueProducts(
                                                            itemBudgetController
                                                                .data);
                                              });

                                              calculateBudget();
                                            }

                                            pricingController.clearFields();
                                          },
                                          icon: itemBudgetController
                                                      .data[index].subValue ==
                                                  0
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
                      visible: itemBudgetController.data
                          .any((itemBudget) => itemBudget.service != null),
                      child: Card(
                        child: ListViewTile(
                          title: 'Serviço(s)',
                          children: itemBudgetController.data
                              .where((itemBudget) => itemBudget.service != null)
                              .map(
                                (itemBudget) => Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        itemBudget.service!.description,
                                        style: textStyleMediumDefault,
                                      ),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '${itemBudget.service!.quantity}x',
                                            style: TextStyle(
                                                fontSize: textStyleMediumDefault
                                                    .fontSize,
                                                fontFamily: 'Anta'),
                                          ),
                                        ),
                                      ),
                                      trailing: Text(
                                        UtilsService.moneyToCurrency(
                                            itemBudget.service!.price),
                                        style: TextStyle(
                                          fontFamily: 'Anta',
                                          fontSize:
                                              textStyleMediumDefault.fontSize,
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
                    // Frete
                    Visibility(
                      visible: itemBudgetController.data
                          .any((itemBudget) => itemBudget.product != null),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Frete',
                                style: textStyleMediumFontWeight,
                              ),
                              TextFormField(
                                controller: freightEC,
                                onTapOutside: (_) =>
                                    FocusScope.of(context).unfocus(),
                                decoration: const InputDecoration(
                                  label: Text(
                                    'Valor do frete',
                                    style: textStyleMediumDefault,
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Anta',
                                  fontSize: textStyleMediumDefault.fontSize,
                                ),
                                onChanged: (value) {
                                  calculateBudget();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Meio de pagamento
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListViewTile(
                          title: 'Meio de pagamento',
                          children: [
                            ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading:
                                    CustomIcons.paymentsMethod(methodPayment),
                                title: Text(
                                  methodPayment,
                                  style: textStyleMediumDefault,
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    methodPayment == 'Nenhum'
                                        ? Icons.add_card_outlined
                                        : Icons.movie_edit,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    methodPayment = await Modal.showModal(
                                          context,
                                          PaymentMethodsWidget(
                                            lastStatus: methodPayment,
                                          ),
                                        ) ??
                                        methodPayment;
                                    setState(() {});
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                    // Número de parcelas
                    Visibility(
                      visible: methodPayment.toLowerCase() != 'nenhum',
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Número de Parcelas',
                                style: textStyleMediumFontWeight,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  onTapOutside: (_) =>
                                      FocusScope.of(context).unfocus(),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  textAlign: TextAlign.right,
                                  controller: numberOfInstallmentsEC,
                                  style: textStyleMediumDefault,
                                  onChanged: (portion) => numberOfInstallments =
                                      portion.isNotEmpty
                                          ? int.parse(portion)
                                          : 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
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
                    visible: itemBudgetController.data
                            .any((itemBudget) => itemBudget.product != null) &&
                        itemBudgetController.data
                            .any((itemBudget) => itemBudget.service != null),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Preço do(s) produto(s)',
                        style: textStyleMediumFontWeight,
                      ),
                      trailing: Text(
                        UtilsService.moneyToCurrency(valueTotalProduct),
                        style: const TextStyle(
                          fontFamily: 'Anta',
                          fontSize: 23,
                          color: Color.fromARGB(255, 24, 113, 185),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: itemBudgetController.data
                            .any((itemBudget) => itemBudget.product != null) &&
                        itemBudgetController.data
                            .any((itemBudget) => itemBudget.service != null),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Preço do serviço(s)',
                        style: textStyleMediumFontWeight,
                      ),
                      trailing: Text(
                        UtilsService.moneyToCurrency(sumPriceService()),
                        style: const TextStyle(
                          fontFamily: 'Anta',
                          fontSize: 23,
                          color: Color.fromARGB(255, 24, 113, 185),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Valor a cobrar',
                      style: textStyleMediumFontWeight,
                    ),
                    trailing: Text(
                      UtilsService.moneyToCurrency(valueTotalBudget),
                      style: const TextStyle(
                        fontFamily: 'Anta',
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
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
