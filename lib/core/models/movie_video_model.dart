// To parse this JSON data, do
//
//     final movieVideoModel = movieVideoModelFromJson(jsonString);

import 'dart:convert';

List<MovieVideoModel> moviesVideoModelFromJson(String str) =>
    List<MovieVideoModel>.from(
        json.decode(str).map((x) => MovieVideoModel.fromJson(x)));

String moviesVideoModelToJson(List<MovieVideoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

MovieVideoModel movieVideoModelFromJson(String str) =>
    MovieVideoModel.fromJson(json.decode(str));

String movieVideoModelToJson(MovieVideoModel data) =>
    json.encode(data.toJson());

class MovieVideoModel {
  MovieVideoModel({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  MovieVideoModel copyWith({
    required String iso6391,
    required String iso31661,
    required String name,
    required String key,
    required String site,
    required int size,
    required String type,
    required bool official,
    required DateTime publishedAt,
    required String id,
  }) =>
      MovieVideoModel(
        iso6391: iso6391 ?? this.iso6391,
        iso31661: iso31661 ?? this.iso31661,
        name: name ?? this.name,
        key: key ?? this.key,
        site: site ?? this.site,
        size: size ?? this.size,
        type: type ?? this.type,
        official: official ?? this.official,
        publishedAt: publishedAt ?? this.publishedAt,
        id: id ?? this.id,
      );

  factory MovieVideoModel.fromJson(Map<String, dynamic> json) =>
      MovieVideoModel(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
      };
}
