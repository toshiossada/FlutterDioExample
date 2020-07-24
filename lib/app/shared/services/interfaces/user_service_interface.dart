import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../errors/errors.dart';
import '../../models/authenticate_model.dart';
import '../../models/user_model.dart';

abstract class IUserService implements Disposable {
  Future<UserModel> getCurrentUser();
  Future<void> saveLocalDB(UserModel user);
  Future<Either<Failure, UserModel>> login(AuthenticateModel login);
}
