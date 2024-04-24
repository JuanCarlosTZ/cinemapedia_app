import 'package:cinemapedia_app/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActors({required String movieId});
}
