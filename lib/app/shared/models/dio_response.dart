import 'dart:convert';

class DioResponse {
  DioResponse({
    this.data,
    this.expire,
  });

  final dynamic data;
  final DateTime expire;
  bool get expired => expire.difference(DateTime.now()).inMinutes < 0;

  DioResponse copyWith({
    dynamic data,
    DateTime expire,
  }) =>
      DioResponse(
        data: data ?? this.data,
        expire: expire ?? this.expire,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "data": data,
        "expire": expire.toString(),
      };

  factory DioResponse.fromRawJson(String str) =>
      DioResponse.fromJson(json.decode(str));

  factory DioResponse.fromJson(Map<String, dynamic> json) => DioResponse(
        data: json["data"],
        expire: DateTime.parse(json["expire"]),
      );
}
