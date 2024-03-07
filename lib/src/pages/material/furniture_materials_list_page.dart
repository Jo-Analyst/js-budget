import 'package:flutter/material.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class FurnitureMaterialsList extends StatefulWidget {
  const FurnitureMaterialsList({super.key});

  @override
  State<FurnitureMaterialsList> createState() => _FurnitureMaterialsListState();
}

class _FurnitureMaterialsListState extends State<FurnitureMaterialsList> {
  final List<MaterialModel> materials = [
    MaterialModel(
      name: 'Madeira de Carvalho',
      type: 'Madeira',
      unit: 'Metros',
      price: 20.0,
      quantity: 30,
      dateOfLastPurchase: 'Fevereiro de 2024',
      observation:
          'Este material é extremamente durável e resistente a insetos. Ideal para a fabricação de móveis de alta qualidade. No entanto, é um pouco mais caro em comparação com outras madeiras disponíveis no mercado',
      supplier: 'Empresa XXX',
    ),
    MaterialModel(
      name: 'Aço inoxidável',
      type: 'Metal',
      unit: 'Kilograma',
      price: 50.0,
      quantity: 20,
      observation: '',
      supplier: 'Empresa XX',
    )
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    var filteredMaterials = materials
        .where((material) =>
            material.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Materiais'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/material-form');
            },
            tooltip: "Novo Material",
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
                labelText: 'Buscar material',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredMaterials.isEmpty
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
                          'Nenhum material encontrado',
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
                              Navigator.pushNamed(context, '/material-form');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Adicionar material',
                              style: textStyleSmallDefault,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    children: filteredMaterials
                        .map((material) => Column(
                              children: [
                                ListTile(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/material-detail',
                                        arguments: material);
                                  },
                                  leading: Image.asset(
                                    'assets/images/materia-prima.png',
                                    width: 25,
                                  ),
                                  title: Text(
                                    material.name,
                                    style: textStyleSmallDefault,
                                  ),
                                  subtitle: Text(
                                    UtilsService.moneyToCurrency(
                                        material.price),
                                    style: TextStyle(
                                      fontSize: textStyleSmallDefault.fontSize,
                                      fontFamily: 'Anta',
                                    ),
                                  ),
                                  trailing: Text(
                                    material.quantity.toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: textStyleSmallDefault.fontSize,
                                      fontFamily: 'Anta',
                                    ),
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
