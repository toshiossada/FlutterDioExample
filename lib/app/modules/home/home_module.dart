import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_page.dart';
import 'pages/product/product_controller.dart';
import 'pages/product/product_page.dart';
import 'repositories/product_repository.dart';
import 'services/product_service.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ProductController,
        $ProductService,
        $ProductRepository,
        $HomeController,
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
        Router('/product/:id', child: (_, args) => ProductPage()),
        Router('/product', child: (_, args) => ProductPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
