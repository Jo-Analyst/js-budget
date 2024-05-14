import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_detail_controller.dart';
import 'package:js_budget/src/pages/home/budget_details/widgets/detail_widget.dart';
import 'package:js_budget/src/pages/home/budget_details/widgets/status_widget.dart';
import 'package:js_budget/src/pages/home/widgets/show_modal_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class BudgetDetailsPage extends StatefulWidget {
  const BudgetDetailsPage({super.key});

  @override
  State<BudgetDetailsPage> createState() => _BudgetDetailsPageState();
}

class _BudgetDetailsPageState extends State<BudgetDetailsPage> {
  late BudgetModel budget =
      ModalRoute.of(context)!.settings.arguments as BudgetModel;
  final budgetDetailController = Injector.get<BudgetDetailController>();

  List<ItemsBudgetModel> itemsBudget = [];

  List<Map<String, dynamic>> payments = [
    {
      'specie-payment': 'PIX',
      'amount-to-pay': 1000.0,
      'installment-quantity': 1, // quantidade parcela
      'installment-value': 1000.0, // valor paracelado
    }
  ];

  List<Map<String, dynamic>> materials = [
    {
      'description': 'Madeira PVC',
      'quantity': 1,
      'unit': 'un',
      'price': 300.00,
      'price-total': 300.00,
    },
    {
      'description': 'Pregos',
      'quantity': 1,
      'unit': 'un',
      'price': 18.00,
      'price-total': 180.00,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loadItemsBudget();
  }

  Future<void> loadItemsBudget() async {
    await budgetDetailController.findProducts(budget.id);
    await budgetDetailController.findMaterials(budget.id);
    setState(() {
      itemsBudget = budgetDetailController.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          budget.id.toString().padLeft(5, '0'),
          style: const TextStyle(fontFamily: 'Anta'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            tooltip: 'Excluir',
            iconSize: 25,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Compartilhar',
            iconSize: 25,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      UtilsService.moneyToCurrency(
                        budget.valueTotal!,
                      ),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Anta',
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          budget.client!.name,
                          style: textStyleSmallDefault,
                        ),
                        GestureDetector(
                          onTap: () async {
                            budget.status = await Modal.showModal(context,
                                    StatusWidget(lastStatus: budget.status!)) ??
                                budget.status;
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                budget.status!,
                                style: TextStyle(
                                  fontSize: textStyleSmallDefault.fontSize,
                                  fontFamily: textStyleSmallDefault.fontFamily,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromARGB(255, 20, 87, 143),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.edit,
                                size: 18,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              DetailWidget(
                data: itemsBudget,
                title: 'Produtos e serviços',
                detailType: DetailType.productsAndService,
              ),

              // DetailWidget(data: materials, title: 'Peças e materiais'),
              // DetailWidget(
              //   data: payments,
              //   title: 'Pagamento',
              //   iconPayment: const Icon(Icons.pix),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
