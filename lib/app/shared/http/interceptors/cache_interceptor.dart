import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/dio_response.dart';
import '../../services/local_storage_service.dart';

class CacheInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    print('Request[${options.method}] => PATH: ${options.path}');

    var uri = options.uri;

    if (options.extra.containsKey('refresh')) {
      var cache = await _getCache(uri);

      if (options.extra['refresh'] && cache == null) {
        return super.onRequest(options);
      } else {
        var data = await _getCache(uri);

        if (data != null && !data.expired) {
          return Response(data: data.data, statusCode: 200);
        } else {
          return super.onRequest(options);
        }
      }
    }

    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    print('Response[${response.statusCode}] => PATH: ${response.request.path}');
    if (response.request.extra.containsKey('refresh') &&
        response.request.extra['refresh']) {
      var cache = await _getCache(response.request.uri);

      if (cache == null || cache.expired) {
        save(response.request.uri.toString(), response.data);
      }
    }
    return super.onResponse(response);
  }

  Future<DioResponse> _getCache(Uri uri) async {
    var containsCache = await LocalStorageService.cointains(uri.toString());
    if (containsCache) {
      var data = await LocalStorageService.getValue<String>(uri.toString());
      var expire = await LocalStorageService.getValue<String>('${uri}_expire');
      var json = jsonDecode("$data");
      var res = DioResponse(data: json, expire: DateTime.parse(expire));
      debugPrint("Recuperando do Cache $uri");

      return res;
    } else {
      return null;
    }
  }

  void save(String uri, dynamic data) {
    var dateTime = DateTime.now().add(Duration(minutes: 1));
    LocalStorageService.setValue<String>(uri, jsonEncode(data));
    LocalStorageService.setValue<String>('${uri}_expire', dateTime.toString());
    debugPrint("Atualizando em cache $uri");
  }
}
