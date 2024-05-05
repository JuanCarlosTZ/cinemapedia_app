import 'package:cinemapedia_app/domain/entities/genre.dart';

abstract class GenreDatasource {
  Future<List<Genre>> getGenres();
}
