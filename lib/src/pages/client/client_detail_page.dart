import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/client/widgets/row_data_widget.dart';
import 'package:js_budget/src/pages/menu/widgets/custom_expansion_tile.dart';

class ClientDetailPage extends StatelessWidget {
  const ClientDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente'),
        actions: [
          IconButton(
            tooltip: 'Editar',
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            tooltip: 'Excluir',
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomExpansionTileWidget(
              color: Color.fromARGB(255, 20, 87, 143),
              iconColor: Colors.white,
              titleColor: Colors.white,
              initiallyExpanded: true,
              title: "Dados do cliente",
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowDataWidget(
                      title: "Nome",
                      text: 'Joelmir Rogério Carvalho',
                    ),
                    RowDataWidget(
                      title: "Telefone",
                      text: '(99) 9 9999-9999',
                    ),
                    RowDataWidget(
                      title: "Logradouro",
                      text: 'Rua Antônio Jorge',
                    ),
                    RowDataWidget(
                      title: "Número",
                      text: '750',
                    ),
                    RowDataWidget(
                      title: "Cidade",
                      text: 'Felício dos Santos - MG',
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomExpansionTileWidget(
                  color: Color.fromARGB(255, 20, 87, 143),
                  iconColor: Colors.white,
                  titleColor: Colors.white,
                  initiallyExpanded: true,
                  title: 'últimos pedidos',
                  children: [
                    RowDataWidget(
                      title: "Nome",
                      text: 'Joelmir Rogério Carvalho',
                    ),
                    RowDataWidget(
                      title: "Telefone",
                      text: '(99) 9 9999-9999',
                    ),
                    RowDataWidget(
                      title: "Logradouro",
                      text: 'Rua Antônio Jorge',
                    ),
                    RowDataWidget(
                      title: "Número",
                      text: '750',
                    ),
                    RowDataWidget(
                      title: "Cidade",
                      text: 'Felício dos Santos - MG',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
