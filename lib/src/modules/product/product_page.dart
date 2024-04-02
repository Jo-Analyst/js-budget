import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/modules/product/product_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:signals/signals_flutter.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final controller = Injector.get<ProductController>();
  String search = '';
  List<ProductModel> productSelected = [];
  bool longPressWasPressed = false, selectedEverything = false;

  void selectProduct(ProductModel productModel) {
    setState(() {
      if (productSelected.any((product) => product.id == productModel.id)) {
        productSelected.removeWhere((product) => product.id == productModel.id);
        return;
      }
      productSelected.add(productModel);
    });

    setState(() {
      longPressWasPressed = productSelected.isNotEmpty;
    });
  }

  void selectAll() {
    if (selectedEverything ||
        productSelected.length == controller.data.length) {
      productSelected.clear();
      setState(() {
        selectedEverything = false;
        longPressWasPressed = false;
      });
      return;
    }

    productSelected.clear();
    setState(() {
      for (var product in controller.data) {
        productSelected.add(product);
      }

      selectedEverything = true;
    });
  }

  Future<void> loadProducts() async {
    await controller.findProduct();
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    bool comesFromTheOrder =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;
    var filteredProducts = controller.data
        .watch(context)
        .where((product) =>
            product.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          Visibility(
            visible: productSelected.isNotEmpty,
            child: IconButton(
              onPressed: selectAll,
              icon: const Icon(
                Icons.select_all,
                size: 30,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/product/form');
            },
            tooltip: "Novo produto",
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          Visibility(
            visible: productSelected.isNotEmpty,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop(productSelected);
              },
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar produto',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 100,
                          color: theme.colorScheme.primary.withOpacity(.7),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Nenhum produto encontrado',
                          style: textStyleSmallDefault,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/product/form');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Adicionar produto',
                              style: textStyleSmallDefault,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView(
                      children: filteredProducts
                          .map((product) => Column(
                                children: [
                                  ListTile(
                                    splashColor: Colors.transparent,
                                    onTap: comesFromTheOrder
                                        ? () {
                                            selectProduct(product);
                                          }
                                        : () async {
                                            await Navigator.of(context)
                                                .pushNamed('/product/details',
                                                    arguments: product);

                                            controller.model.value = null;
                                          },
                                    onLongPress: comesFromTheOrder
                                        ? () {
                                            selectProduct(product);
                                          }
                                        : null,
                                    selected: longPressWasPressed &&
                                        productSelected.any((prodSelect) =>
                                            product.id == prodSelect.id),
                                    selectedTileColor: theme.primaryColor,
                                    selectedColor: Colors.black54,
                                    leading: const Icon(Icons.local_offer),
                                    title: Text(
                                      product.name,
                                      style: textStyleSmallDefault,
                                    ),
                                    subtitle: Text(
                                      product.unit,
                                      style: textStyleSmallDefault,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
