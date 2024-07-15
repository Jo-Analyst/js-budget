import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/service/service_controller.dart';
import 'package:js_budget/src/modules/service/service_form/service_form_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:validatorless/validatorless.dart';

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key});

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage>
    with ServiceFormController {
  final controller = Injector.get<ServiceController>();
  final _formKey = GlobalKey<FormState>();
  String unit = 'Unidade Padrão';

  ServiceModel? service;

  @override
  void initState() {
    super.initState();
    service = controller.model();

    if (service != null) {
      initializeForm(service!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service != null ? 'Editar serviço' : 'Novo serviço'),
        actions: [
          IconButton(
            onPressed: () async {
              var nav = Navigator.of(context);
              if (_formKey.currentState!.validate()) {
                await controller.save(
                  save(service?.id ?? 0),
                );

                nav.pop();
                if (service != null) {
                  nav.pop();
                }
              }
            },
            tooltip: 'Salvar',
            icon: const Icon(
              Icons.save,
              size: 30,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: descriptionEC,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: const InputDecoration(
                          labelText: 'Nome do serviço*',
                          labelStyle: TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Icon(
                            FontAwesomeIcons.screwdriverWrench,
                            size: 20,
                          ),
                        ),
                        style: textStyleMediumDefault,
                        validator: Validatorless.required(
                            'Nome do serviço obrigatório.'),
                      ),
                      TextFormField(
                        controller: priceEC,
                        decoration: const InputDecoration(
                          labelText: 'Preço do serviço*',
                          labelStyle: TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Icon(Icons.attach_money),
                        ),
                        style: textStyleMediumDefault,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (priceEC.numberValue == 0) {
                            return 'Valor do serviço obrigatório';
                          }

                          return null;
                        },
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
