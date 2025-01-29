import 'package:flutter/material.dart';

PageRouteBuilder fadeTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 600), // Smooth transition
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

PageRouteBuilder slideTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 700), // Smooth transition
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slideAnimation = Tween<Offset>(
        begin: Offset(1.0, 0.0), // Start from right
        end: Offset(0.0, 0.0), // Slide to left
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut, // Smooth easing
      ));

      return SlideTransition(
        position: slideAnimation,
        child: child,
      );
    },
  );
}
