import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cinemapedia_app/domain/datasources/local_storage_movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';

class LocalMoviesDatasource extends LocalStorageMoviesDatasource {
  late final Future<Isar> db;

  LocalMoviesDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return await Future.value(Isar.getInstance());
  }

  @override
  Future<List<Movie>> getFavorites({int limit = 10, int offset = 0}) async {
    final isar = await db;
    final movies =
        await isar.movies.where().offset(offset).limit(limit).findAll();
    return movies;
  }

  @override
  Future<bool> tougleFavorite(Movie movie) async {
    final isar = await db;

    final isFavorite = !isar.movies.filter().idEqualTo(movie.id).isEmptySync();

    if (isFavorite) {
      isar.writeTxnSync(
          () => isar.movies.filter().idEqualTo(movie.id).deleteAllSync());
      return Future.value(!isFavorite);
    }

    await isar.writeTxn(() async {
      await isar.movies.put(movie);
    });

    return Future.value(!isFavorite);
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final isar = await db;

    final isFavorite = !isar.movies.filter().idEqualTo(movieId).isEmptySync();

    return Future.value(isFavorite);
  }
}
