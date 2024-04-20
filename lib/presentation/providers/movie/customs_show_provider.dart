import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final swipeShowMoviesProvider = Provider<List<Movie>>((ref) {
  final movies = ref.watch(nowPlayingMoviesProvider);

  return movies.length > 6 ? movies.sublist(0, 6) : movies;
});
