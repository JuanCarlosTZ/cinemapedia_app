class TmdbGenreResponseModel {
  final List<GenreModel> genres;

  TmdbGenreResponseModel({
    required this.genres,
  });

  factory TmdbGenreResponseModel.fromJson(Map<String, dynamic> json) =>
      TmdbGenreResponseModel(
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
