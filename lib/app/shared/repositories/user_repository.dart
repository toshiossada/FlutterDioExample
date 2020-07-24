import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../errors/errors.dart';
import '../models/authenticate_model.dart';
import '../models/user_model.dart';
import 'interfaces/user_repository_interface.dart';

part 'user_repository.g.dart';

@Injectable()
class UserRepository implements IUserRepository {
  final DioForNative _client;

  UserRepository(this._client);

  @override
  void dispose() {}

  @override
  Future<Either<Failure, UserModel>> login(AuthenticateModel login) async {
    try {
      var response = await _client.post('/user/login', data: login.toJson());
      var result = UserModel.fromJson(response.data);
      return Right(result);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }
}
