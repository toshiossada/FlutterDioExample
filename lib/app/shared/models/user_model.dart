// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    this.login,
    this.token,
    this.refreshToken,
    this.password,
  });

  final String login;
  final String password;
  final String token;
  final String refreshToken;

  UserModel copyWith({
    String login,
    String token,
    String refreshToken,
    String password,
  }) =>
      UserModel(
        login: login ?? this.login,
        token: token ?? this.token,
        refreshToken: refreshToken ?? this.refreshToken,
        password: password ?? this.password,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        login: json["login"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "token": token,
        "password": password,
        "refreshToken": refreshToken,
      };
}
