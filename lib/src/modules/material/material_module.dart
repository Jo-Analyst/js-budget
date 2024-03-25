import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/material/furniture_materials_page.dart';
import 'package:js_budget/src/modules/material/material_controller.dart';
import 'package:js_budget/src/modules/material/material_detail/material_details_page.dart';
import 'package:js_budget/src/modules/material/material_form/material_form_page.dart';
import 'package:js_budget/src/repositories/material/material_repository.dart';
import 'package:js_budget/src/repositories/material/material_repository_impl.dart';

class MaterialModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<MaterialRepository>((i) => MaterialRepositoryImpl()),
        Bind.lazySingleton((i) => MaterialController(materialRepository: i()))
      ];

  @override
  String get moduleRouteName => '/material';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const FurnitureMaterials(),
        '/save': (_) => const MaterialFormPage(),
        '/details': (_) => const MaterialDetailsPage(),
      };
}
