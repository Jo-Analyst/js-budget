import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/contact_model.dart';

class TransformJson {
  static ({
    Map<String, dynamic> infoClient,
    Map<String, dynamic>? contactClient,
    Map<String, dynamic>? addressClient
  }) toJson(ClientModel client) {
    Map<String, dynamic> infoClient = {
      'id': client.id,
      'name': client.name,
    };

    Map<String, dynamic> contactClient = {
      'id': client.contact?.id,
      'cell_phone': client.contact?.cellPhone,
      'tele_phone': client.contact?.telePhone,
      'email': client.contact?.email,
      'client_id': client.contact?.id
    };

    Map<String, dynamic> addressClient = {
      'id': client.address?.id,
      'cep': client.address?.cep,
      'district': client.address?.district,
      'street_address': client.address?.streetAddress,
      'number_address': client.address?.numberAddress,
      'city': client.address?.city,
      'state': client.address?.state,
      'client_id': client.address?.id
    };

    return (
      infoClient: infoClient,
      contactClient: contactClient,
      addressClient: addressClient
    );
  }

  static ClientModel fromJson(Map<String, dynamic> client) {
    return ClientModel(
      id: client['id'],
      name: client['name'],
      contact: _contactExists(client)
          ? ContactModel(
              id: client['contact_id'] ?? 0,
              cellPhone: client['cell_phone'] ?? '',
              telePhone: client['tele_phone'] ?? '',
              email: client['email'] ?? '',
              clientId: client['id'])
          : null,
      address: _addressExists(client)
          ? AddressModel(
              id: client['address_id'] ?? 0,
              cep: client['cep'] ?? '',
              district: client['district'] ?? '',
              streetAddress: client['street_address'] ?? '',
              numberAddress: client['number_address'] ?? '',
              city: client['city'] ?? '',
              state: client['state'] ?? '',
              clientId: client['id'],
            )
          : null,
    );
  }

  static bool _contactExists(Map<String, dynamic> client) {
    return client['contact_id'] != null ||
        client['cell_phone'] != null ||
        client['email'] != null ||
        client['tele_phone'] != null;
  }

  static bool _addressExists(Map<String, dynamic> client) {
    return client['address_id'] != null ||
        client['cep'] != null ||
        client['district'] != null ||
        client['street_address'] != null ||
        client['number_address'] != null ||
        client['city'] != null ||
        client['state'] != null;
  }
}
