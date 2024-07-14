import 'package:flutter/material.dart';
import 'package:js_budget/src/modules/share/widget/image_generate.dart';
import 'package:js_budget/src/modules/share/widget/pdf_generate.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/permission_use_app.dart';

class OptionShare extends StatelessWidget {
  const OptionShare({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPdf = false;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(isPdf);
          },
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
          onTap: () {
            isPdf = true;
            Navigator.of(context).pop(isPdf);
          },
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