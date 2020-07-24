import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../errors/errors.dart';
import '../models/authenticate_model.dart';
import '../models/user_model.dart';
import '../repositories/interfaces/user_repository_interface.dart';
import 'interfaces/user_service_interface.dart';

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
    await Future.delayed(Duration(seconds: 2));
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      var res = jsonDecode(prefs.getString('current_user'));
      return UserModel.fromJson(res);
    } else {
      return null;
    }
  }

  Future<void> saveLocalDB(UserModel user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('current_user', jsonEncode(user.toJson()));
  }

  @override
  Future<Either<Failure, UserModel>> login(AuthenticateModel login) async {
    var result = await _userRepository.login(login);

    return result;
  }
}
