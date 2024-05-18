import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
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
  BudgetModel? budget;

  final budgetController = Injector.get<BudgetController>();

  List<ItemsBudgetModel> itemsBudget = [];

  List<MaterialItemsBudgetModel> materials = [];

  @override
  void initState() {
    super.initState();

    budget = budgetController.model.value;
    itemsBudget = budget!.itemsBudget!.map((e) => e).toList();
    materials = budgetController.getMaterials(budget!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          budget!.orderId.toString().padLeft(5, '0'),
          style: const TextStyle(fontFamily: 'Anta'),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var nav = Navigator.of(context);
              final confirm = await showConfirmationDialog(
                      context, 'Deseja mesmo excluir o orçamento?') ??
                  false;

              if (confirm) {
                await budgetController.delete(budget!.id);
                nav.pop();
              }
            },
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
                        budget!.valueTotal!,
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
                          budget!.client!.name,
                          style: textStyleSmallDefault,
                        ),
                        GestureDetector(
                          onTap: () async {
                            budget!.status = await Modal.showModal(
                                    context,
                                    StatusWidget(
                                        lastStatus: budget!.status!)) ??
                                budget!.status;
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                budget!.status!,
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
              Visibility(
                visible: materials.isNotEmpty,
                child: DetailWidget(
                  data: materials,
                  title: 'Peças e materiais',
                  detailType: DetailType.materials,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
