import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/repositories/client/transform_client_json.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';
import 'package:signals/signals.dart';

class ClientController with Messages {
  ClientController({
    required ClientRepository clientRepository,
  }) : _clientRepository = clientRepository;

  final _data = ListSignal<ClientModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase()),
    );

  final model = signal<ClientModel?>(null);

  final ClientRepository _clientRepository;

  Future<void> _register(
      List<ClientModel> clients, bool isImportedFromContacts) async {
    List<Either<RespositoryException, ClientModel>> results = [];
    bool thereWasAnError = false;

    for (var client in clients) {
      results.add(await _clientRepository.register(client));
    }

    for (var result in results) {
      switch (result) {
        case Right(value: ClientModel model):
          _data.add(model);
        case Left():
          thereWasAnError = true;
      }
    }

    !thereWasAnError
        ? showSuccess('Cliente cadastrado com sucesso')
        : showError(isImportedFromContacts
            ? 'Houve um erro ao cadastrar os dados do(s) cliente(s) importado(s) do telefone'
            : 'Houve um erro ao cadastrar o cliente');
  }

  Future<void> _update(ClientModel client) async {
    final result = await _clientRepository.update(client);

    switch (result) {
      case Right():
        if (client.id > 0) {
          _deleteItem(client.id);
        }
        _data.add(client);
        showSuccess('Cliente alterado com sucesso');
      case Left():
        showError('Houve um erro ao atualizar o cliente');
    }
  }

  Future<void> save(List<ClientModel> client,
      {bool isImportedFromContacts = false}) async {
    if (client.length == 1 && client.first.id > 0) {
      await _update(client.first);

      return;
    }

    await _register(client, isImportedFromContacts);
  }

  Future<void> deleteClient(int id) async {
    final result = await _clientRepository.delete(id);
    switch (result) {
      case Right():
        _deleteItem(id);
        showSuccess('Cliente excluido com sucesso');
      case Left():
        showError('Houve um erro ao excluir o cliente');
    }
  }

  void _deleteItem(int id) {
    _data.removeWhere((item) => item.id == id);
  }

  Future<void> findClients() async {
    _data.clear();
    final results = await _clientRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> clients):
        for (var client in clients) {
          _data.add(TransformClientJson.fromJson(client));
        }

      case Left():
        showError('Houver erro ao buscar os clientes');
    }
  }
}
