import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/material/furniture_materials_page.dart';
import 'package:js_budget/src/modules/material/material_detail/material_details_page.dart';
import 'package:js_budget/src/modules/material/material_form/material_form_page.dart';

class MaterialModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/material';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const FurnitureMaterials(),
        '/form': (_) => const MaterialFormPage(),
        '/details': (_) => const MaterialDetailsPage(),
      };
}
