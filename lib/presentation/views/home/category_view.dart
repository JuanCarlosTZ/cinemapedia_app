import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/category/tmdb_categories_provider.dart';
import 'package:cinemapedia_app/presentation/providers/movie/movies_category_provider.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cinemapedia_app/config/constants/navigation_parameters.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_poster_item_view.dart';

class CategoryView extends ConsumerStatefulWidget {
  const CategoryView({super.key});

  @override
  CategoryViewState createState() => CategoryViewState();
}

class CategoryViewState extends ConsumerState<CategoryView> {
  late final ScrollController controller;
  bool expandedCategories = true;

  @override
  void initState() {
    super.initState();
    if (ref.read(localMoviesProvider).isEmpty) {
      ref.read(moviesCategoryProvider.notifier).loadNextPage();
    }

    controller = ScrollController();
    controller.addListener(() {
      final movies = ref.read(moviesCategoryProvider);
      if (movies.isEmpty) {
        return;
      }
      if (controller.position.pixels + 200 >
          controller.position.maxScrollExtent) {
        final category = ref.watch(categoryProvider);

        final categotyIds = category == null ? null : [category.id];

        ref
            .read(moviesCategoryProvider.notifier)
            .loadNextPage(categoryIds: categotyIds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = ref.watch(moviesCategoryProvider);
    final categoriesFuture = ref.watch(categoriesProvider);
    final category = ref.watch(categoryProvider);
    final expansionController = ref.watch(categoryControllerProvider);
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: FutureBuilder(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.red,
              ),
            );
          }
          final categories = snapshot.data ?? [];

          return Column(
            children: [
              //Selector de catagoria
              SafeArea(
                child: ExpansionTile(
                  initiallyExpanded: expandedCategories,
                  controller: expansionController,
                  onExpansionChanged: (value) => setState(() {
                    expandedCategories = value;
                  }),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Categoría', style: textStyle.bodyMedium),
                      Text(category?.caption ?? 'Accion',
                          style: textStyle.headlineSmall),
                    ],
                  ),
                ),
              ),

              //Vista categorias o movies por categorias
              Expanded(
                child: IndexedStack(
                  index: expandedCategories ? 0 : 1,
                  children: [
                    ListView(
                      padding: const EdgeInsets.only(top: 0),
                      children: [
                        ...categories.map((category) => ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              onTap: () async {
                                ref
                                    .watch(categoryProvider.notifier)
                                    .update((state) => category);

                                await ref
                                    .watch(moviesCategoryProvider.notifier)
                                    .reset(categoryIds: [category.id]);
                                expansionController.collapse();

                                setState(() {});
                              },
                              title: Center(child: Text(category.caption)),
                            ))
                      ],
                    ),
                    _MovieItems(
                        animate: !expandedCategories,
                        controller: controller,
                        moviesProvider: moviesProvider),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MovieItems extends StatelessWidget {
  const _MovieItems({
    required this.controller,
    required this.animate,
    required this.moviesProvider,
  });

  final bool animate;
  final ScrollController controller;
  final List<Movie> moviesProvider;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      animate: animate,
      child: MasonryGridView.count(
        padding: const EdgeInsets.only(top: 0),
        controller: controller,
        itemCount: moviesProvider.length,
        crossAxisCount: 3,
        itemBuilder: (context, index) {
          final movie = moviesProvider[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: CustomPosterItemView(
              movie: movie,
              page: NavigationParameters.upcomingView,
            ),
          );
        },
      ),
    );
  }
}
