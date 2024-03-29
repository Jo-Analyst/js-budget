import 'package:flutter/material.dart';
import 'package:js_budget/src/models/products_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String search = '';
  List<ProductsModel> products = [
    ProductsModel(name: 'Guarda Roupa', detail: '', unit: 'unidade'),
    ProductsModel(name: 'Mesa', detail: '', unit: 'unidade'),
    ProductsModel(name: 'Cadeira', detail: '', unit: 'unidade'),
    ProductsModel(name: 'Banco', detail: '', unit: 'unidade'),
  ];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    // await controller.findMaterial();
  }

  @override
  Widget build(BuildContext context) {
    var filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/product/save');
            },
            tooltip: "Novo produto",
            icon: const Icon(
              Icons.add,
              size: 30,
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
                              Navigator.pushNamed(context, '/product/save');
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
                : ListView(
                    children: filteredProducts
                        .map((product) => Column(
                              children: [
                                ListTile(
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.of(context).pushNamed(
                                        '/product/details',
                                        arguments: product);

                                    // controller.model.value = null;
                                  },
                                  leading: Image.asset(
                                    'assets/images/materia-prima.png',
                                    width: 25,
                                  ),
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
        ],
      ),
    );
  }
}
