// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class PaymentMethodsWidget extends StatefulWidget {
  final String lastStatus;
  const PaymentMethodsWidget({
    Key? key,
    required this.lastStatus,
  }) : super(key: key);

  @override
  State<PaymentMethodsWidget> createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  late String methods;
  List<Map<String, dynamic>> paymentsMethods = [
    {'methods': 'Nenhum', 'isChecked': false},
    {'methods': 'Dinheiro', 'isChecked': false},
    {'methods': 'PIX', 'isChecked': false},
    {'methods': 'Crédito', 'isChecked': false},
    {'methods': 'Débito', 'isChecked': false},
  ];

  void selectMethod(Map<String, dynamic> method) {
    for (var st in paymentsMethods) {
      st['isChecked'] = false;
    }
    setState(() {
      method['isChecked'] = true;
      methods = method['methods'];
    });
  }

  void selectLastStatus() {
    for (var paymentsMethod in paymentsMethods) {
      String methods = paymentsMethod['methods'];
      if (methods == widget.lastStatus) {
        paymentsMethod['isChecked'] = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    methods = widget.lastStatus;
    selectLastStatus();
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
              'Meios de Pagamentos',
              style: textStyleSmallFontWeight,
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: paymentsMethods.map(
                (st) {
                  bool isChecked = st['isChecked'];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListTile(
                          splashColor: Colors.transparent,
                          onTap: () => selectMethod(st),
                          leading: Icon(
                            isChecked ? Icons.check : null,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          title: Text(
                            st['methods'],
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

                nav.pop(methods);
              },
              child: Text(
                'Alterar Meio de Pagamento',
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
