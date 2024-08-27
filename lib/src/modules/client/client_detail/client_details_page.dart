import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/modules/client/client_controller.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/pages/widgets/address_widget.dart';
import 'package:js_budget/src/pages/widgets/list_view_tile.dart';
import 'package:js_budget/src/pages/widgets/contact_widget.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';

class ClientDetailsPage extends StatelessWidget {
  const ClientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<ClientController>();
    final client = ModalRoute.of(context)!.settings.arguments as ClientModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do cliente'),
        actions: [
          IconButton(
            tooltip: 'Editar',
            onPressed: () {
              controller.model.value = client;
              Navigator.of(context).pushNamed('/client/form');
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            tooltip: 'Excluir',
            onPressed: () async {
              var nav = Navigator.of(context);
              bool confirm = await showConfirmationDialog(
                    context,
                    'Ao excluir o cliente, será excluído todas as movimentação realizadas no nome do cliente.\nRealmente você deseja mesmo excluir os dados de "${client.name}" de sua lista de cliente?',
                    buttonTitle: 'Sim',
                  ) ??
                  false;

              if (confirm) {
                controller.deleteClient(client.id);
                nav.pop();
              }
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: ListViewTile(
                      color: Colors.transparent,
                      textColor: Colors.black,
                      title: 'Dados do cliente',
                      children: [
                        CustomListTileIcon(
                          title: client.name,
                          leading: const Icon(
                            Icons.person,
                            size: 25,
                          ),
                        ),
                        Visibility(
                          visible: client.isALegalEntity == 1 &&
                              client.document!.isNotEmpty,
                          child: CustomListTileIcon(
                            title: client.document ?? '',
                            leading: const Icon(
                              Icons.description,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),

                  // contatos
                  ContactWidget(contact: client.contact),
                  const SizedBox(height: 5),

                  // Endereço
                  AddressWidget(address: client.address),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
