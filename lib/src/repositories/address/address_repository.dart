import 'package:sqflite/sqflite.dart';

abstract interface class AddressRepository {
  Future<void> saveAddress(Map<String, dynamic> address, Transaction txn);
}
