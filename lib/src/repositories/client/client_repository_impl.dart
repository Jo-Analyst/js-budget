import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  @override
  Future<Either<RespositoryException, Unit>> delete(int id) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.delete('clients', where: 'id = ?', whereArgs: [id]);
        await txn.delete('contacts', where: 'client_id = ?', whereArgs: [id]);
        await txn.delete('address', where: 'client_id = ?', whereArgs: [id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final clients = await db.rawQuery(
          'SELECT clients.id, clients.name, address.id AS address_id, address.cep, address.district, address.street_address, address.number_address, address.city, address.state, contacts.id AS contact_id, contacts.cell_phone, contacts.email, contacts.tele_phone FROM clients LEFT JOIN contacts ON contacts.client_id = clients.id LEFT JOIN address ON address.client_id = clients.id');
      return Right(clients);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, ClientModel>> register(
      ClientModel client) async {
    try {
      int lastId = 0;
      Map<String, dynamic> infoClient = {'name': client.name};
      Map<String, dynamic> contactClient = {
        'cell_phone': client.contact?.cellPhone ?? '',
        'tele_phone': client.contact?.telePhone ?? '',
        'email': client.contact?.email ?? '',
        'client_id': lastId,
      };
      Map<String, dynamic> addressClient = {
        'cep': client.address?.cep,
        'district': client.address?.district,
        'street_address': client.address?.streetAddress,
        'number_address': client.address?.numberAddress,
        'city': client.address?.city,
        'state': client.address?.state,
        'client_id': lastId,
      };

      final db = await DataBase.openDatabase();

      await db.transaction((txn) async {
        lastId = await txn.insert('clients', infoClient);
        infoClient['id'] = lastId;

        if (client.contact != null) {
          await txn.insert('contacts', contactClient);
        }
        if (client.address != null) {
          await txn.insert('address', addressClient);
        }
      });

      return Right(
        ClientModel(
          id: lastId,
          name: client.name,
          address: client.address != null
              ? AddressModel.fromJson(addressClient)
              : null,
          contact: client.contact != null
              ? ContactModel.fromJson(contactClient)
              : null,
        ),
      );
    } catch (e) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(ClientModel client) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.update('clients', {'name': client.name},
            where: 'id = ?', whereArgs: [client.id]);

        if (client.contact != null) {
          await txn.update(
              'contacts',
              {
                'cell_phone': client.contact!.cellPhone,
                'tele_phone': client.contact?.telePhone ?? '',
                'email': client.contact?.email ?? '',
              },
              where: 'id = ?',
              whereArgs: [client.contact!.id]);
        }

        if (client.address != null) {
          await txn.update(
              'address',
              {
                'cep': client.address?.cep,
                'district': client.address?.district,
                'street_address': client.address?.streetAddress,
                'number_address': client.address?.numberAddress,
                'city': client.address?.city,
                'state': client.address?.state,
              },
              where: 'id = ?',
              whereArgs: [client.address!.id]);
        }
      });

      return Right(unit);
    } catch (e) {
      return Left(RespositoryException());
    }
  }
}
