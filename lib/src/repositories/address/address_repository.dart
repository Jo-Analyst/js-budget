import 'package:js_budget/src/models/address_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class AddressRepository {
  Future<void> saveAddress(AddressModel address, Transaction txn);
}
