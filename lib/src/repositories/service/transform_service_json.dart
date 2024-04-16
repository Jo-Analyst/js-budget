import 'package:js_budget/src/models/service_model.dart';

class TransformJson {
  static Map<String, dynamic> toJson(ServiceModel service) {
    return {
      'id': service.id,
      'description': service.description,
      'price': service.price
    };
  }

  static ServiceModel fromJson(Map<String, dynamic> service) {
    return ServiceModel(
      id: service['id'] as int,
      description: service['description'],
      price: service['price'],
    );
  }
}
