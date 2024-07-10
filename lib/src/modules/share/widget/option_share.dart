import 'package:flutter/material.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/permission_use_app.dart';

class OptionShare extends StatelessWidget {
  final List<MaterialItemsBudgetModel> materials;
  const OptionShare({super.key, required this.materials});

  Future<void> _openScreenShare(BuildContext context,
      {bool isPdf = false}) async {
    var nav = Navigator.of(context);
    final isGranted = await isGrantedRequestPermissionStorage();
    if (isGranted) {
      nav.pop();
      nav.pushNamed('/share', arguments: isPdf);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _openScreenShare(context),
          child: const ListTile(
            leading: Icon(
              Icons.image,
              size: 30,
            ),
            title: Text(
              'Imagem',
              style: textStyleSmallDefault,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
            ),
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () => _openScreenShare(context, isPdf: true),
          child: const ListTile(
            leading: Icon(
              Icons.picture_as_pdf,
              size: 30,
            ),
            title: Text(
              'PDF',
              style: textStyleSmallDefault,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
