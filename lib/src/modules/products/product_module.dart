import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/products/product_controller.dart';
import 'package:js_budget/src/modules/products/product_detail/product_detail_page.dart';
import 'package:js_budget/src/modules/products/product_form/product_form_page.dart';
import 'package:js_budget/src/modules/products/product_page.dart';
import 'package:js_budget/src/repositories/product/product_repository.dart';
import 'package:js_budget/src/repositories/product/product_repository_impl.dart';

class ProductModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<ProductRepository>((i) => ProductRepositoryImpl()),
        Bind.lazySingleton((i) => ProductController(productRepository: i()))
      ];
  @override
  String get moduleRouteName => '/product';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const ProductPage(),
        '/save': (_) => const ProductFormPage(),
        '/details': (_) => const ProductDetailPage()
      };
}
