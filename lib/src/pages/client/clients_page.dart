import 'package:flutter/material.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final List<ClientModel> clients = [
    ClientModel(
      name: 'João',
      contact: ContactModel(cellPhone: '(11) 1111-1111'),
    ),
    ClientModel(
      name: 'Maria',
      contact: ContactModel(cellPhone: '(99) 9999-9999'),
    ),
    ClientModel(
      name: 'Joelmir Rogério Carvalho',
      contact: ContactModel(
        cellPhone: '(99) 9 9999-9999',
        email: "joelmircarvalho@gmail.com",
      ),
      address: AddressModel(
        district: 'Misericódia Infinita',
        streetAddress: 'Rua Casa de Deus',
        numberAddress: '3',
        city: 'Paraíso',
        state: 'Céu',
      ),
    ),
    ClientModel(
      name: 'Valdirene Aparecida Ferreira',
      contact: ContactModel(
        cellPhone: '(00) 0 0000-0000',
        email: "valdireneferreira@outlook.com",
      ),
      address: AddressModel(
        district: 'Misericódia Infinita',
        streetAddress: 'Rua Casa de Deus',
        numberAddress: '3',
        city: 'Paraíso',
        state: 'Céu',
      ),
    ),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    var filteredClients = clients
        .where((client) =>
            client.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Importar contatos',
            icon: const Icon(
              Icons.contacts,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/client-form');
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
                                '/client-form',
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
                                    Navigator.of(context).pushNamed(
                                      '/client-detail',
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
