import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class MapSearchMoviesNotifier extends StateNotifier<Map<String, List<Movie>>> {
  final SearchMoviesCallback searchMoviesCallback;

  MapSearchMoviesNotifier(this.searchMoviesCallback) : super({'': []});

  Future<List<Movie>> loadSearchMovies(String query) async {
    if ((state.containsKey(query))) {
      final movies = state[query] ?? [];
      final lastElement = {query: movies};
      final newState = state;

      newState.removeWhere((key, value) => key == query);
      state = {...newState, ...lastElement};

      return movies;
    }

    final movies = await searchMoviesCallback(query);

    state = (state.entries.length > 10)
        ? {query: movies}
        : {...state, query: movies};

    return movies;
  }
}

final searchMoviesProvider =
    StateNotifierProvider<MapSearchMoviesNotifier, Map<String, List<Movie>>>(
        (ref) {
  final movieRepository = ref.read(theMoviedbRepositoryProvider);
  return MapSearchMoviesNotifier(movieRepository.getSearch);
});
