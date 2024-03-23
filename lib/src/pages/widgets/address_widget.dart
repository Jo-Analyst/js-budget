import 'package:flutter/material.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel? address;
  const AddressWidget({this.address, super.key});

  @override
  Widget build(BuildContext context) {
    return address != null
        ? Card(
            child: ColumnTile(
              title: 'Endereço',
              color: Colors.transparent,
              textColor: Colors.black,
              children: [
                Visibility(
                  visible: address!.cep.isNotEmpty,
                  child: CustomListTileIcon(
                    title: address!.cep,
                    leading: const Icon(Icons.map),
                  ),
                ),
                Visibility(
                  visible: address!.district.isNotEmpty,
                  child: CustomListTileIcon(
                    title: address!.district,
                    leading: const Icon(Icons.maps_home_work_outlined),
                  ),
                ),
                Visibility(
                  visible: address!.streetAddress.isNotEmpty,
                  child: CustomListTileIcon(
                    leading: const Icon(
                      Icons.location_on_outlined,
                    ),
                    title: address!.streetAddress,
                  ),
                ),
                Visibility(
                  visible: address!.numberAddress.isNotEmpty,
                  child: CustomListTileIcon(
                    title: address!.numberAddress,
                    leading: const Icon(Icons.numbers),
                  ),
                ),
                Visibility(
                  visible: address!.city.isNotEmpty,
                  child: CustomListTileIcon(
                    title: address!.city,
                    leading: const Icon(Icons.location_city_rounded),
                  ),
                ),
                Visibility(
                  visible: address!.state.isNotEmpty,
                  child: CustomListTileIcon(
                    title: address!.state,
                    leading: const Icon(Icons.business),
                  ),
                ),
              ],
            ),
          )
        : const Card(
            child: ColumnTile(
              title: 'Endereço',
              color: Colors.transparent,
              textColor: Colors.black,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.info),
                  title: Text(
                    'Não há endereço cadastrado.',
                    style: textStyleSmallDefault,
                  ),
                )
              ],
            ),
          );
  }
}
