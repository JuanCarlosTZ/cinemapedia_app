import 'package:flutter/material.dart';

class CustomNavigationBottom extends StatefulWidget {
  const CustomNavigationBottom({super.key});

  @override
  State<CustomNavigationBottom> createState() => _CustomNavigationBottomState();
}

class _CustomNavigationBottomState extends State<CustomNavigationBottom> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: indexSelected,
      onTap: (value) {
        setState(() {
          indexSelected = value;
        });
      },
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.label),
          icon: Icon(Icons.label_outline),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
