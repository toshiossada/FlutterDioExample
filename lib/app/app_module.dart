import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'shared/components/loading_dialog.dart';
import 'shared/http/custom_dio.dart';
import 'shared/repositories/user_repository.dart';
import 'shared/services/user_service.dart';
import 'shared/stores/user_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $UserStore,
        $UserService,
        $UserRepository,
        $AppController,
        $CustomDio,
        $LoadingDialog,
        Bind(
          (i) => BaseOptions(
            baseUrl: 'http://192.168.15.12:3001/',
            connectTimeout: 5000,
          ),
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
        Router('/home', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
