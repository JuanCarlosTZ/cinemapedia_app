import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/widgets/actor/horizontal_listview_actor.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_image_view.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custon_back_action.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

class MovieInfoScreen extends ConsumerStatefulWidget {
  static String name = 'movie_info_screen';
  final String movieId;
  const MovieInfoScreen({super.key, required this.movieId});

  @override
  MovieInfoScreenState createState() => MovieInfoScreenState();
}

class MovieInfoScreenState extends ConsumerState<MovieInfoScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailProvider.notifier).loadMovieById(widget.movieId);
    ref.read(actorsProvider.notifier).loadActors(widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final movieProvider = ref.watch(movieDetailProvider);
    final movie = movieProvider[widget.movieId];

    if (movie == null) return _Loading();

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
              leading: CustonBackAction(onPressed: context.pop),
              expandedHeight: 0.7 * size.height,
              flexibleSpace: _CustomSliverAppbar(url: movie.posterPath)),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: 1, (context, index) {
            return _CustomSliverItem(movie);
          })),
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

class _CustomSliverAppbar extends StatelessWidget {
  final String url;
  const _CustomSliverAppbar({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      height: double.infinity,
    );
  }
}

class _CustomSliverItem extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverItem(this.movie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorsProvider)[movie.id.toString()];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Descripcion
          _CardView(movie: movie),
          const SizedBox(height: 30),

          //* Generos
          Wrap(
            spacing: 10,
            children: [
              ...movie.genreIds.map((String genre) => Chip(label: Text(genre)))
            ],
          ),
          const Divider(),

          //* Actores
          HorizontalListviewActor(
            title: 'Actores',
            header: actors?.length.toString(),
            actors: actors ?? [],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _CardView extends StatelessWidget {
  final Movie movie;
  const _CardView({required this.movie});

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* imagen
        SizedBox(
          width: (0.3 * sizes.width - 20),
          child: CustomImageView(
            movie.posterPath,
          ),
        ),
        const SizedBox(width: 10),

        //* Texto
        SizedBox(
            width: 0.7 * sizes.width - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Titulo
                Text(
                  movie.title,
                  style: style.titleLarge,
                  softWrap: true,
                ),
                const SizedBox(height: 5),

                //* Resumen
                Text(
                  movie.overview,
                  style: style.bodyLarge,
                  softWrap: true,
                ),
              ],
            ))
      ],
    );
  }
}
