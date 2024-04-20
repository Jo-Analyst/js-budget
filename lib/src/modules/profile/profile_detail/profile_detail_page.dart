import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/profile_model.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/utils/utils_service.dart';
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
              Navigator.of(context).pushNamed('/profile/form');
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
              // dados preferencial
              Card(
                child: CustomListTileIcon(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  leading: const Icon(Icons.store, size: 35),
                  title: profile!.fantasyName,
                  subtitle: profile.document,
                ),
              ),

              // Razão social
              Card(
                child: ColumnTile(
                    title: 'Razão social',
                    color: Colors.transparent,
                    textColor: Colors.black,
                    children: [
                      CustomListTileIcon(
                        leading: const Icon(
                          Icons.person,
                        ),
                        title: profile.corporateReason,
                      ),
                    ]),
              ),

              //contato
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
              // Endereço
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

              // Pretensão salarial
              Card(
                child: ColumnTile(
                    title: 'Informação adicional',
                    color: Colors.transparent,
                    textColor: Colors.black,
                    children: [
                      CustomListTileIcon(
                        leading: const Icon(
                          Icons.price_change,
                        ),
                        title: UtilsService.moneyToCurrency(
                            profile.salaryExpectation),
                        titleFontFamily: 'Anta',
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
