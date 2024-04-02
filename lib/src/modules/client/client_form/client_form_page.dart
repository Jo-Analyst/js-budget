import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/modules/client/client_controller.dart';
import 'package:js_budget/src/modules/client/client_form/client_form_controller.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/find_cep_controller.dart';
import 'package:js_budget/src/utils/upper_case_text_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({
    super.key,
  });

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage>
    with ClientFormController, Messages {
  final formKey = GlobalKey<FormState>();
  ClientModel? client;
  final clientController = Injector.get<ClientController>();
  final cepController = Injector.get<FindCepController>();
  bool isALegalEntity = false;

  @override
  void initState() {
    super.initState();
    client = clientController.model.value;
    if (client != null) {
      initializeForm(client!);
      isALegalEntity = client!.isALegalEntity == 1;
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

  void findCep(value) async {
    if (value.length == 10) {
      await cepController.findCep(value);

      AddressModel? address = cepController.addressModel;
      if (address != null) {
        setCep(address);
      } else if (cepController.thereIsAnError) {
        cepEC.text = '';
        cepController.thereIsAnError = false;
      } else {
        cepEC.text = value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool comesFromTheOrder =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(client != null ? 'Editar cliente' : 'Novo cliente'),
        actions: [
          IconButton(
            onPressed: () async {
              var nav = Navigator.of(context);
              if (formKey.currentState!.validate()) {
                await clientController.save(
                  saveClient(
                    client?.id ?? 0,
                    client?.address?.id ?? 0,
                    client?.contact?.id ?? 0,
                    isALegalEntity ? 1 : 0,
                  ),
                );
                nav.pop();
                if (client != null && !comesFromTheOrder) {
                  nav.pop();
                }
              }
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
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Pessoa jurídica',
                            style: textStyleSmallDefault,
                            textAlign: TextAlign.end,
                          ),
                          trailing: Switch(
                            value: isALegalEntity,
                            onChanged: (value) {
                              setState(() {
                                isALegalEntity = !isALegalEntity;
                              });
                            },
                          ),
                        ),
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
                          validator: Validatorless.required(
                              'Nome do cliente obrigátório'),
                        ),
                        Visibility(
                          visible: isALegalEntity,
                          child: TextFormField(
                              controller: documentEC,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskTextInputFormatter(
                                    mask: '##.###.###/####-##'),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'CNPJ',
                                suffixIcon: Icon(Icons.description),
                                labelStyle: TextStyle(fontFamily: 'Poppins'),
                              ),
                              style: textStyleSmallDefault,
                              validator: Validatorless.cnpj('CNPJ inválido')),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ColumnTile(
                      color: Colors.transparent,
                      textColor: Colors.black,
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
                          validator: (value) {
                            if (value!.isNotEmpty && value.length < 16) {
                              return 'Número de celular incompleto';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value!.isNotEmpty && value.length < 14) {
                              return 'Número de telefone incompleto';
                            }
                            return null;
                          },
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
                          validator: mailEC.text.trim().isNotEmpty
                              ? Validatorless.email('Email inválido')
                              : null,
                          style: textStyleSmallDefault,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ColumnTile(
                      color: Colors.transparent,
                      textColor: Colors.black,
                      title: 'Endereço',
                      children: [
                        TextFormField(
                          controller: cepEC,
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'CEP',
                            suffixIcon: Icon(Icons.map),
                            labelStyle: TextStyle(fontFamily: 'Poppins'),
                          ),
                          inputFormatters: [
                            MaskTextInputFormatter(mask: '##.###-###'),
                          ],
                          style: textStyleSmallDefault,
                          onChanged: findCep,
                        ),
                        TextFormField(
                          controller: districtEC,
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.streetAddress,
                          textCapitalization: TextCapitalization.words,
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
                          textCapitalization: TextCapitalization.words,
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                          textCapitalization: TextCapitalization.words,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
