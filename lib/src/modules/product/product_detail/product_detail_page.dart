import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/modules/product/product_controller.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<ProductController>();
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do produto'),
        actions: [
          IconButton(
            tooltip: 'Editar',
            onPressed: () {
              controller.model.value = product;
              Navigator.of(context).pushNamed(
                '/product/save',
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
                    'Deseja mesmo excluir ${product.name} de sua lista de produtos?',
                    buttonTitle: 'Sim',
                  ) ??
                  false;

              if (confirm) {
                controller.deleteProduct(product.id);
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
                  title: product.name,
                  subtitle: product.unit,
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      CustomListTileIcon(
                        title: product.unit,
                        leading: const Icon(
                          Icons.square_foot_sharp,
                          size: 28,
                        ),
                      ),
                      Visibility(
                        visible: product.description.isNotEmpty,
                        child: CustomListTileIcon(
                          title: product.description,
                          leading: const Icon(
                            Icons.description,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
