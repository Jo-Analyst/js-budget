import 'package:js_budget/src/exception/respository_exception.dart';

import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:search_cep/search_cep.dart';


import 'find_cep_repository.dart';

class FindCepRepositoryImpl implements FindCepRepository {
  @override
  Future<Either<RespositoryException, AddressModel>> findCep(
      String numberCep) async {
    final viaCepSearchCep = ViaCepSearchCep();
    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(
        cep: numberCep.replaceAll(RegExp(r'\D'), ''));
    AddressModel? address;
    SearchCepError? error;

    infoCepJSON.fold(
      (e) => error = e,
      (dt) => address = AddressModel(
        cep: numberCep,
        district: dt.bairro ?? '',
        streetAddress: dt.logradouro ?? '',
        numberAddress: '',
        city: dt.localidade ?? '',
        state: dt.uf ?? '',
      ),
    );

    return address != null
        ? Right(address!)
        : Left(RespositoryException(message: error!.errorMessage));
  }
}
