import 'package:flutter/material.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ContactWidget extends StatelessWidget {
  final ContactModel? contact;
  const ContactWidget({this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return contact != null
        ? Card(
            child: ColumnTile(
              color: Colors.transparent,
              textColor: Colors.black,
              title: 'Contatos',
              children: [
                Visibility(
                  visible: contact!.cellPhone.isNotEmpty,
                  child: CustomListTileIcon(
                    title: contact!.cellPhone,
                    leading: const Icon(Icons.phone_android),
                  ),
                ),
                Visibility(
                  visible: contact!.telePhone.isNotEmpty,
                  child: CustomListTileIcon(
                    title: contact!.telePhone,
                    leading: const Icon(Icons.phone),
                  ),
                ),
                Visibility(
                  visible: contact!.email.isNotEmpty,
                  child: CustomListTileIcon(
                    title: contact!.email,
                    leading: const Icon(Icons.mail_outline),
                  ),
                ),
              ],
            ),
          )
        : const Card(
            child: ColumnTile(
              title: 'Contatos',
              color: Colors.transparent,
              textColor: Colors.black,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.info),
                  title: Text(
                    'Não há contato cadastrado.',
                    style: textStyleSmallDefault,
                  ),
                )
              ],
            ),
          );
  }
}
