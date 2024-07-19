import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
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
  List<WorkshopExpenseItemsBudgetModel> workshopExpense = [];
  String status = '';

  @override
  void initState() {
    super.initState();

    budget = budgetController.model.value;
    status = budget!.status!;
    itemsBudget = budget!.itemsBudget!.map((e) => e).toList();
    materials = budgetController.getMaterials(budget!);
    workshopExpense = budgetController.getWorkshopExpense(budget!);
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

  bool? willDecrease() {
    final budgetStatus = budget!.status!.toLowerCase();
    final selectedStatus = status.toLowerCase();

    if (budgetStatus == 'aprovado' && selectedStatus == 'concluído') {
      return true;
    } else if (budgetStatus == 'concluído' &&
        (selectedStatus == 'aprovado' || selectedStatus == 'em aberto')) {
      return false;
    }

    return null;
  }

  bool checkStatus(String statusCurrent, String selectedStatus) {
    return (statusCurrent.toLowerCase() == 'concluído' ||
            statusCurrent.toLowerCase() == 'aprovado') &&
        selectedStatus.toLowerCase() == 'em aberto';
  }

  String? setApprovalDate() {
    return (status == 'Aprovado' && budget!.status == 'Em aberto')
        ? DateTime.now().toIso8601String()
        : (status == 'Em aberto')
            ? null
            : budget!.approvalDate;
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
          Visibility(
            visible: status != budget!.status,
            replacement: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                size: 30,
              ),
            ),
            child: IconButton(
              onPressed: () async {
                bool thereIsPaymentMade =
                    await budgetController.thereIsPaymentMade(
                        budget!.payment!.id,
                        checkStatus(budget!.status!, status));

                if (thereIsPaymentMade) return;

                await budgetController.changeStatusAndStockMaterial(
                    status, budget!.id, setApprovalDate(),
                    materialItems: materials, isDecrementation: willDecrease());
                budget!.status = status;

                setState(() {});
              },
              icon: const Icon(Icons.check),
              tooltip: 'Confirmar',
              iconSize: 30,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                                style: textStyleMediumDefault,
                              ),
                              GestureDetector(
                                onTap: () async {
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
                                        fontSize:
                                            textStyleMediumDefault.fontSize,
                                        fontFamily:
                                            textStyleMediumDefault.fontFamily,
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromARGB(
                                            255, 20, 87, 143),
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
                    Visibility(
                      visible: workshopExpense.isNotEmpty,
                      child: DetailWidget(
                        data: workshopExpense,
                        title: 'Custos Fixos',
                        detailType: DetailType.expense,
                        term: budgetController.totalTerm.value,
                      ),
                    ),
                    Visibility(
                      visible: workshopExpense.isNotEmpty,
                      child: DetailWidget(
                        data: [
                          {'type': 'Frete', 'value': budget!.freight},
                          {
                            'type': 'Margem de Lucro',
                            'value': budgetController.profitMargin.value
                          }
                        ],
                        title: 'Outro detalhes',
                        detailType: DetailType.outher,
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
          ),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(.5),
            padding: const EdgeInsets.all(15),
            height: 80,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: status == budget!.status
                  ? () async {
                      Navigator.of(context).pushNamed('/share');
                    }
                  : null,
              label: Text(
                'Gerar comprovante',
                style: TextStyle(
                  fontFamily: textStyleMediumDefault.fontFamily,
                  color: Colors.white,
                  fontSize: textStyleMediumDefault.fontSize,
                ),
              ),
              icon: const Icon(
                Icons.receipt_long_outlined,
                size: 25,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
