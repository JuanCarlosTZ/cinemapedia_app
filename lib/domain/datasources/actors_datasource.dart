import 'package:cinemapedia_app/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActors({required String movieId});
}
