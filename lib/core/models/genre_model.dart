// To parse this JSON data, do
//
//     final genreModel = genreModelFromJson(jsonString);

import 'dart:convert';

List<GenreModel> genresModelFromJson(String str) =>
    List<GenreModel>.from(json.decode(str).map((x) => GenreModel.fromJson(x)));

String genresModelToJson(List<GenreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

GenreModel genreModelFromJson(String str) =>
    GenreModel.fromJson(json.decode(str));

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

class GenreModel {
  GenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  GenreModel copyWith({
    required int id,
    required String name,
  }) =>
      GenreModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
