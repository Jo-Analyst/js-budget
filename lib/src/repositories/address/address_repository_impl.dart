import 'package:js_budget/src/models/address_model.dart';
import 'package:sqflite/sqflite.dart';

import './address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<void> saveAddress(AddressModel address, Transaction txn) {
    throw UnimplementedError();
  }
}
