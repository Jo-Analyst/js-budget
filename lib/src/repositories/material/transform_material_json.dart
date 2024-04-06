import 'package:js_budget/src/models/material_model.dart';

class TransformMaterialJson {
  static Map<String, dynamic> toJson(MaterialModel material) {
    return {
      'id': material.id,
      'name': material.name,
      'type': material.type,
      'quantity': material.quantity,
      'unit': material.unit,
      'price': material.price,
      'date_of_last_purchase': material.dateOfLastPurchase,
      'observation': material.observation,
      'supplier': material.supplier,
    };
  }

  static MaterialModel fromJson(Map<String, dynamic> material) {
    return MaterialModel(
      id: material['id'] as int,
      name: material['name'],
      type: material['type'],
      unit: material['unit'],
      price: material['price'] as double,
      quantity: (material['quantity'] as num).toInt(),
      dateOfLastPurchase: material['date_of_last_purchase'],
      observation: material['observation'],
      supplier: material['supplier'],
    );
  }
}
