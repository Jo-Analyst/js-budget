import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/repositories/address/address_repository_impl.dart';
import 'package:js_budget/src/repositories/client/transform_client_json.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';
import 'package:js_budget/src/repositories/contact/contact_repository_impl.dart';

class ClientRepositoryImpl implements ClientRepository {
  final AddressRepositoryImpl _addressRepository = AddressRepositoryImpl();
  final ContactRepositoryImpl _contactRepository = ContactRepositoryImpl();

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
          'SELECT clients.id, clients.name, clients.document, clients.is_a_legal_entity, address.id AS address_id, address.cep, address.district, address.street_address, address.number_address, address.city, address.state, contacts.id AS contact_id, contacts.cell_phone, contacts.email, contacts.tele_phone FROM clients LEFT JOIN contacts ON contacts.client_id = clients.id LEFT JOIN address ON address.client_id = clients.id ORDER BY clients.name');

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
      final (:infoClient, :contactClient, :addressClient) =
          TransformJson.toJson(client);

      final db = await DataBase.openDatabase();

      await db.transaction((txn) async {
        infoClient.remove('id');
        lastId = await txn.insert('clients', infoClient);

        if (client.contact != null) {
          contactClient!['client_id'] = lastId;

          contactClient.remove('id');
          await _contactRepository.saveContact(contactClient, txn);
        }
        if (client.address != null) {
          addressClient!['client_id'] = lastId;
          addressClient.remove('id');

          await _addressRepository.saveAddress(addressClient, txn);
        }
      });

      return Right(
        ClientModel(
          id: lastId,
          name: client.name,
          document: client.document,
          isALegalEntity: client.isALegalEntity,
          address: client.address != null
              ? AddressModel.fromJson(addressClient!)
              : null,
          contact: client.contact != null
              ? ContactModel.fromJson(contactClient!)
              : null,
        ),
      );
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(ClientModel client) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.update(
            'clients',
            {
              'name': client.name,
              'document': client.document,
              'is_a_legal_entity': client.isALegalEntity
            },
            where: 'id = ?',
            whereArgs: [client.id]);

        if (client.contact != null) {
          await _contactRepository.saveContact({
            'cell_phone': client.contact!.cellPhone,
            'tele_phone': client.contact!.telePhone,
            'email': client.contact!.email,
            'client_id': client.id,
          }, txn);
        }

        if (client.address != null) {
          await _addressRepository.saveAddress({
            'cep': client.address?.cep,
            'district': client.address?.district,
            'street_address': client.address?.streetAddress,
            'number_address': client.address?.numberAddress,
            'city': client.address?.city,
            'state': client.address?.state,
            'client_id': client.id,
          }, txn);
        }
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
