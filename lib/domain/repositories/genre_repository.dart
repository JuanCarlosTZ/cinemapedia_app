import 'package:cinemapedia_app/domain/entities/genre.dart';

abstract class GenreRepository {
  Future<List<Genre>> getGenres();
}
