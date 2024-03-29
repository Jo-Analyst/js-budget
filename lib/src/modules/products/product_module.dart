import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/products/product_form/product_form_page.dart';
import 'package:js_budget/src/modules/products/product_page.dart';

class ProductModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/product';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const ProductPage(),
        '/save': (_) => const ProductFormPage(),
      };
}
