import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotebookBackground extends StatelessWidget {
  final Widget child;
  const NotebookBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _NotebookPainter(),
          ),
        ),
        child,
      ],
    );
  }
}

class _NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = AppColors.paperCream;
    canvas.drawRect(Offset.zero & size, bg);

    final linePaint = Paint()
      ..color = AppColors.lineBlue
      ..strokeWidth = 1.4;
    const lineGap = 44.0;
    for (double y = 100; y < size.height; y += lineGap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final marginPaint = Paint()
      ..color = AppColors.marginRed
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(48, 0),
      Offset(48, size.height),
      marginPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
