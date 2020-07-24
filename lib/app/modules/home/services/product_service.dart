import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/errors/errors.dart';
import '../models/product_model.dart';
import '../repositories/interfaces/product_repository_interface.dart';
import 'interfaces/product_service_interface.dart';

part 'product_service.g.dart';

@Injectable()
class ProductService implements IProductService {
  final IProductRepository _productRepository;

  ProductService(this._productRepository);
  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Future<Either<Failure, bool>> active(int id) {
    return _productRepository.active(id);
  }

  @override
  Future<Either<Failure, bool>> delete(int id) {
    return _productRepository.delete(id);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> get() {
    return _productRepository.get();
  }

  @override
  Future<Either<Failure, ProductModel>> getById(int id) {
    return _productRepository.getById(id);
  }

  @override
  Future<Either<Failure, int>> post(ProductModel product) {
    return _productRepository.post(product);
  }

  @override
  Future<Either<Failure, bool>> put(ProductModel product) {
    return _productRepository.put(product);
  }

  @override
  Future<Either<Failure, String>> downloadPdf() {
    return _productRepository.downloadPdf();
  }
}
