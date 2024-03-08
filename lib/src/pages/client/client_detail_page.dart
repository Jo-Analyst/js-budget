import 'package:flutter/material.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/info_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ClientDetailPage extends StatefulWidget {
  const ClientDetailPage({super.key});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  ContactModel? contacts =
      ContactModel(cellPhone: '(99) 9 999-9999', email: 'Joelmir@gmail.com');
  AddressModel? address = AddressModel(
      district: 'Centro',
      streetAddress: "Rua tal",
      numberAddress: '',
      city: 'Felício dos Santos',
      state: 'MG',
      clientId: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do cliente'),
        actions: [
          IconButton(
            tooltip: 'Editar',
            onPressed: () {
              Navigator.of(context).pushNamed('/client-form');
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            tooltip: 'Excluir',
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ColumnTile(
                    title: 'Dados do cliente',
                    children: [
                      InfoWidget(
                        title: 'Nome',
                        text: 'Joelmir Rogério Carvalho',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // contatos
                  if (contacts != null)
                    ColumnTile(
                      title: 'Contatos',
                      children: [
                        InfoWidget(
                          title: 'Telefone',
                          text: contacts!.telePhone ?? '',
                          isNull: contacts!.telePhone == null,
                          isEmpty: contacts!.telePhone?.isEmpty ?? false,
                        ),
                        InfoWidget(
                          title: 'Celular',
                          text: contacts!.cellPhone,
                        ),
                        InfoWidget(
                          title: 'Email',
                          text: contacts!.email ?? '',
                          isNull: contacts!.email == null,
                          isEmpty: contacts!.email?.isEmpty ?? false,
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),

                  // Endereço
                  if (address != null)
                    ColumnTile(
                      title: 'Endereço',
                      children: [
                        InfoWidget(
                          title: 'Bairro',
                          text: address!.district,
                          isNull: address!.district.isEmpty,
                        ),
                        InfoWidget(
                          title: 'Rua',
                          text: address!.streetAddress,
                          isNull: address!.streetAddress.isEmpty,
                        ),
                        InfoWidget(
                          title: 'Número',
                          text: address!.numberAddress,
                          isNull: address!.numberAddress.isEmpty,
                        ),
                        InfoWidget(
                          title: 'Cidade',
                          text: address!.city,
                          isNull: address!.city.isEmpty,
                        ),
                        InfoWidget(
                          title: 'Estado',
                          text: address!.state,
                          isNull: address!.state.isEmpty,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            width: double.infinity,
            height: 88,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {},
              icon: const Icon(
                Icons.assignment,
                color: Colors.black,
              ),
              label: const Text(
                'Ver todos os pedidos',
                style: textStyleSmallDefault,
              ),
            ),
          )
        ],
      ),
    );
  }
}
