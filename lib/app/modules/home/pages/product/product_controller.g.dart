// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ProductController = BindInject(
  (i) => ProductController(i<IProductService>(), id: i.args.params['id']),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductController on _ProductControllerBase, Store {
  Computed<ProductModel> _$productComputed;

  @override
  ProductModel get product =>
      (_$productComputed ??= Computed<ProductModel>(() => super.product,
              name: '_ProductControllerBase.product'))
          .value;
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_ProductControllerBase.isValid'))
      .value;

  final _$idProductAtom = Atom(name: '_ProductControllerBase.idProduct');

  @override
  int get idProduct {
    _$idProductAtom.reportRead();
    return super.idProduct;
  }

  @override
  set idProduct(int value) {
    _$idProductAtom.reportWrite(value, super.idProduct, () {
      super.idProduct = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_ProductControllerBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProductControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('_ProductControllerBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$_ProductControllerBaseActionController =
      ActionController(name: '_ProductControllerBase');

  @override
  void setDescription(String v) {
    final _$actionInfo = _$_ProductControllerBaseActionController.startAction(
        name: '_ProductControllerBase.setDescription');
    try {
      return super.setDescription(v);
    } finally {
      _$_ProductControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
idProduct: ${idProduct},
description: ${description},
loading: ${loading},
product: ${product},
isValid: ${isValid}
    ''';
  }
}
