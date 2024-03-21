import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  @override
  Future<void> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final clients = await db.rawQuery(
          'SELECT clients.id, clients.name, address.id AS address_id, address.district, address.street_address, address.number_address, address.city, address.state, contacts.id AS contact_id, contacts.cell_phone, contacts.email, contacts.tele_phone FROM clients LEFT JOIN contacts ON contacts.client_id = clients.id LEFT JOIN address ON address.client_id = clients.id');
      return Right(clients);
    } catch (e) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<ClientModel> findClient(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<RespositoryException, Unit>> save(ClientModel client) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        if (client.id == 0) {
          int lastId = await txn.insert('clients', {'name': client.name});
          if (client.contact != null) {
            if (client.contact!.id == 0) {
              await txn.insert('contacts', {
                'cell_phone': client.contact!.cellPhone,
                'tele_phone': client.contact?.telePhone ?? '',
                'email': client.contact?.email ?? '',
                'client_id': lastId
              });
            }
          }
          if (client.address != null) {
            if (client.address!.id == 0) {
              await txn.insert('address', {
                'cep': client.address?.cep ?? '',
                'district': client.address!.district,
                'street_address': client.address!.streetAddress,
                'number_address': client.address!.numberAddress,
                'city': client.address!.city,
                'state': client.address!.state,
                'client_id': lastId
              });
            }
          }
        }
      });

      return Right(unit);
    } catch (e) {
      return Left(RespositoryException());
    }
  }
}
