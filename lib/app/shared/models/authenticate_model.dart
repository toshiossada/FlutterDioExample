import 'dart:convert';
import 'package:string_validator/string_validator.dart' as validator;

class AuthenticateModel {
  AuthenticateModel({
    this.login,
    this.password,
  });

  final String login;
  final String password;

  AuthenticateModel copyWith({
    String login,
    String password,
  }) =>
      AuthenticateModel(
        login: login ?? this.login,
        password: password ?? this.password,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "login": login,
        "password": password,
      };

  bool get isValidEmail => validator.isEmail(login ?? "");
  bool get isValidPassword =>
      password != null && password.isNotEmpty && password.length > 3;
}
