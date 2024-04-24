import 'package:cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActors({required String movieId}) async {
    return await datasource.getActors(movieId: movieId);
  }
}
