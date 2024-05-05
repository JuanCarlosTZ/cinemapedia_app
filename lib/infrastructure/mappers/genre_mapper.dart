import 'package:cinemapedia_app/domain/entities/genre.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/tmdb_gender_model.dart';

class GenreMapper {
  static List<Genre> tmdbGenresResponseToEntity(TmdbGenreResponseModel json) {
    return json.genres
        .map((genre) => Genre(
              id: genre.id,
              caption: genre.name,
            ))
        .toList();
  }
}
