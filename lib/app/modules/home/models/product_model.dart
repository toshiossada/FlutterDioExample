// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

class ProductModel {
  ProductModel({
    this.id,
    this.description,
  });

  final int id;
  final String description;

  ProductModel copyWith({
    int id,
    String description,
  }) =>
      ProductModel(
        id: id ?? this.id,
        description: description ?? this.description,
      );

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };

  bool get isValidDescription =>
      description != null && description.isNotEmpty && description.length > 3;
}
