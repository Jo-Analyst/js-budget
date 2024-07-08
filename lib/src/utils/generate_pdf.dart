import 'dart:io';

import 'package:flutter/services.dart';
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
          mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
          children: [
            pdf.Container(
              child: pdf.Image(pdf.MemoryImage(imageData)),
            ),
            pdf.Column(
              crossAxisAlignment: pdf.CrossAxisAlignment.center,
              children: [
                pdf.Text(
                  'LAS Technology',
                  style: const pdf.TextStyle(fontSize: 25),
                ),
                pdf.Text(
                  'Rua Zé da Manga, 124, Centro',
                  style: const pdf.TextStyle(fontSize: 25),
                ),
                pdf.Text(
                  'Felício dos Santos-MG',
                  style: const pdf.TextStyle(fontSize: 25),
                ),
                pdf.Text(
                  'contato@lastechnology.com',
                  style: const pdf.TextStyle(fontSize: 25),
                ),
                pdf.Text(
                  '(88) 8 8888-8888',
                  style: const pdf.TextStyle(fontSize: 25),
                ),
              ],
            )
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
