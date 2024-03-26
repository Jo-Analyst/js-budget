import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/profile_model.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:signals/signals.dart';

class ProfileController with Messages {
  ProfileController({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  var model = signal<ProfileModel?>(null);

  final ProfileRepository _profileRepository;

  Future<void> save(ProfileModel profile) async {
    final result = profile.id == 0
        ? await _profileRepository.register(profile)
        : await _profileRepository.update(profile);

    switch (result) {
      case Right(value: ProfileModel? profileModel):
        model.value = profileModel;
      case Right():
        model.value = profile;
        showSuccess('Seu perfil foi alterado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o seu perfil');
    }
  }

  Future<void> findProfile() async {
    final results = await _profileRepository.find();

    switch (results) {
      case Right(value: ProfileModel profile):
        model.value = profile;
      case Right(value: _):
        model.value = null;
      case Left():
        showError('Houver erro ao buscar o seu perfil');
    }
  }
}
