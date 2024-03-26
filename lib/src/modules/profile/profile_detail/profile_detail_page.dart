import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/profile_model.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:signals/signals_flutter.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileModel? profile =
        context.get<ProfileController>().model.watch(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/profile/save');
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    CustomListTileIcon(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      leading: const Icon(Icons.store, size: 35),
                      title: profile!.fantasyName,
                      subtitle: profile.document,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomListTileIcon(
                        leading: const Icon(
                          Icons.person,
                        ),
                        title: profile.corporateReason,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: ColumnTile(
                  title: 'Contato',
                  color: Colors.transparent,
                  textColor: Colors.black,
                  children: [
                    CustomListTileIcon(
                      leading: const Icon(
                        Icons.phone_android,
                      ),
                      title: profile.contact.cellPhone,
                    ),
                    Visibility(
                      visible: profile.contact.email.isNotEmpty,
                      child: CustomListTileIcon(
                        title: profile.contact.email,
                        leading: const Icon(Icons.mail_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: ColumnTile(
                  title: 'Endereço',
                  color: Colors.transparent,
                  textColor: Colors.black,
                  children: [
                    CustomListTileIcon(
                      title: profile.address.district,
                      leading: const Icon(Icons.maps_home_work_outlined),
                    ),
                    CustomListTileIcon(
                      leading: const Icon(
                        Icons.location_on_outlined,
                      ),
                      title: profile.address.streetAddress,
                    ),
                    CustomListTileIcon(
                      title: profile.address.numberAddress,
                      leading: const Icon(Icons.numbers),
                    ),
                    CustomListTileIcon(
                      title: profile.address.city,
                      leading: const Icon(Icons.location_city_rounded),
                    ),
                    CustomListTileIcon(
                      title: profile.address.state,
                      leading: const Icon(Icons.business),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
