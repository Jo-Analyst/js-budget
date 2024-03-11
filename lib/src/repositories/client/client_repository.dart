import 'package:js_budget/src/models/client_model.dart';

abstract interface class ClientRepository {
  Future<void> save(ClientModel client);
  Future<void> delete(int id);
  Future<ClientModel> findAll();
  Future<ClientModel> findClient(int id);
}
