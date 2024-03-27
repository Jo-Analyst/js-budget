import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/repositories/find_cep/find_cep_repository.dart';

class FindCepController with Messages {
  FindCepController({
    required FindCepRepository findCepRepository,
  }) : _findCepRepository = findCepRepository;

  final FindCepRepository _findCepRepository;
  AddressModel? addressModel;

  Future<void> findCep(String numberCep) async {
    final result = await _findCepRepository.findCep(numberCep);

    switch (result) {
      case Right(value: AddressModel address):
        addressModel = address;
      case Left(value: RespositoryException e):
        if (e.message.toLowerCase() == 'cep inexistente.') {
          showError(e.message, position: Position.top);
          addressModel = null;
        }
    }
  }
}
