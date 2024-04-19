import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.movie_rounded),
            SizedBox(width: 5),
            Text('Cinemapidia'),
            Spacer(),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}
