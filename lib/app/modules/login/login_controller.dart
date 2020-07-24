import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../shared/components/loading_dialog.dart';
import '../../shared/models/authenticate_model.dart';
import '../../shared/services/interfaces/user_service_interface.dart';
import '../../shared/stores/user_store.dart';

part 'login_controller.g.dart';

@Injectable(singleton: false)
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final ILoadingDialog _loading;
  final IUserService _userService;
  final UserStore userStore;

  @observable
  String login;
  @observable
  String password;

  _LoginControllerBase(this._loading, this._userService, this.userStore);
  @computed
  AuthenticateModel get credential =>
      AuthenticateModel(login: login, password: password);

  @computed
  bool get isValid => credential.isValidEmail && credential.isValidPassword;

  @action
  void setLogin(String v) => login = v;
  @action
  void setPassword(String v) => password = v;

  Future<void> authenticate() async {
    _loading.show();
    await Future.delayed(Duration(seconds: 1));
    var result = await _userService.login(credential);
    await _loading.hide();
    result.fold((failure) {
      asuka.showSnackBar(SnackBar(content: Text(failure.message)));
    }, (user) {
      userStore.setUser(user);
      Modular.to.pushReplacementNamed('/home');
    });
  }
}
