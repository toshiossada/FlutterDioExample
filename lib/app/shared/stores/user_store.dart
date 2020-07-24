import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../models/user_model.dart';
import '../services/interfaces/user_service_interface.dart';

part 'user_store.g.dart';

@Injectable(singleton: false)
class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  final IUserService _userService;

  @observable
  UserModel user;

  _UserStoreBase(this._userService);
  @action
  void setUser(UserModel v) {
    user = v;
    _userService.saveLocalDB(v);
  }
}
