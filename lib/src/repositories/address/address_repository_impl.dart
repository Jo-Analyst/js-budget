import 'package:sqflite/sqflite.dart';

import './address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<void> saveAddress(
      Map<String, dynamic> address, Transaction txn) async {
    print(address);
    int id = address['id'] ?? 0;
    if (id == 0) {
      await txn.insert('address', address);
    } else {
      await txn.update('address', address, where: 'id = ?', whereArgs: [id]);
    }
  }
}
