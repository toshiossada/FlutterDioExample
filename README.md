Para mockar a API utilizei o **mockoon** (https://mockoon.com/), basta importar o arquivo **mockoon.json** dentro do **mockoon**
Rodar flutter pub get 


Trocar baseUrl no app_module.dart apontando para o endereço da sua API
```class AppModule extends MainModule {
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
        Router(Modular.initialRoute, module: LoginModule()),
        Router('/home', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
```
