import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/client/client_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/permission_use_app.dart';
import 'package:signals/signals_flutter.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final controller = Injector.get<ClientController>();
  String search = '';

  @override
  void initState() {
    super.initState();

    loadClients();
  }

  Future<void> loadClients() async {
    await controller.findClients();
  }

  @override
  Widget build(BuildContext context) {
    bool comesFromTheOrder =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    var filteredClients = controller.data
        .watch(context)
        .where((client) =>
            client.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
    var nav = Navigator.of(context);

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () async {
              if (!await isContactsPermissionGranted()) return;

              nav.pushNamed('/client/contact-phone');
            },
            tooltip: 'Importar contatos',
            icon: const Icon(
              Icons.contacts,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {
              nav.pushNamed('/client/form');
            },
            tooltip: "Novo Cliente",
            icon: const Icon(
              Icons.person_add_alt_1,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar cliente',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredClients.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_search_sharp,
                          size: 100,
                          color: theme.colorScheme.primary.withOpacity(.7),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Nenhum cliente encontrado',
                          textAlign: TextAlign.center,
                          style: textStyleMediumDefault,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/client/form',
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const FlexibleText(
                              text: 'Adicionar cliente',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    children: filteredClients
                        .map((client) => Column(
                              children: [
                                ListTile(
                                  splashColor: Colors.transparent,
                                  onTap: comesFromTheOrder
                                      ? () {
                                          nav.pop(client);
                                        }
                                      : () async {
                                          await nav.pushNamed(
                                            '/client/details',
                                            arguments: client,
                                          );

                                          controller.model.value = null;
                                        },
                                  leading: const Icon(Icons.person),
                                  title: FlexibleText(
                                    text: client.name,
                                  ),
                                  subtitle: client.contact?.cellPhone != null &&
                                          client.contact!.cellPhone
                                              .toString()
                                              .isNotEmpty
                                      ? FlexibleText(
                                          text: client.contact!.cellPhone,
                                        )
                                      : null,
                                  trailing: comesFromTheOrder
                                      ? IconButton(
                                          onPressed: () async {
                                            controller.model.value = client;
                                            await nav.pushNamed('/client/form',
                                                arguments: comesFromTheOrder);

                                            controller.model.value = null;
                                          },
                                          icon: const Icon(Icons.edit))
                                      : const Icon(
                                          Icons.keyboard_arrow_right,
                                        ),
                                ),
                                const Divider(),
                              ],
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
