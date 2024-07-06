import 'package:flutter/material.dart';
import 'package:js_budget/src/modules/share/widget/share_image.dart';
import 'package:js_budget/src/modules/share/widget/share_pdf.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPdf = ModalRoute.of(context)!.settings.arguments! as bool;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orçamento',
          style: textStyleSmallDefault,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: 30,
            ),
          ),
        ],
      ),
      body: isPdf ? const SharePdf() : const ShareImage(),
    );
  }
}
