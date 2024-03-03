import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/pages/client/client_form_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/upper_case_text_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClientRegistrationPage extends StatefulWidget {
  const ClientRegistrationPage({super.key});

  @override
  State<ClientRegistrationPage> createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage>
    with ClientFormController {
  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.name,
                maxLength: 100,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Seu nome*'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-ZáéíóúÁÉÍÓÚâêîôûÂÊÎÔÛãõÃÕçÇ ]'),
                  ),
                ],
              ),
              TextFormField(
                controller: phoneEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Seu telefone'),
                inputFormatters: [
                  MaskTextInputFormatter(mask: '(##) # ####-####'),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: streetAddressEC,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      maxLength: 100,
                      keyboardType: TextInputType.streetAddress,
                      decoration:
                          const InputDecoration(labelText: 'Logradouro'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: numberAddressEC,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      maxLength: 20,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(labelText: 'Nº'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: cityEC,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      maxLength: 100,
                      decoration: const InputDecoration(labelText: 'Cidade'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: stateEC,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      maxLength: 2,
                      inputFormatters: [UpperCaseTextFormatter()],
                      decoration: const InputDecoration(labelText: 'Estado'),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Salvar',
                    style: textStyleSmallDefault,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
