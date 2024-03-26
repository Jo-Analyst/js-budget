import 'package:sqflite/sqflite.dart';

abstract interface class ContactRepository {
  Future<void> saveContact(Map<String, dynamic> contact, Transaction txn);
}
