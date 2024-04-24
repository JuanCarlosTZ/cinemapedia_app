import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
string, List<Actor>
'434234': [Actor],
'434234': [Actor],
'434234': [Actor],
'434234': [Actor],
*/

typedef ActorCallBack = Future<List<Actor>> Function({required String movieId});

class MapActorsNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final ActorCallBack getActorsCallBack;
  MapActorsNotifier({required this.getActorsCallBack}) : super({});

  Future<List<Actor>> loadActors(String movieId) async {
    if (state[movieId] != null) return state[movieId]!;

    final actors = await getActorsCallBack(movieId: movieId);

    state = {...state, movieId: actors};

    return actors;
  }
}

final actorsProvider =
    StateNotifierProvider<MapActorsNotifier, Map<String, List<Actor>>>((ref) {
  final repository = ref.watch(actorRepositoryProvider);

  return MapActorsNotifier(getActorsCallBack: repository.getActors);
});
