import 'package:cinemapedia_app/presentation/screens.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String id = 'id';
  static const String home = 'home';
  static const String page = 'page';
  static const String movie = 'movie';
  static const String notId = 'no-id';

  static String getMovieInfoPath({required String movieId, int pageIndex = 0}) {
    return '/$home/:$page/$movie/$movieId';
  }

  static String getHomeRoutePath(int page) {
    return '/$home/:$page';
  }

  final appRouter = GoRouter(
    initialLocation: '/$home/:$page',
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/$home/0',
      ),
      GoRoute(
        path: '/$home/:$page',
        name: HomeScreen.name,
        builder: (context, state) {
          final int pagePath =
              int.tryParse(state.pathParameters[page].toString()) ?? 0;

          return HomeScreen(page: pagePath);
        },
        routes: [
          GoRoute(
            path: '$movie/:$id',
            name: MovieInfoScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters[id] ?? notId;
              return MovieInfoScreen(movieId: movieId);
            },
          ),
        ],
      ),
    ],
  );
}
