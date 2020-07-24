import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/authenticate_model.dart';
import '../../services/interfaces/user_service_interface.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    var userService = Modular.get<IUserService>();
    var user = await userService.getCurrentUser();
    var path = options.path;

    if (path != 'users/login' && path != 'users/forgotPassword') {
      if (user?.token != null && user.token.isNotEmpty) {
        var headerAuth = genToken(user.token);
        options.headers['Authorization'] = headerAuth;
      }
    }
    if (kDebugMode) {
      debugPrint(json.encode("BaseURL: ${options.baseUrl}"));
      debugPrint(json.encode("Endpoint: ${options.path}"));
      if (options.headers['Authorization'] != null) {
        debugPrint("Authorization: ${options.headers['Authorization']}");
      }
      if (options.data != null) {
        debugPrint("Payload ${json.encode(options.data)}");
      }
    }

    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    if (err.response.statusCode == 401) {
      var dio = Modular.get<DioForNative>();
      var userService = Modular.get<IUserService>();
      var user = await userService.getCurrentUser();
      if (user != null && err.response.statusCode == 401) {
        var options = err.response.request;

        if (user.token == options.headers['Authorization']) {
          options.headers['Authorization'] = user.token;
          return dio.request(options.path, options: options);
        }
        dio.lock();
        dio.interceptors.responseLock.lock();
        dio.interceptors.errorLock.lock();

        return userService
            .login(
                AuthenticateModel(login: user.login, password: user.password))
            .then((result) {
          result.fold(
            (_) {},
            (user) {
              var _newToken = user.token;

              if (_newToken != null && _newToken.isNotEmpty) {
                var headerAuth = genToken(_newToken);
                options.headers['Authorization'] = headerAuth;
              }
            },
          );
        }).whenComplete(() {
          dio.unlock();
          dio.interceptors.responseLock.unlock();
          dio.interceptors.errorLock.unlock();
        }).then((e) => dio.request(options.path, options: options));
      }
    } else {
      throw err;
    }
  }

  String genToken(String token) {
    return 'Bearer $token';
  }
}
