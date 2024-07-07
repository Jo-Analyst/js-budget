import 'dart:io';

import 'package:flutter/services.dart';
import 'package:js_budget/src/utils/permission_use_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdf;

Future<Uint8List> _getImage() async {
  final ByteData image =
      await rootBundle.load('assets/images/logo_rectangular_80.png');
  return image.buffer.asUint8List();
}

Future<File?> generatePdf() async {
  final doc = pdf.Document();

  Uint8List imageData = await _getImage();

  final dataPDF = [
    pdf.Column(
      children: [
        pdf.Row(
          children: [
            pdf.Container(
              child: pdf.Image(pdf.MemoryImage(imageData)),
            ),
          ],
        ),
      ],
    ),
  ];

  const maxElementsPerPage =
      20; // Defina o número máximo de elementos por página

  for (var i = 0; i < dataPDF.length; i += maxElementsPerPage) {
    final endIndex = (i + maxElementsPerPage < dataPDF.length)
        ? i + maxElementsPerPage
        : dataPDF.length;

    final sublist = dataPDF.sublist(i, endIndex);
    doc.addPage(
      pdf.MultiPage(
        build: (pdf.Context context) => sublist,
      ),
    );
  }

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/balancete.pdf");
  await file.writeAsBytes(await doc.save());

  return file;
}
