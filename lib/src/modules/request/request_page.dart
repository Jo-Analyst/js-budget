import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final request = [{}, {}, {}, {}, {}, {}, {}, {}, {}];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: request
                .map((e) => Card(
                      child: Column(
                        children: [
                          const Text(
                            'Bennedito Ferreira',
                            style: textStyleSmallFontWeight,
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Text('001',
                                style: textStyleSmallFontWeight),
                            title: const Text('28/03/2014',
                                style: textStyleSmallDefault),
                            subtitle: const Text('Guarda Roupa',
                                style: textStyleSmallDefault),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  UtilsService.moneyToCurrency(20),
                                  style: TextStyle(
                                    fontSize: textStyleSmallDefault.fontSize,
                                    fontFamily: 'Anta',
                                  ),
                                ),
                                Text(
                                  'Aguardando...',
                                  style: TextStyle(
                                    fontSize: textStyleSmallDefault.fontSize,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showModal(context, const NewTransaction());
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
