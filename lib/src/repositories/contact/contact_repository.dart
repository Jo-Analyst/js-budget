import 'package:sqflite/sqflite.dart';

abstract interface class ContactRepository {
  Future<int> saveContact(Map<String, dynamic> contact, Transaction txn);
}
