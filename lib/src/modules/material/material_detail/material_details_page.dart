import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/material/material_controller.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/pages/widgets/list_view_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class MaterialDetailsPage extends StatelessWidget {
  const MaterialDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<MaterialController>();
    final material =
        ModalRoute.of(context)!.settings.arguments as MaterialModel;
    final dateExtracted =
        UtilsService.getExtractedDate(material.dateOfLastPurchase!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do material'),
        actions: [
          IconButton(
            tooltip: 'Editar',
            onPressed: () {
              controller.model.value = material;
              Navigator.of(context).pushNamed(
                '/material/form',
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            tooltip: 'Excluir',
            onPressed: () async {
              var nav = Navigator.of(context);
              bool confirm = await showConfirmationDialog(
                    context,
                    'Ao excluir esta matéria-prima, os dados serão removidos das possíveis movimentações nas quais foram incluídos. \nDeseja mesmo excluir "${material.name}" de sua lista de materiais?',
                    buttonTitle: 'Sim',
                  ) ??
                  false;

              if (confirm) {
                controller.deleteMaterial(material.id);
                nav.pop();
              }
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: CustomListTileIcon(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  leading: Image.asset(
                    'assets/images/materia-prima.png',
                    width: 20,
                  ),
                  title: material.name,
                  subtitle: material.type,
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: ListViewTile(
                  color: Colors.transparent,
                  textColor: Colors.black,
                  title: '+ detalhes',
                  children: [
                    CustomListTileIcon(
                      title: material.unit,
                      leading: const Icon(
                        Icons.square_foot_sharp,
                        size: 28,
                      ),
                    ),
                    CustomListTileIcon(
                      title: '${material.quantity.toString()}/unidade',
                      leading: const Icon(
                        Icons.format_list_numbered,
                        size: 28,
                      ),
                    ),
                    CustomListTileIcon(
                      title:
                          '${UtilsService.moneyToCurrency(material.price)}/unidade',
                      leading: const Icon(Icons.price_change),
                    ),
                    if (material.dateOfLastPurchase != null)
                      Visibility(
                        visible: material.dateOfLastPurchase!.isNotEmpty,
                        child: CustomListTileIcon(
                          title: UtilsService.dateFormatText(dateExtracted),
                          leading: const Icon(Icons.calendar_month),
                        ),
                      ),
                    if (material.supplier != null)
                      Visibility(
                        visible: material.supplier!.isNotEmpty,
                        child: CustomListTileIcon(
                          title: material.supplier!,
                          leading: const Icon(Icons.local_shipping_outlined),
                        ),
                      ),
                    if (material.observation != null)
                      Visibility(
                        visible: material.observation!.isNotEmpty,
                        child: CustomListTileIcon(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          title: material.observation!,
                          leading: const Icon(Icons.note_alt_outlined),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
