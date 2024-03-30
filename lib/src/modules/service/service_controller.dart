import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/repositories/service/service_repository.dart';
import 'package:js_budget/src/repositories/service/transform_service_json.dart';
import 'package:signals/signals.dart';

import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';

class ServiceController with Messages {
  final ServiceRepository _serviceRepository;
  ServiceController({
    required ServiceRepository serviceRepository,
  }) : _serviceRepository = serviceRepository;

  final _data = ListSignal<ServiceModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => a.description
          .toString()
          .toLowerCase()
          .compareTo(b.description.toString().toLowerCase()),
    );

  final model = signal<ServiceModel?>(null);

  Future<void> save(ServiceModel service) async {
    final result = service.id == 0
        ? await _serviceRepository.register(service)
        : await _serviceRepository.update(service);

    switch (result) {
      case Right(value: ServiceModel model):
        _data.add(model);
        showSuccess('Serviço cadastrado com sucesso');
      case Right():
        if (service.id > 0) {
          _deleteItem(service.id);
        }
        _data.add(service);
        showSuccess('Serviço alterado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o serviço');
    }
  }

  Future<void> deleteService(int id) async {
    final result = await _serviceRepository.delete(id);
    switch (result) {
      case Right():
        _deleteItem(id);
        showSuccess('Serviço excluido com sucesso');
      case Left():
        showError('Houve um erro ao excluir o serviço');
    }
  }

  void _deleteItem(int id) {
    _data.removeWhere((item) => item.id == id);
  }

  Future<void> findService() async {
    _data.clear();
    final results = await _serviceRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> services):
        for (var service in services) {
          _data.add(TransformJson.fromJson(service));
        }

      case Left():
        showError('Houver erro ao buscar o serviço');
    }
  }
}
