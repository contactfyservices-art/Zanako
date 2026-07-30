import 'dart:math' as math;
import 'package:flutter/material.dart';

Route _pageTurnRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondary) => page,
    transitionsBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return AnimatedBuilder(
        animation: curved,
        child: child,
        builder: (context, child) {
          final angle = (1 - curved.value) * -math.pi / 2;
          return Transform(
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0012)..rotateY(angle),
            child: Opacity(opacity: curved.value, child: child),
          );
        },
      );
    },
  );
}

void pushPage(BuildContext context, Widget page) => Navigator.of(context).push(_pageTurnRoute(page));
void pushReplacementPage(BuildContext context, Widget page) => Navigator.of(context).pushReplacement(_pageTurnRoute(page));
