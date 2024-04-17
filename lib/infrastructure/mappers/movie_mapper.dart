import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/the_moviedb_model.dart';

class MovieMapper {
  static Movie theMoviedbModelToEntity(TheMoviedbModel theMoviedbModel) =>
      Movie(
        adult: theMoviedbModel.adult,
        backdropPath: theMoviedbModel.backdropPath,
        genreIds: theMoviedbModel.genreIds
            .map((genderId) => genderId.toString())
            .toList(),
        id: theMoviedbModel.id,
        originalLanguage: theMoviedbModel.originalLanguage,
        originalTitle: theMoviedbModel.originalTitle,
        overview: theMoviedbModel.overview,
        popularity: theMoviedbModel.popularity,
        posterPath: theMoviedbModel.posterPath ?? "",
        releaseDate: theMoviedbModel.releaseDate,
        title: theMoviedbModel.title,
        video: theMoviedbModel.video,
        voteAverage: theMoviedbModel.voteAverage,
        voteCount: theMoviedbModel.voteCount,
      );
}
