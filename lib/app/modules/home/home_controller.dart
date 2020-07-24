import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../shared/components/loading_dialog.dart';
import 'models/product_model.dart';
import 'services/interfaces/product_service_interface.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final IProductService _productService;
  //final ILoadingDialog _loading;

  _HomeControllerBase(this._productService);

  @observable
  ObservableList<ProductModel> listProducts;
  @observable
  bool loading = false;
  @action
  Future<void> load() async {
    //_loading.show();
    loading = true;
    await Future.delayed(Duration(seconds: 1));
    var result = await _productService.get();

    result.fold((failure) {
      asuka.showSnackBar(SnackBar(content: Text(failure.message)));
    }, (p) {
      listProducts = p.asObservable();
    });
    loading = false;
  }
}
