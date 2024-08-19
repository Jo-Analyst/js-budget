// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:signals/signals.dart';

import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/repositories/product/product_repository.dart';
import 'package:js_budget/src/repositories/product/transform_product_json.dart';

class ProductController with Messages {
  final ProductRepository _productRepository;
  ProductController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final budgetController = Injector.get<BudgetController>();

  final _data = ListSignal<ProductModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase()),
    );

  final model = signal<ProductModel?>(null);

  Future<void> save(ProductModel product) async {
    final result = product.id == 0
        ? await _productRepository.register(product)
        : await _productRepository.update(product);

    switch (result) {
      case Right(value: ProductModel model):
        _data.add(model);
        showSuccess('Produto cadastrado com sucesso');
      case Right():
        if (product.id > 0) {
          _deleteItem(product.id);
        }
        _data.add(product);

        budgetController.changeProductListBudget(product);

        showSuccess('Produto alterado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o produto');
    }
  }

  Future<void> deleteProduct(int id) async {
    final result = await _productRepository.delete(id);
    switch (result) {
      case Right():
        _deleteItem(id);
        budgetController.changeNameProductTheListBudget(id);
        showSuccess('Produto excluido com sucesso');
      case Left():
        showError('Houve um erro ao excluir o produto');
    }
  }

  void _deleteItem(int id) {
    _data.removeWhere((item) => item.id == id);
  }

  Future<void> findProduct() async {
    _data.clear();
    final results = await _productRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> products):
        for (var product in products) {
          _data.add(TransformJson.fromJson(product));
        }

      case Left():
        showError('Houver erro ao buscar o produto');
    }
  }
}
