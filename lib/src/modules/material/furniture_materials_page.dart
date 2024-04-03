import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/material/material_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class FurnitureMaterials extends StatefulWidget {
  const FurnitureMaterials({super.key});

  @override
  State<FurnitureMaterials> createState() => _FurnitureMaterialsState();
}

class _FurnitureMaterialsState extends State<FurnitureMaterials> {
  final controller = Injector.get<MaterialController>();

  String search = '';

  @override
  void initState() {
    super.initState();
    loadMaterial();
  }

  Future<void> loadMaterial() async {
    await controller.findMaterials();
  }

  @override
  Widget build(BuildContext context) {
    var filteredMaterials = controller.data
        .watch(context)
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
              Navigator.of(context).pushNamed('/material/form');
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
                              Navigator.pushNamed(context, '/material/form');
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
                                  onTap: () async {
                                    await Navigator.of(context).pushNamed(
                                        '/material/details',
                                        arguments: material);

                                    controller.model.value = null;
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
