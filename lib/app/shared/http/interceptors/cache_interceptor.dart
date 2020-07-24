import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/dio_response.dart';

class CacheInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    print('Request[${options.method}] => PATH: ${options.path}');

    var prefs = await SharedPreferences.getInstance();
    var uri = options.uri;
    var dateTime = DateTime.now().add(Duration(days: 1));

    if (options.extra.containsKey('refresh')) {
      if (options.extra['refresh'] && !prefs.containsKey(uri.toString())) {
        prefs.setString('${uri}_expire', dateTime.toString());
        return super.onRequest(options);
      } else {
        var data = await _getCache(uri);

        if (data != null && !data.expired) {
          return Response(data: data.data, statusCode: 200);
        } else {
          prefs.setString('${uri}_expire', dateTime.toString());
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
      var prefs = await SharedPreferences.getInstance();

      prefs.setString('${response.request.uri}', jsonEncode(response.data));
      debugPrint("Atualizando em cache ${response.request.uri}");
    }
    return super.onResponse(response);
  }

  Future<DioResponse> _getCache(Uri uri) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('$uri')) {
      var prf = prefs.getString('$uri');
      var expire = prefs.getString('${uri}_expire');
      var json = jsonDecode("$prf");
      var res = DioResponse(data: json, expire: DateTime.parse(expire));
      debugPrint("Recuperando do Cache $uri");

      return res;
    } else {
      return null;
    }
  }
}
