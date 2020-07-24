import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/errors/errors.dart';
import '../../models/product_model.dart';

abstract class IProductService implements Disposable {
  Future<Either<Failure, List<ProductModel>>> get();
  Future<Either<Failure, ProductModel>> getById(int i);

  Future<Either<Failure, bool>> put(ProductModel product);
  Future<Either<Failure, int>> post(ProductModel product);
  Future<Either<Failure, bool>> delete(int id);
  Future<Either<Failure, bool>> active(int id);
}
