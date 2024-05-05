import 'package:cinemapedia_app/domain/datasources/genre_datasource.dart';
import 'package:cinemapedia_app/domain/entities/genre.dart';
import 'package:cinemapedia_app/domain/repositories/genre_repository.dart';

class CategoryRepositoryImpl extends GenreRepository {
  final GenreDatasource datasource;

  CategoryRepositoryImpl({required this.datasource});

  @override
  Future<List<Genre>> getGenres() async {
    return await datasource.getGenres();
  }
}
