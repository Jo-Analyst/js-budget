import 'dart:io';

import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:js_budget/src/utils/generate_pdf.dart';
import 'package:js_budget/src/utils/loading.dart';

class SharePdf extends StatefulWidget {
  const SharePdf({super.key});

  @override
  State<SharePdf> createState() => _SharePdfState();
}

class _SharePdfState extends State<SharePdf> {
  late PDFDocument _doc;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  Future<void> _initPdf() async {
    File? file = await generatePdf();
    final doc = await PDFDocument.fromFile(file!);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading(context, 50),
                const Text(
                  'Carregando PDF...',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          )
        : PDFViewer(
            document: _doc,
            zoomSteps: 200,
            panLimit: 200,
          );
  }
}
