import 'package:sqflite/sqflite.dart';

import 'address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<int> saveAddress(Map<String, dynamic> address, Transaction txn) async {
    int id = address['id'] ?? 0;
    if (id == 0) {
      address.remove('id');
      id = await txn.insert('address', address);
    } else {
      address.remove('id');
      await txn.update('address', address, where: 'id = ?', whereArgs: [id]);
    }

    return id;
  }
}
