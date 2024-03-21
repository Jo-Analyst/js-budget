import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';
import 'package:signals/signals.dart';

class ClientController with MessageStateMixin {
  ClientController({
    required ClientRepository clientRepository,
  }) : _clientRepository = clientRepository;

  final _items = ListSignal<ClientModel>([]);
  ListSignal get items => _items;

  final ClientRepository _clientRepository;

  void save(ClientModel client) async {
    final result = await _clientRepository.save(client);

    switch (result) {
      case Right():
        showInfo('Cliente cadastrado com sucesso');
        _items.add(client);
      case Left():
        showError('Houve um erro ao cadastrar o cliente');
    }
  }

  Future<void> findClients() async {
    final results = await _clientRepository.findAll();

    List<ClientModel>? clients;

    switch (results) {
      case Right(value: List<Map<String, dynamic>> clientss):
        clients =
            clientss.map((client) => ClientModel.fromJson(client)).toList();
      case Left():
        showError('Houver erro ao buscar o cliente');

        batch(() => _items.value = clients!);
    }
  }
}
