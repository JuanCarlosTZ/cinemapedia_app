import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/models/actor/tmdb_actors_response_model.dart';

class ActorMapper {
  static List<Actor> tmdbActorsResponseToEntity(TmdbActorsResponseModel json) {
    return json.cast
        .map((cast) => Actor(
              id: cast.id,
              name: cast.name,
              profilePath: cast.profilePath != null
                  ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
                  : '',
              character: cast.character,
            ))
        .toList();
  }
}
