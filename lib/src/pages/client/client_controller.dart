import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/repositories/client/client_repository_impl.dart';

class ClientController with Messages {
  void save(ClientModel client) async {
    final result = await ClientRepositoryImpl().save(client);

    switch (result) {
      case Right():
        showSuccess('Cliente cadastrado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o cliente');
    }
  }
}
