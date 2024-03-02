// import 'package:flutter/material.dart';
// import 'package:js_budget/src/models/client_model.dart';

// class ClientPage extends StatefulWidget {
//   const ClientPage({super.key});

//   @override
//   State<ClientPage> createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   final List<ClientModel> clients = [
//     ClientModel(
//       name: 'João',
//       phone: '123456789',
//
//     ),
//     ClientModel(
//       name: 'Maria',
//       phone: '987654321',
//
//     ),
//     // Adicione mais clientes aqui
//   ];

//   String search = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Clientes'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               onChanged: (value) {
//                 setState(() {
//                   search = value;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: 'Buscar cliente',
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: clients
//                   .where((client) =>
//                       client.name.toLowerCase().contains(search.toLowerCase()))
//                   .map((client) => ListTile(
//                         title: Text(client.name),
//                         subtitle: Text(client.phone ?? ''),
//                       ))
//                   .toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final List<ClientModel> clients = [
    ClientModel(
      name: 'João',
      phone: '123456789',
    ),
    ClientModel(
      name: 'Maria',
      phone: '987654321',
    ),
    ClientModel(
      name: 'Joelmir Rogério Carvalho',
      phone: '(99) 99999-9999',
    ),
    ClientModel(
      name: 'Valdirene Aparecida Ferreira',
      phone: '(99) 99999-9999',
    ),
    ClientModel(
      name: 'Joelmir Rogério Carvalho',
      phone: '(99) 99999-9999',
    ),
    ClientModel(
      name: 'Valdirene Aparecida Ferreira',
      phone: '(99) 99999-9999',
    ),
    ClientModel(
      name: 'Joelmir Rogério Carvalho',
      phone: '(99) 99999-9999',
    ),
    ClientModel(
      name: 'Valdirene Aparecida Ferreira',
      phone: '(99) 99999-9999',
    ),
    // Adicione mais clientes aqui
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
            icon: const Icon(
              Icons.contacts_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/register-client');
            },
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
                            onPressed: () {},
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
                                  leading: const Icon(Icons.person),
                                  title: Text(client.name),
                                  subtitle: Text(client.phone ?? ''),
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
