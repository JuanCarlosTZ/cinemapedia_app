import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia_app/config/constants/assets_images_app.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';

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
      body: FadeIn(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
                leading: CustomIconAction(onPressed: context.pop),
                expandedHeight: 0.7 * size.height,
                flexibleSpace: _CustomSliverAppbar(movie: movie)),
            SliverList(
                delegate:
                    SliverChildBuilderDelegate(childCount: 1, (context, index) {
              return SafeArea(top: false, child: _CustomSliverItem(movie));
            })),
          ],
        ),
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

class _CustomSliverAppbar extends ConsumerStatefulWidget {
  final Movie movie;
  const _CustomSliverAppbar({required this.movie});

  @override
  _CustomSliverAppbarState createState() => _CustomSliverAppbarState();
}

class _CustomSliverAppbarState extends ConsumerState<_CustomSliverAppbar> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    ref.read(isFavoriteProvider(widget.movie.id)).then((value) {
      setState(() {
        isFavorite = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movie.posterPath == null) {
      return Image.asset(
        AssetsImagesApp.noPoster01,
        fit: BoxFit.cover,
        height: double.infinity,
      );
    }

    return Stack(fit: StackFit.expand, children: [
      Image.network(
        widget.movie.posterPath!,
        fit: BoxFit.cover,
        height: double.infinity,
      ),
      Positioned(
          bottom: 60,
          right: 20,
          child: CustomIconAction(
            color: isFavorite ? Colors.red : Colors.white,
            backgroundColor: Colors.black26,
            icon: isFavorite == true
                ? Icons.favorite_rounded
                : Icons.favorite_outline,
            onPressed: () async {
              final tougleFavorite =
                  await ref.read(tougleFavoriteProvider(widget.movie));
              await ref.read(localMoviesProvider.notifier).resetPage();

              setState(() {
                isFavorite = tougleFavorite;
              });
            },
          )),
    ]);
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
          MovieDescriptionView(movie: movie),
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
