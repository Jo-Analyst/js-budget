import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/service/service_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final controller = Injector.get<ServiceController>();
  List<ServiceModel> serviceSelected = [];
  bool longPressWasPressed = false, selectedEverything = false;
  String search = '';

  void selectService(ServiceModel serviceModel) {
    setState(() {
      if (serviceSelected.any((service) => service.id == serviceModel.id)) {
        serviceSelected.removeWhere((service) => service.id == serviceModel.id);
        return;
      }
      serviceSelected.add(serviceModel);
    });

    setState(() {
      longPressWasPressed = serviceSelected.isNotEmpty;
    });
  }

  void selectAll() {
    if (selectedEverything ||
        serviceSelected.length == controller.data.length) {
      serviceSelected.clear();
      setState(() {
        selectedEverything = false;
        longPressWasPressed = false;
      });
      return;
    }

    serviceSelected.clear();
    setState(() {
      for (var product in controller.data) {
        serviceSelected.add(product);
      }

      selectedEverything = true;
    });
  }

  Future<void> loadService() async {
    await controller.findService();
  }

  @override
  void initState() {
    super.initState();
    loadService();
  }

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    bool comesFromTheOrder =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;
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
          Visibility(
            visible: serviceSelected.isNotEmpty,
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
              nav.pushNamed('/service/form');
            },
            tooltip: "Novo Serviço",
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          Visibility(
            visible: serviceSelected.isNotEmpty,
            child: IconButton(
              onPressed: () {
                nav.pop(serviceSelected);
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
                          textAlign: TextAlign.center,
                          style: textStyleMediumDefault,
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
                              nav.pushNamed('/service/form');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const FlexibleText(
                              text: 'Adicionar serviço',
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
                                  onTap: comesFromTheOrder
                                      ? () {
                                          if (longPressWasPressed) {
                                            selectService(service);

                                            return;
                                          }

                                          nav.pop([service as ServiceModel]);
                                        }
                                      : () async {
                                          await nav.pushNamed(
                                              '/service/details',
                                              arguments: service);

                                          controller.model.value = null;
                                        },
                                  onLongPress: comesFromTheOrder
                                      ? () => selectService(service)
                                      : null,
                                  selected: longPressWasPressed &&
                                      serviceSelected.any((servSelected) =>
                                          service.id == servSelected.id),
                                  selectedTileColor: theme.primaryColor,
                                  selectedColor: Colors.black54,
                                  leading: const Icon(
                                      FontAwesomeIcons.screwdriverWrench),
                                  title: FlexibleText(
                                    text: service.description,
                                  ),
                                  trailing: FlexibleText(
                                    text: UtilsService.moneyToCurrency(
                                        service.price),
                                    fontFamily: 'Anta',
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
