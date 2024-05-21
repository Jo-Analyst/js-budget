// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class StatusWidget extends StatefulWidget {
  final String lastStatus;
  final int budgetId;
  const StatusWidget({
    Key? key,
    required this.lastStatus,
    required this.budgetId,
  }) : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  final budgetController = Injector.get<BudgetController>();
  late String status;
  List<Map<String, dynamic>> situations = [
    {'status': 'Em aberto', 'isChecked': false},
    {'status': 'Aprovado', 'isChecked': false},
    {'status': 'Concluído', 'isChecked': false},
    {'status': 'Cancelado', 'isChecked': false},
  ];

  void selectStatus(Map<String, dynamic> situation) {
    for (var st in situations) {
      st['isChecked'] = false;
    }
    setState(() {
      situation['isChecked'] = true;
      status = situation['status'];
    });
  }

  void selectLastStatus(String status) {
    for (var situation in situations) {
      String status = situation['status'];
      if (status == widget.lastStatus) {
        situation['isChecked'] = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    status = widget.lastStatus;
    selectLastStatus(widget.lastStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Status do orçamento',
              style: textStyleSmallFontWeight,
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: situations.map(
                (st) {
                  bool isChecked = st['isChecked'];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListTile(
                          onTap: () => selectStatus(st),
                          leading: Icon(
                            isChecked ? Icons.check : null,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          title: Text(
                            st['status'],
                            style: isChecked
                                ? TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight:
                                        textStyleSmallFontWeight.fontWeight,
                                    fontSize: textStyleSmallFontWeight.fontSize)
                                : textStyleSmallDefault,
                          ),
                        ),
                      ),
                      const Divider()
                    ],
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                var nav = Navigator.of(context);
                final isError = await budgetController.changeStatus(
                    status, widget.budgetId);
                nav.pop(!isError ? status : widget.lastStatus);
              },
              child: Text(
                'Alterar Status',
                style: TextStyle(
                    fontSize: textStyleSmallDefault.fontSize,
                    fontFamily: textStyleSmallDefault.fontFamily),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
