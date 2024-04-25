// To parse this JSON data, do
//
//     final theMoviedbPagenated = theMoviedbPagenatedFromJson(jsonString);

import 'dart:convert';

import 'package:cinemapedia_app/infrastructure/models/movie/the_moviedb_model.dart';

TheMoviedbPagenatedModel theMoviedbPagenatedFromJson(String str) =>
    TheMoviedbPagenatedModel.fromJson(json.decode(str));

String theMoviedbPagenatedToJson(TheMoviedbPagenatedModel data) =>
    json.encode(data.toJson());

class TheMoviedbPagenatedModel {
  final Dates? dates;
  final int page;
  final List<TheMoviedbModel> theMoviedbModelList;
  final int totalPages;
  final int totalResults;

  TheMoviedbPagenatedModel({
    required this.dates,
    required this.page,
    required this.theMoviedbModelList,
    required this.totalPages,
    required this.totalResults,
  });

  factory TheMoviedbPagenatedModel.fromJson(Map<String, dynamic> json) =>
      TheMoviedbPagenatedModel(
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        page: json["page"],
        theMoviedbModelList: List<TheMoviedbModel>.from(
            json["results"].map((x) => TheMoviedbModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<TheMoviedbModel>.from(
            theMoviedbModelList.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
