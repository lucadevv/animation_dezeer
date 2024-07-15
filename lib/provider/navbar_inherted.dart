import 'package:flutter/material.dart';

class NavbarInhertedWidget extends InheritedWidget {
  final PageController pageController;
  const NavbarInhertedWidget({
    super.key,
    required super.child,
    required this.pageController,
  });

  static NavbarInhertedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NavbarInhertedWidget>();
  }

  @override
  bool updateShouldNotify(NavbarInhertedWidget oldWidget) {
    return oldWidget.pageController != pageController;
  }
}
