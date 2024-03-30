import 'package:js_budget/src/models/product_model.dart';

class TransformJson {
  static Map<String, dynamic> toJson(ProductModel product) {
    return {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'unit': product.unit
    };
  }

  static ProductModel fromJson(Map<String, dynamic> product) {
    return ProductModel(
      id: product['id'] as int,
      name: product['name'],
      description: product['description'],
      unit: product['unit'],
    );
  }
}
