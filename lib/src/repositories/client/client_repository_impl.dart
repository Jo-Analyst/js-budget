import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  @override
  Future<void> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<ClientModel> findAll() {
    throw UnimplementedError();
  }

  @override
  Future<ClientModel> findClient(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(ClientModel client) async {
    final db = await DataBase.openDatabase();
    await db.transaction((txn) async {
      if (client.id == 0) {
        int lastId = await txn.insert('clients', {'name': client.name});
        if (client.contact != null) {
          await txn.insert('contacts', {
            'cell_phone': client.contact!.cellPhone,
            'tele_phone': client.contact?.telePhone ?? '',
            'email': client.contact?.email ?? '',
            'client_id': lastId
          });
        }
      }
    });
  }
}
