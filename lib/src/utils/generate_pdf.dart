import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> _getImage() async {
  final ByteData image =
      await rootBundle.load('assets/images/logo_rectangular_80.png');
  return image.buffer.asUint8List();
}

Future<File?> generatePdf() async {
  final profile = Injector.get<ProfileController>().model.value;
  final budget = Injector.get<BudgetController>().model.value;
  final doc = pw.Document();
  double totalService = 0, totalProduct = 0;

  Uint8List imageData = await _getImage();
  final (year, month, day, hours, minutes) =
      UtilsService.extractDate(budget.createdAt!);

  final pdf = [
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Container(
              child: pw.Image(pw.MemoryImage(imageData)),
            ),
            pw.SizedBox(width: 25),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  profile!.corporateReason.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${profile.address.streetAddress}, ${profile.address.numberAddress}, ${profile.address.district}',
                  style: const pw.TextStyle(fontSize: 20),
                ),
                pw.Text(
                  '${profile.address.city} - ${profile.address.state}',
                  style: const pw.TextStyle(fontSize: 20),
                ),
                pw.Text(
                  profile.contact.email,
                  style: const pw.TextStyle(fontSize: 20),
                ),
                pw.Text(
                  profile.contact.cellPhone,
                  style: const pw.TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Ordem de Serviço 00001',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Data: ${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year, ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}Hrs',
                style: const pw.TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        // Dados do cliente
        pw.Container(
          margin: const pw.EdgeInsets.symmetric(vertical: 25),
          padding: const pw.EdgeInsets.symmetric(vertical: 20),
          decoration: const pw.BoxDecoration(
            border: pw.Border.symmetric(
              horizontal: pw.BorderSide(style: pw.BorderStyle.dashed, width: 2),
            ),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Cliente: ${budget.client!.name}',
                    style: const pw.TextStyle(fontSize: 18),
                  ),
                ],
              ),

              // contatos do cliente
              if (budget.client?.contact != null)
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Contatos:',
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Cel: ${budget.client?.contact?.cellPhone ?? ''}',
                              style: const pw.TextStyle(fontSize: 18),
                            ),
                            pw.Text(
                              'Tel: ${budget.client?.contact?.telePhone ?? ''}',
                              style: const pw.TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      pw.Text(
                        'E-mail: ${budget.client?.contact?.email ?? ''}',
                        style: const pw.TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),

              // Endereço do cliente
              if (budget.client?.address != null)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Endereço: ',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Endereço: ${budget.client?.address?.streetAddress}, ${budget.client?.address?.numberAddress}',
                            style: const pw.TextStyle(fontSize: 18),
                          ),
                          pw.Text(
                            'Bairro: ${budget.client?.address?.district}',
                            style: const pw.TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Localidade: ${budget.client?.address?.city} - ${budget.client?.address?.state}',
                          style: const pw.TextStyle(fontSize: 18),
                        ),
                        pw.Text(
                          'CEP: ${budget.client?.address?.cep}',
                          style: const pw.TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),

        pw.SizedBox(height: 16),

        pw.TableHelper.fromTextArray(
          headerStyle: const pw.TextStyle(fontSize: 18),
          cellStyle: const pw.TextStyle(fontSize: 18),
          border: const pw.TableBorder(
            horizontalInside: pw.BorderSide(style: pw.BorderStyle.dashed),
          ),
          cellAlignment: pw.Alignment.center,
          data: <List<String>>[
            <String>[
              'Descrição',
              'Quantidade',
              'VL Unitário',
              'VL Total',
            ],
            ...budget.itemsBudget!.map(
              (item) {
                double unitaryValue =
                    double.parse(item.unitaryValue.toStringAsFixed(2));
                double total = unitaryValue * item.quantity;

                if (item.product != null) {
                  totalProduct += total;
                } else {
                  totalService += total;
                }

                return [
                  item.product?.name ?? item.service!.description,
                  item.quantity.toString(),
                  UtilsService.moneyToCurrency(unitaryValue),
                  UtilsService.moneyToCurrency(total)
                ];
              },
            )
          ],
        ),
        pw.Container(
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(style: pw.BorderStyle.solid, width: 1),
            ),
          ),
          margin: const pw.EdgeInsets.only(top: 10),
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          child: pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Total de Produtos: ',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    UtilsService.moneyToCurrency(totalProduct),
                    style: const pw.TextStyle(fontSize: 18),
                  )
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Total de Serviços: ',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    UtilsService.moneyToCurrency(totalService),
                    style: const pw.TextStyle(fontSize: 18),
                  )
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Frete: ',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    UtilsService.moneyToCurrency(budget.freight ?? 0),
                    style: const pw.TextStyle(fontSize: 18),
                  )
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Desconto: ',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    UtilsService.moneyToCurrency(0),
                    style: const pw.TextStyle(fontSize: 18),
                  )
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Valor Total: ',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    UtilsService.moneyToCurrency(budget.valueTotal!),
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ];

  const maxElementsPerPage =
      20; // Defina o número máximo de elementos por página

  for (var i = 0; i < pdf.length; i += maxElementsPerPage) {
    final endIndex = (i + maxElementsPerPage < pdf.length)
        ? i + maxElementsPerPage
        : pdf.length;

    final sublist = pdf.sublist(i, endIndex);
    doc.addPage(
      pw.MultiPage(
        build: (pw.Context context) => sublist,
      ),
    );
  }

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/balancete.pdf");
  await file.writeAsBytes(await doc.save());

  return file;
}
