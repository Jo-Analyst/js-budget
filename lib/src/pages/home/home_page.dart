import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/pages/home/widgets/budget_filtering_status_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final profileController = Injector.get<ProfileController>();
  final budgetController = Injector.get<BudgetController>();
  String search = '';

  List<Map<String, dynamic>> budgetStatusFiltering = [
    {'type': 'Tudo', 'isSelected': true},
    {'type': 'Em aberto', 'isSelected': false},
    {'type': 'Aprovado', 'isSelected': false},
    {'type': 'Concluído', 'isSelected': false},
  ];

  void selectStatus(Map<String, dynamic> filter) {
    for (var status in budgetStatusFiltering) {
      status['isSelected'] = false;
    }
    setState(() {
      filter['isSelected'] = true;
    });
  }

  void updateStatus(String status) {
    for (var options in budgetStatusFiltering) {
      options['isSelected'] = false;

      if (options['type'] == status) {
        options['isSelected'] = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadBudgets();
    search = '';
  }

  Future<void> loadBudgets() async {
    if (budgetController.data.isEmpty) {
      await budgetController.findBudgets();
    }

    budgetController.filterData(search);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<BudgetModel> budgets = budgetController.dataFiltered
        .watch(context)
        .where((budget) =>
            budget.status!.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_rectangular.jpeg',
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: FlexibleText(
                            text:
                                'Olá, ${profileController.model.value!.corporateReason}'),
                      ),
                    ],
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Empresa: ',
                            style: textStyleMediumFontWeight,
                          ),
                          TextSpan(
                            text: profileController.model.value!.fantasyName,
                            style: textStyleMediumDefault,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'CNPJ: ',
                            style: textStyleMediumFontWeight,
                          ),
                          TextSpan(
                            text: profileController.model.value!.document,
                            style: const TextStyle(
                                fontFamily: 'Anta', fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 5,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: budgetStatusFiltering
                    .map(
                      (filter) => GestureDetector(
                        onTap: () {
                          selectStatus(filter);
                          search =
                              filter['type'] == 'Tudo' ? '' : filter['type'];
                          budgetController.filterData(search);
                        },
                        child: BudgetFilteringStatusWidget(
                          title: filter['type'],
                          backgroundColor: filter['isSelected']
                              ? Colors.deepPurple
                              : theme.primaryColor,
                          fontWeight: filter['isSelected']
                              ? FontWeight.w500
                              : FontWeight.w600,
                          textColor: filter['isSelected'] ? Colors.white : null,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            budgets.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.insert_chart_rounded,
                            size: 80,
                          ),
                          FlexibleText(text: 'Nenhum orçamento aberto')
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: budgets.length,
                            itemBuilder: (context, index) {
                              final budget = budgets[index];

                              final createdAt = UtilsService.getExtractedDate(
                                  budget.createdAt!);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: GestureDetector(
                                  onTap: () async {
                                    String statusClicked = budget.status!;
                                    budgetController.model.value = budget;
                                    await Navigator.of(context).pushNamed(
                                        '/budge-details',
                                        arguments: budget);

                                    if (statusClicked ==
                                        budgetController.model.value.status) {
                                      return;
                                    }

                                    search =
                                        budgetController.model.value.status!;
                                    budgetController.filterData(search);
                                    updateStatus(search);
                                  },
                                  onLongPress: () async {
                                    final confirm = await showConfirmationDialog(
                                            context,
                                            'Deseja mesmo excluir o orçamento?',
                                            buttonTitle: 'Sim') ??
                                        false;

                                    if (confirm) {
                                      await budgetController.delete(
                                          budget.id, budget.orderId!);
                                    }
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: FlexibleText(
                                                  text: 'Pedido: ',
                                                  fontWeight:
                                                      textStyleMediumFontWeight
                                                          .fontWeight,
                                                ),
                                              ),
                                              FlexibleText(
                                                text: budget.orderId
                                                    .toString()
                                                    .padLeft(5, '0'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: FlexibleText(
                                                  text: budget.client!.name,
                                                  fontWeight:
                                                      textStyleMediumFontWeight
                                                          .fontWeight,
                                                ),
                                              ),
                                              FlexibleText(
                                                text: budget.status!,
                                                colorText: const Color.fromARGB(
                                                    255, 20, 87, 143),
                                                maxFontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: FlexibleText(
                                                  text: UtilsService.dateFormat(
                                                      createdAt),
                                                  fontFamily: 'Anta',
                                                  colorText:
                                                      const Color.fromARGB(
                                                          255, 20, 87, 143),
                                                ),
                                              ),
                                              Flexible(
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: FlexibleText(
                                                    maxFontSize: 20,
                                                    text: UtilsService
                                                        .moneyToCurrency(
                                                            budget.amount!),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Anta',
                                                    colorText:
                                                        const Color.fromARGB(
                                                            255, 20, 87, 143),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Mostra o total do orçamento
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const FlexibleText(
                                  text: 'Total',
                                  maxFontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: FlexibleText(
                                    text: UtilsService.moneyToCurrency(
                                        budgetController.totalBudgets
                                            .watch(context)),
                                    fontFamily: "Anta",
                                    maxFontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    colorText: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
