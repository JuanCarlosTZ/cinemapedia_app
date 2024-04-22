import 'package:flutter/material.dart';

class MovieInfoScreen extends StatelessWidget {
  static String name = 'movie_info_screen';
  static String idPath = 'id';
  final String movieId;
  const MovieInfoScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Detalles {$movieId}'),
      ),
    );
  }
}
