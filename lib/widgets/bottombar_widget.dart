import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    super.key,
    required this.onChangePage,
  });

  final ValueChanged<int> onChangePage;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              widget.onChangePage(0);
              setState(() {
                currentIndex = 0;
              });
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              widget.onChangePage(1);
              setState(() {
                currentIndex = 1;
              });
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          label: 'Search',
        ),
      ],
    );
  }
}
