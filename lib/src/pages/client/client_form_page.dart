import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/pages/client/client_form_controller.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/upper_case_text_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

class ClientFormPage extends StatefulWidget {
  final bool isEdit;
  const ClientFormPage({
    super.key,
    this.isEdit = false,
  });

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage>
    with ClientFormController {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar cliente' : 'Novo cliente'),
        actions: [
          IconButton(
            onPressed: () {
              formKey.currentState!.validate();
            },
            icon: const Icon(
              Icons.save,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColumnTile(
                title: 'Dados pessoais',
                children: [
                  TextFormField(
                    controller: nameEC,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Nome*',
                      suffixIcon: Icon(Icons.person),
                      labelStyle: TextStyle(fontFamily: 'Poppins'),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-ZáéíóúÁÉÍÓÚâêîôûÂÊÎÔÛãõÃÕçÇ ]'),
                      ),
                    ],
                    style: textStyleSmallDefault,
                    validator:
                        Validatorless.required('Nome do cliente obrigátório'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              ColumnTile(
                title: 'Contatos',
                children: [
                  TextFormField(
                    controller: cellPhoneEC,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Celular',
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
                      labelText: 'Telefone',
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
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.mail_outline),
                      labelStyle: TextStyle(fontFamily: 'Poppins'),
                    ),
                    style: textStyleSmallDefault,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ColumnTile(
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
                    decoration: InputDecoration(
                      labelText: 'Bairro',
                      suffixIcon: Image.asset(
                        'assets/images/district.png',
                        width: 25,
                      ),
                      labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    ),
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
                      suffixIcon: Icon(Icons.numbers),
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
      ),
    );
  }
}
