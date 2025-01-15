import 'package:flutter/material.dart';

class RightToLeftPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  RightToLeftPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0,
                0.0); // Start the transition from the right (x: 1.0, y: 0.0)
            const end = Offset
                .zero; // End the transition at the center (x: 0.0, y: 0.0)
            const curve = Curves.easeInOut; // You can use other curves as well

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}
