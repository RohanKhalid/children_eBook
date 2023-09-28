import 'package:flutter/material.dart';

class FadeInPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeInPageRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const curve = Curves.easeInOut;
            var opacityTween = Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );

            // Adjust the duration by changing the duration property of Tween
            var fadeInAnimation = opacityTween.animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(
                    0.0, 1.0), // You can adjust the interval here
              ),
            );

            return FadeTransition(
              opacity: fadeInAnimation,
              child: child,
            );
          },
        );
}
