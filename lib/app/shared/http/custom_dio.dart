import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'interceptors/cache_interceptor.dart';

import 'interceptors/custom_interceptor.dart';

part 'custom_dio.g.dart';

@Injectable()
class CustomDio extends DioForNative {
  CustomDio([BaseOptions options]) : super(options) {
    interceptors.add(CustomInterceptors());
    interceptors.add(CacheInterceptor());
  }
}
