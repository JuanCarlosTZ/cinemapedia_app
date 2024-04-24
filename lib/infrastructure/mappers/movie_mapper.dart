import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/the_moviedb_model.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/the_moviedb_paginated_model.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/tmdb_movie_details_model.dart';

class MovieMapper {
  static Movie tmdbMovieDetailsModelToEntity(
          TmdbMovieDetailsModel tmdbMovieDetailsModel) =>
      Movie(
        adult: tmdbMovieDetailsModel.adult,
        backdropPath: (tmdbMovieDetailsModel.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovieDetailsModel.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds:
            tmdbMovieDetailsModel.genres.map((gender) => gender.name).toList(),
        id: tmdbMovieDetailsModel.id,
        originalLanguage: tmdbMovieDetailsModel.originalLanguage,
        originalTitle: tmdbMovieDetailsModel.originalTitle,
        overview: tmdbMovieDetailsModel.overview,
        popularity: tmdbMovieDetailsModel.popularity,
        posterPath: (tmdbMovieDetailsModel.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovieDetailsModel.posterPath}'
            : '',
        releaseDate: tmdbMovieDetailsModel.releaseDate,
        title: tmdbMovieDetailsModel.title,
        video: tmdbMovieDetailsModel.video,
        voteAverage: tmdbMovieDetailsModel.voteAverage,
        voteCount: tmdbMovieDetailsModel.voteCount,
      );

  static Movie theMoviedbModelToEntity(TheMoviedbModel theMoviedbModel) =>
      Movie(
        adult: theMoviedbModel.adult,
        backdropPath: (theMoviedbModel.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${theMoviedbModel.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: theMoviedbModel.genreIds
            .map((genderId) => genderId.toString())
            .toList(),
        id: theMoviedbModel.id,
        originalLanguage: theMoviedbModel.originalLanguage,
        originalTitle: theMoviedbModel.originalTitle,
        overview: '', // theMoviedbModel.overview,
        popularity: theMoviedbModel.popularity,
        posterPath: (theMoviedbModel.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${theMoviedbModel.posterPath}'
            : '',
        releaseDate: theMoviedbModel.releaseDate,
        title: theMoviedbModel.title,
        video: theMoviedbModel.video,
        voteAverage: theMoviedbModel.voteAverage,
        voteCount: theMoviedbModel.voteCount,
      );

  static List<Movie> theMoviedbPaginatedToListEntity(
      TheMoviedbPagenatedModel moviePaginatedModel) {
    return moviePaginatedModel.theMoviedbModelList
        .map((theMoviedbModel) =>
            MovieMapper.theMoviedbModelToEntity(theMoviedbModel))
        .toList();
  }
}
