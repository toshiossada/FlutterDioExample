import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../models/product_model.dart';
import '../../services/interfaces/product_service_interface.dart';

part 'product_controller.g.dart';

@Injectable()
class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {
  final String id;
  final IProductService _productService;

  _ProductControllerBase(this._productService, {@Param this.id}) {
    if (id != null && id != '-1') load();
  }
  TextEditingController txtDescricao = TextEditingController();

  @observable
  int idProduct;
  @observable
  String description;
  @observable
  bool loading = false;

  @computed
  ProductModel get product =>
      ProductModel(description: description, id: idProduct);

  @computed
  bool get isValid => product.isValidDescription;

  @action
  void setDescription(String v) => description = v;

  @action
  Future<void> load() async {
    loading = true;
    idProduct = int.parse(id);
    var result = await _productService.getById(1);

    result.fold((failure) {
      asuka.showSnackBar(SnackBar(content: Text(failure.message)));
      loading = false;
    }, (product) {
      description = product.description;
      txtDescricao.text = description;
      loading = false;
    });
  }

  save() {
    if (id != null && id != '-1') {
      _productService.put(product);
    } else {
      _productService.post(product);
    }
    Modular.to.pop();
    asuka.showSnackBar(SnackBar(content: Text('Salvo com sucesso')));
  }
}
