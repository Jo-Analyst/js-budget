import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/budget/budget_details/widgets/detail_widget.dart';
import 'package:js_budget/src/modules/budget/budget_details/widgets/show_dialog_status.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
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
  List<Map<String, dynamic>> inconclusiveData = [];
  List<MaterialItemsBudgetModel> materials = [];
  List<WorkshopExpenseItemsBudgetModel> workshopExpense = [];
  List<ServiceModel> services = [];
  List<ProductModel> products = [];
  String status = '';
  DateTime initialDate = DateTime.now();
  DateTime? approvalDate;

  @override
  void initState() {
    super.initState();

    budget = budgetController.model.value;
    status = budget!.status!;
    itemsBudget = budget!.itemsBudget!.map((e) => e).toList();
    services = getServices();
    products = getProducts();
    inconclusiveData = getInconclusiveData();
    materials = budgetController.getMaterials(budget!);
    workshopExpense = budgetController.getWorkshopExpense(budget!);
  }

  List<ServiceModel> getServices() {
    return itemsBudget
        .where((item) => item.service != null)
        .map((item) => ServiceModel(
              description: item.service!.description,
              price: item.unitaryValue,
              quantity: item.quantity,
            ))
        .toList();
  }

  List<ProductModel> getProducts() {
    return itemsBudget
        .where((item) => item.product != null)
        .map((item) => ProductModel(
              name: item.product!.name,
              price: item.unitaryValue,
              quantity: item.quantity,
            ))
        .toList();
  }

  List<Map<String, dynamic>> getInconclusiveData() {
    return itemsBudget
        .where((item) => item.service == null && item.product == null)
        .map((item) => {
              'description': 'P|S Indefinido',
              'price': item.unitaryValue,
              'quantity': item.quantity,
            })
        .toList();
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
        ? approvalDate!.toIso8601String()
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: FlexibleText(
                              text:
                                  UtilsService.moneyToCurrency(budget!.amount!),
                              fontWeight: textStyleMediumFontWeight.fontWeight,
                              fontFamily: 'Anta',
                              maxFontSize: 30,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FlexibleText(text: budget!.client!.name),
                                GestureDetector(
                                  onTap: () async {
                                    final result = await showDialogStatus(
                                      context,
                                      status: status,
                                    );

                                    status = result ?? status;
                                    approvalDate = status == 'Aprovado' &&
                                            budget!.status == 'Em aberto'
                                        ? DateTime.now()
                                        : null;

                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: FlexibleText(
                                          text: status,
                                          colorText: const Color.fromARGB(
                                              255, 20, 87, 143),
                                          fontWeight: textStyleMediumFontWeight
                                              .fontWeight,
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          status == 'Aprovado' && budget!.status == 'Em aberto',
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: FlexibleText(
                                text: 'D. de Aprovação',
                                fontWeight:
                                    textStyleMediumFontWeight.fontWeight,
                              ),
                            ),
                            Flexible(
                              child: FlexibleText(
                                text:
                                    '${approvalDate?.day.toString().padLeft(2, '0')}/${approvalDate?.month.toString().padLeft(2, '0')}/${approvalDate?.year.toString().padLeft(2, '0')}',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  firstDate: DateTime(2020),
                                  context: context,
                                  lastDate: DateTime.now(),
                                  initialDate: initialDate,
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      approvalDate = date;
                                    });
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.calendar_month,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: products.isNotEmpty,
                      child: DetailWidget(
                        data: products,
                        title: 'Produtos',
                        detailType: DetailType.products,
                      ),
                    ),
                    Visibility(
                      visible: services.isNotEmpty,
                      child: DetailWidget(
                        data: services,
                        title: 'Serviços',
                        detailType: DetailType.service,
                      ),
                    ),
                    Visibility(
                      visible: inconclusiveData.isNotEmpty,
                      child: DetailWidget(
                        data: inconclusiveData,
                        title: 'Produtos ou serviços deletados',
                        detailType: DetailType.inconclusiveData,
                      ),
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
                          {
                            'type': 'Frete',
                            'value': budget!.freight,
                          },
                          {
                            'type': 'Margem de Lucro',
                            'value': budgetController.profitMargin.value,
                          },
                          {
                            'type': 'Desconto',
                            'value': budget!.discount,
                          },
                        ],
                        title: 'Outros detalhes',
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
              label: const FlexibleText(
                text: 'Gerar comprovante',
                colorText: Colors.white,
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
