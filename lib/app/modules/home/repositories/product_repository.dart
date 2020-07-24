import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/errors/errors.dart';
import '../models/product_model.dart';
import 'interfaces/product_repository_interface.dart';

part 'product_repository.g.dart';

@Injectable()
class ProductRepository implements IProductRepository {
  final DioForNative _client;

  ProductRepository(this._client);

  @override
  void dispose() {}

  @override
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      var _ = await _client.delete('/products/$id');
      return Right(true);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> get() async {
    try {
      var response = await _client.get('/products',
          options: Options(extra: {"refresh": true}));
      var result = (response.data as List).map((item) {
        return ProductModel.fromJson(item);
      }).toList();

      return Right(result);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getById(int id) async {
    try {
      var response = await _client.get('/products/$id');
      var result = ProductModel.fromJson(response.data);
      return Right(result);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }

  @override
  Future<Either<Failure, int>> post(ProductModel product) async {
    try {
      var response = await _client.post('/products', data: product.toJson());
      return Right(response.data["id"]);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> active(int id) async {
    try {
      var _ = await _client.patch('/products/$id');
      return Right(true);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> put(ProductModel product) async {
    try {
      var _ = await _client.post('/products', data: product.toJson());
      return Right(true);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> downloadPdf() async {
    try {
      var appDocDir = await getApplicationDocumentsDirectory();
      var appDocPath = '${appDocDir.path}/teste.pdf';
      await _client.download(
        'http://www.rrsantos.com.br/holerite/holerite.pdf',
        appDocPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
        deleteOnError: true,
      );

      return Right(appDocPath);
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response.data, statusCode: err.response.statusCode));
    }
  }
}
