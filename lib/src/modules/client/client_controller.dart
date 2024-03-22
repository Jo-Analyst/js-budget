import 'package:flutter/material.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';
import 'package:signals/signals.dart';

class ClientController with Messages {
  ClientController({
    required ClientRepository clientRepository,
  }) : _clientRepository = clientRepository;

  final _items = ListSignal<ClientModel>([]);
  ListSignal get items => _items;

  final model = signal<ClientModel?>(null);

  final ClientRepository _clientRepository;

  void save(ClientModel client, BuildContext context) async {
    final result = client.id == 0
        ? await _clientRepository.save(client)
        : await _clientRepository.update(client);

    switch (result) {
      case Right():
        if (client.id > 0) {
          _deleteItem(client);
        }

        _items.add(client);
        showSuccess('Cliente cadastrado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o cliente');
    }
  }

  void _deleteItem(ClientModel client) {
    _items.removeWhere((item) => item.id == client.id);
  }

  Future<void> findClients(BuildContext context) async {
    _items.clear();
    final results = await _clientRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> clients):
        for (var client in clients) {
          _items.add(
            ClientModel(
              id: client['id'],
              name: client['name'],
              address: addressExists(client)
                  ? AddressModel(
                      id: client['address_id'],
                      cep: client['cep'],
                      district: client['district'],
                      streetAddress: client['street_address'],
                      numberAddress: client['number_address'],
                      city: client['city'],
                      state: client['state'],
                    )
                  : null,
              contact: contactExists(client)
                  ? ContactModel(
                      id: client['contact_id'],
                      cellPhone: client['cell_phone'],
                      email: client['email'],
                      telePhone: client['tele_phone'],
                    )
                  : null,
            ),
          );
        }

      // _items.addAll(
      //     listClient.map((client) => ClientModel.fromJson(client)).toList(),);
      case Left():
        showError('Houver erro ao buscar o cliente');
    }
  }

  bool contactExists(Map<String, dynamic> client) {
    return client['contact_id'] != null ||
        client['cell_phone'] != null ||
        client['email'] != null ||
        client['tele_phone'] != null;
  }

  bool addressExists(Map<String, dynamic> client) {
    return client['address_id'] != null ||
        client['cep'] != null ||
        client['district'] != null ||
        client['street_address'] != null ||
        client['number_address'] != null ||
        client['city'] != null ||
        client['state'] != null;
  }
}
