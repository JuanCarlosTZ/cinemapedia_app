import 'package:cinemapedia_app/presentation/providers/video/tmdb_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final traillerProvider = StateProvider.family((ref, String movieId) async {
  final repository = ref.watch(tmdbVideoRepository);
  return await repository.loadVideos(movieId);
});
