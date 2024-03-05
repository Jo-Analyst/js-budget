import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/pages/client/client_form_controller.dart';
import 'package:js_budget/src/pages/widgets/form_details.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/upper_case_text_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({super.key});

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage>
    with ClientFormController {
  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo cliente'), actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.save,
            size: 30,
          ),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormDetails(
              title: 'Dados pessoais',
              children: [
                TextFormField(
                  controller: nameEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Seu nome*',
                    suffixIcon: Icon(Icons.person),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-ZáéíóúÁÉÍÓÚâêîôûÂÊÎÔÛãõÃÕçÇ ]'),
                    ),
                  ],
                  style: textStyleSmallDefault,
                )
              ],
            ),
            const SizedBox(height: 16),
            FormDetails(
              title: 'Contatos',
              children: [
                TextFormField(
                  controller: cellPhoneEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Seu celular',
                    suffixIcon: Icon(Icons.phone_android),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '(##) # ####-####'),
                  ],
                  style: textStyleSmallDefault,
                ),
                TextFormField(
                  controller: telePhoneEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Seu telefone',
                    suffixIcon: Icon(Icons.phone),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '(##) ####-####'),
                  ],
                  style: textStyleSmallDefault,
                ),
                TextFormField(
                  controller: mailEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Seu email',
                    suffixIcon: Icon(Icons.mail_outline),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: textStyleSmallDefault,
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormDetails(
              title: 'Endereço',
              children: [
                TextFormField(
                  controller: cepEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    labelText: 'CEP',
                    suffixIcon: Icon(Icons.map),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '##.###-###'),
                  ],
                  style: textStyleSmallDefault,
                ),
                TextFormField(
                  controller: streetAddressEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    labelText: 'Logradouro',
                    suffixIcon: Icon(Icons.location_on_outlined),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: textStyleSmallDefault,
                ),
                TextFormField(
                  controller: numberAddressEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Nº',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: textStyleSmallDefault,
                ),
                TextFormField(
                  controller: cityEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    suffixIcon: Icon(Icons.location_city_rounded),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: textStyleSmallDefault,
                ),
                TextFormField(
                  controller: stateEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  inputFormatters: [UpperCaseTextFormatter()],
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                    suffixIcon: Icon(Icons.business),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: textStyleSmallDefault,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
