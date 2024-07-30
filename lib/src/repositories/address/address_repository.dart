import 'package:sqflite/sqflite.dart';

abstract interface class AddressRepository {
  Future<int> saveAddress(Map<String, dynamic> address, Transaction txn);
}
