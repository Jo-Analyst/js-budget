import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/modules/client/client_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/permission_use_app.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  List<ClientModel> clients = [];
  final controller = Injector.get<ClientController>();
  String search = '';

  @override
  void initState() {
    super.initState();

    controller.findClients();
    clients = controller.items as List<ClientModel>;
  }

  @override
  Widget build(BuildContext context) {
    var filteredClients = clients
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
              nav.pushNamed('/client/register');
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
                          style: textStyleSmallDefault,
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
                                '/client/register',
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Adicionar cliente',
                              style: textStyleSmallDefault,
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
                                  onTap: () {
                                    nav.pushNamed(
                                      '/client/details',
                                      arguments: client,
                                    );
                                  },
                                  leading: const Icon(Icons.person),
                                  title: Text(
                                    client.name,
                                    style: textStyleSmallDefault,
                                  ),
                                  subtitle: Text(
                                    client.contact?.cellPhone ?? '',
                                    style: TextStyle(
                                      fontSize: textStyleSmallDefault.fontSize,
                                    ),
                                  ),
                                  trailing: const Icon(
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
