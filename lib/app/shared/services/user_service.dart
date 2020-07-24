import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../errors/errors.dart';
import '../models/authenticate_model.dart';
import '../models/user_model.dart';
import '../repositories/interfaces/user_repository_interface.dart';
import 'interfaces/user_service_interface.dart';
import 'local_storage_service.dart';

part 'user_service.g.dart';

@Injectable()
class UserService implements IUserService {
  final IUserRepository _userRepository;

  UserService(this._userRepository);
  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Future<UserModel> getCurrentUser() async {
    var contains = await LocalStorageService.cointains('current_user');
    if (contains) {
      var res = jsonDecode(
          await LocalStorageService.getValue<String>('current_user'));
      return UserModel.fromJson(res);
    } else {
      return null;
    }
  }

  @override
  Future<void> saveLocalDB(UserModel user) async {
    LocalStorageService.setValue<String>(
        'current_user', jsonEncode(user.toJson()));
  }

  @override
  Future<Either<Failure, UserModel>> login(AuthenticateModel login) async {
    var result = await _userRepository.login(login);

    return result;
  }
}
