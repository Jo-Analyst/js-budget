import 'package:sqflite/sqflite.dart';

import './contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  @override
  Future<void> saveContact(
      Map<String, dynamic> contact, Transaction txn) async {
    print(contact);
    int id = contact['id'] ?? 0;
    if (id == 0) {
      await txn.insert('contacts', contact);
    } else {
      await txn.update('contacts', contact, where: 'id = ?', whereArgs: [id]);
    }
  }
}
