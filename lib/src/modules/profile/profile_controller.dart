import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/profile_model.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:js_budget/src/repositories/profile/transform_profile_json.dart';
import 'package:signals/signals.dart';

class ProfileController with Messages {
  ProfileController({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final _data = ListSignal<ProfileModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => a.fantasyName
          .toString()
          .toLowerCase()
          .compareTo(b.fantasyName.toString().toLowerCase()),
    );

  final model = signal<ProfileModel?>(null);

  final ProfileRepository _profileRepository;

  Future<void> save(ProfileModel profile) async {
    final result = profile.id == 0
        ? await _profileRepository.register(profile)
        : await _profileRepository.update(profile);

    switch (result) {
      case Right(value: ProfileModel model):
        _data.add(model);
        showSuccess('Seu perfil foi cadastrado com sucesso');
      case Right():
        if (profile.id > 0) {
          _deleteItem(profile.id);
        }
        _data.add(profile);
        showSuccess('Seu perfil foi alterado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o seu perfil');
    }
  }

  void _deleteItem(int id) {
    _data.removeWhere((item) => item.id == id);
  }

  Future<void> findClients() async {
    _data.clear();
    final results = await _profileRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> clients):
        for (var client in clients) {
          _data.add(TransformJson.fromJson(client));
        }

      case Left():
        showError('Houver erro ao buscar o cliente');
    }
  }
}
