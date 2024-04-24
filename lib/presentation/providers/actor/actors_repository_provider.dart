import 'package:cinemapedia_app/domain/repositories/actors_repository.dart';
import 'package:cinemapedia_app/infrastructure/datasources/tmdb_actors_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/actor_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider<ActorsRepository>((ref) {
  final datasource = TmdbActorsDatasource();
  final repository = ActorRepositoryImpl(datasource: datasource);
  return repository;
});
