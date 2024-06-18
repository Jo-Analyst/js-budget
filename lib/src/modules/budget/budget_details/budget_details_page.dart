import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/budget/budget_details/widgets/detail_widget.dart';
import 'package:js_budget/src/modules/budget/budget_details/widgets/show_dialog_status.dart';
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
  String status = '';
  @override
  void initState() {
    super.initState();

    budget = budgetController.model.value;
    status = budget!.status!;
    itemsBudget = budget!.itemsBudget!.map((e) => e).toList();
    materials = budgetController.getMaterials(budget!);
  }

  Future<String?> showDialogStatus(BuildContext context,
      {required String status}) {
    return showDialog<String>(
      context: context,
      builder: (_) => ShowDialogStatus(
        statusCurrent: budget!.status!,
        statusSelected: status,
      ),
    );
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
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Compartilhar',
            iconSize: 30,
          ),
          Visibility(
            visible: status != budget!.status,
            child: IconButton(
              onPressed: () async {
                budget!.status = status;
                var nav = Navigator.of(context);
                await budgetController.changeStatus(
                    budget!.status!, budget!.id);
                nav.pop();
              },
              icon: const Icon(Icons.check),
              tooltip: 'Confirmar',
              iconSize: 30,
            ),
          )
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
                            // status = await Modal.showModal(
                            //       context,
                            //       StatusWidget(
                            //         lastStatus: status,
                            //         budgetId: budget!.id,
                            //       ),
                            //     ) ??
                            //     budget!.status;

                            final result = await showDialogStatus(
                              context,
                              status: status,
                            );

                            status = result ?? status;

                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                status,
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
              if (budget!.payment != null)
                DetailWidget(
                  data: [budget!.payment!],
                  title: 'Meio de Pagamento',
                  detailType: DetailType.payment,
                ),
            ],
          ),
        ),
      ),
    );
  }
}