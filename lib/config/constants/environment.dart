import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final datasourceConfiguration = _DatasourceConfiguration(
    apiKey: dotenv.env['THE_MOVIEDB_KEY'] ?? "Don'n apiKey found",
    baseUrl: "https://api.themoviedb.org/3",
  );
}

class _DatasourceConfiguration {
  final String apiKey;
  final String baseUrl;

  _DatasourceConfiguration({required this.apiKey, required this.baseUrl});
}
