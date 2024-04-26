import 'package:go_router/go_router.dart';

import 'package:cinemapedia_app/presentation/screens.dart';
import 'package:cinemapedia_app/presentation/views/views.dart';

class AppRouter {
  final appRouter = GoRouter(
    initialLocation: RouteLocationApp.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
              path: RouteLocationApp.home,
              name: HomeScreen.name,
              builder: (context, state) {
                return const HomeView();
              },
              routes: [
                GoRoute(
                  path: '${RouteLocationApp.movieInfo}/:id',
                  name: MovieInfoScreen.name,
                  builder: (context, state) {
                    return MovieInfoScreen(
                        movieId: state.pathParameters['id'] ?? '');
                  },
                ),
              ]),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesView(),
          )
        ],
      )

      // GoRoute(
      //   path: '/',
      //   name: HomeScreen.name,
      //   builder: (context, state) => const HomeScreen(),
      //   routes: [
      //     GoRoute(
      //       path: 'movie/:id',
      //       name: MovieInfoScreen.name,
      //       builder: (context, state) {
      //         final movieId = state.pathParameters['id'] ?? 'no-id';
      //         return MovieInfoScreen(movieId: movieId);
      //       },
      //     ),
      //   ],
      // ),
    ],
  );
}

class RouteLocationApp {
  static String home = '/';
  static String favorites = '/favorites';
  static String movieInfo = 'movie';
  static String categories = '/categories';
}
