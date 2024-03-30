import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/modules/service/service_controller.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';

class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Injector.get<ServiceController>();
    final service = ModalRoute.of(context)!.settings.arguments as ServiceModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do serviço'),
        actions: [
          IconButton(
            tooltip: 'Editar',
            onPressed: () {
              controller.model.value = service;
              Navigator.of(context).pushNamed(
                '/service/save',
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
                    'Deseja mesmo excluir ${service.description} de sua lista de serviços?',
                    buttonTitle: 'Sim',
                  ) ??
                  false;

              if (confirm) {
                controller.deleteService(service.id);
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
                  leading: const Icon(FontAwesomeIcons.screwdriverWrench),
                  title: service.description,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
