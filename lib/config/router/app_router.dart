import 'package:cinemapedia_app/presentation/screens.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'movie/:${MovieInfoScreen.idPath}',
            name: MovieInfoScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';
              return MovieInfoScreen(movieId: movieId);
            },
          ),
        ],
      ),
    ],
  );
}
