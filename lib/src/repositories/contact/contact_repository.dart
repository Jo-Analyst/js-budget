import 'package:js_budget/src/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ContactRepository {
  Future<void> saveContact(ContactModel contact, Transaction txn);
}
