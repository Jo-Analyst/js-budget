import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/profile_model.dart';

abstract interface class ProfileRepository {
  Future<Either<RespositoryException, ProfileModel>> register(
      ProfileModel profile);
  Future<Either<RespositoryException, Unit>> update(ProfileModel profile);
  Future<Either<RespositoryException, ProfileModel?>> find();
}
