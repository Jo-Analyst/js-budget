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
//       cpf: '',
//     ),
//     ClientModel(
//       name: 'Maria',
//       phone: '987654321',
//       cpf: '',
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

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final List<ClientModel> clients = [
    ClientModel(
      name: 'João',
      phone: '123456789',
      cpf: '',
    ),
    ClientModel(
      name: 'Maria',
      phone: '987654321',
      cpf: '',
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
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
                ? const Center(child: Text('Nenhum cliente encontrado'))
                : ListView(
                    children: filteredClients
                        .map((client) => ListTile(
                              title: Text(client.name),
                              subtitle: Text(client.phone ?? ''),
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
