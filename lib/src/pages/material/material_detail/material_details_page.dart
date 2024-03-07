import 'package:flutter/material.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/pages/material/material_form_page.dart';
import 'package:js_budget/src/pages/widgets/form_details.dart';
import 'package:js_budget/src/pages/widgets/info_widget.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class MaterialDetailsPage extends StatelessWidget {
  const MaterialDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final material =
        ModalRoute.of(context)!.settings.arguments as MaterialModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do material'),
        actions: [
          IconButton(
            tooltip: 'Editar',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MaterialFormPage(
                    material: material,
                    isEdition: true,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            tooltip: 'Excluir',
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormDetails(
              title: 'Dados da material',
              children: [
                InfoWidget(
                  title: 'Material',
                  text: material.name,
                ),
                InfoWidget(
                  title: 'Tipo de material',
                  text: material.type ?? '',
                  isNull: material.type == null,
                  isEmpty: material.type?.isEmpty ?? false,
                ),
                InfoWidget(
                  title: 'Unidade de medida',
                  text: material.unit,
                ),
                InfoWidget(
                  title: 'Quantidade em estoque',
                  text: material.quantity.toString(),
                ),
                InfoWidget(
                  title: 'Preço por unidade',
                  text: UtilsService.moneyToCurrency(material.price),
                ),
                InfoWidget(
                  title: 'Último mês da compra',
                  text: material.dateOfLastPurchase ?? '',
                  isNull: material.dateOfLastPurchase == null,
                  isEmpty: material.dateOfLastPurchase?.isEmpty ?? false,
                ),
                InfoWidget(
                  title: 'Fornecedor',
                  text: material.supplier ?? '',
                  isNull: material.supplier == null,
                  isEmpty: material.supplier?.isEmpty ?? false,
                ),
                InfoWidget(
                  title: 'Observação',
                  text: material.observation ?? '',
                  isNull: material.observation == null,
                  isEmpty: material.observation?.isEmpty ?? false,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
