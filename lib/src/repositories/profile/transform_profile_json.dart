import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/models/profile_model.dart';

class TransformJson {
  static ({
    Map<String, dynamic> infoProfile,
    Map<String, dynamic>? contactProfile,
    Map<String, dynamic>? addressProfile
  }) toJson(ProfileModel profile) {
    Map<String, dynamic> infoProfile = {
      'id': profile.id,
      'fantasy_name': profile.fantasyName,
      'document': profile.document,
    };

    Map<String, dynamic> contactProfile = {
      'id': profile.contact.id,
      'cell_phone': profile.contact.cellPhone,
      'tele_phone': profile.contact.telePhone,
      'email': profile.contact.email,
      'profile_id': profile.contact.id
    };

    Map<String, dynamic> addressProfile = {
      'id': profile.address.id,
      'cep': profile.address.cep,
      'district': profile.address.district,
      'street_address': profile.address.streetAddress,
      'number_address': profile.address.numberAddress,
      'city': profile.address.city,
      'state': profile.address.state,
      'profile_id': profile.address.id
    };

    return (
      infoProfile: infoProfile,
      contactProfile: contactProfile,
      addressProfile: addressProfile
    );
  }

  static ProfileModel fromJson(Map<String, dynamic> profile) {
    return ProfileModel(
      id: profile['id'],
      fantasyName: profile['fantasy_name'],
      document: profile['document'] ?? '',
      corporateReason: profile['corporate_reason'],
      contact: ContactModel(
        id: profile['contact_id'] ?? 0,
        cellPhone: profile['cell_phone'] ?? '',
        telePhone: profile['tele_phone'] ?? '',
        email: profile['email'] ?? '',
        profileId: profile['id'],
      ),
      address: AddressModel(
        id: profile['address_id'] ?? 0,
        cep: profile['cep'] ?? '',
        district: profile['district'] ?? '',
        streetAddress: profile['street_address'] ?? '',
        numberAddress: profile['number_address'] ?? '',
        city: profile['city'] ?? '',
        state: profile['state'] ?? '',
        profileId: profile['id'],
      ),
    );
  }
}
