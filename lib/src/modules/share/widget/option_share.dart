import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class OptionShare extends StatelessWidget {
  const OptionShare({super.key});

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    bool? isPdf;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            isPdf = false;
            nav.pop();
            nav.pushNamed('/share', arguments: isPdf);
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
            nav.pop();
            nav.pushNamed('/share', arguments: isPdf);
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
