import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/models/profile_model.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:js_budget/src/repositories/profile/transform_profile_json.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final profiles = await db.rawQuery(
          'SELECT profiles.id, profiles.fantasy_name, profile.corporate_reason, profiles.document, address.id AS address_id, address.cep, address.district, address.street_address, address.number_address, address.city, address.state, contacts.id AS contact_id, contacts.cell_phone, contacts.email, contacts.tele_phone FROM profiles INNER JOIN contacts ON contacts.profile_id = profiles.id INNER JOIN address ON address.profile_id = profiles.id ORDER BY profiles.name');

      return Right(profiles);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, ProfileModel>> register(
      ProfileModel profile) async {
    try {
      int lastId = 0;
      final (:infoProfile, :contactProfile, :addressProfile) =
          TransformJson.toJson(profile);

      final db = await DataBase.openDatabase();

      await db.transaction((txn) async {
        infoProfile.remove('id');
        lastId = await txn.insert('profiles', infoProfile);

        contactProfile!['profile_id'] = lastId;
        contactProfile.remove('id');
        await txn.insert('contacts', contactProfile);
        addressProfile!['profile_id'] = lastId;
        addressProfile.remove('id');
        await txn.insert('address', addressProfile);
      });

      return Right(
        ProfileModel(
          corporateReason: profile.corporateReason,
          id: lastId,
          fantasyName: profile.fantasyName,
          document: profile.document,
          address: AddressModel.fromJson(addressProfile!),
          contact: ContactModel.fromJson(contactProfile!),
        ),
      );
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(
      ProfileModel profile) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.update(
            'profiles',
            {
              'fantasy_name': profile.fantasyName,
              'corporate_reason': profile.corporateReason,
              'document': profile.document,
            },
            where: 'id = ?',
            whereArgs: [profile.id]);

        await txn.update(
            'contacts',
            {
              'cell_phone': profile.contact.cellPhone,
              'tele_phone': profile.contact.telePhone,
              'email': profile.contact.email,
            },
            where: 'id = ?',
            whereArgs: [profile.contact.id]);

        await txn.update(
            'address',
            {
              'cep': profile.address.cep,
              'district': profile.address.district,
              'street_address': profile.address.streetAddress,
              'number_address': profile.address.numberAddress,
              'city': profile.address.city,
              'state': profile.address.state,
            },
            where: 'id = ?',
            whereArgs: [profile.address.id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
