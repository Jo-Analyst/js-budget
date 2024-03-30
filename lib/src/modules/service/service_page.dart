import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/modules/service/service_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:signals/signals_flutter.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final controller = Injector.get<ServiceController>();
  String search = '';

  @override
  void initState() {
    super.initState();
    loadService();
  }

  Future<void> loadService() async {
    await controller.findService();
  }

  @override
  Widget build(BuildContext context) {
    var filteredServices = controller.data
        .watch(context)
        .where((service) =>
            service.description.toLowerCase().contains(search.toLowerCase()))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/service/save');
            },
            tooltip: "Novo Serviço",
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
                labelText: 'Buscar serviço',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredServices.isEmpty
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
                          'Nenhum serviço encontrado',
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
                              Navigator.pushNamed(context, '/service/save');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Adicionar serviço',
                              style: textStyleSmallDefault,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    children: filteredServices
                        .map((service) => Column(
                              children: [
                                ListTile(
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.of(context).pushNamed(
                                        '/service/details',
                                        arguments: service);

                                    controller.model.value = null;
                                  },
                                  leading: const Icon(
                                      FontAwesomeIcons.screwdriverWrench),
                                  title: Text(
                                    service.description,
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
