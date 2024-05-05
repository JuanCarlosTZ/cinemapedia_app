import 'package:cinemapedia_app/infrastructure/datasources/tmdb_video_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/video_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tmdbVideoRepository =
    Provider((ref) => VideoRepositoryImp(datasource: TmdbVideoDatasource()));
