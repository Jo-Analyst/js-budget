import 'package:js_budget/src/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

import './contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  @override
  Future<void> saveContact(ContactModel contact, Transaction txn) {
    throw UnimplementedError();
  }
}
