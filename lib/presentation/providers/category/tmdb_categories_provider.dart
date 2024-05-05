import 'package:cinemapedia_app/infrastructure/datasources/tmdb_genres_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/category_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tmdbCategoryRepository = Provider((ref) => CategoryRepositoryImpl(
      datasource: TmdbGenresDatasource(),
    ));
