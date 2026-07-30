import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotebookBackground extends StatelessWidget {
  final Widget child;
  const NotebookBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [Positioned.fill(child: CustomPaint(painter: _NotebookPainter())), child]);
  }
}

class _NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.paperCream);

    final shadow = Paint()..shader = const LinearGradient(colors: [Colors.transparent, Colors.black12])
      .createShader(Rect.fromLTWH(size.width - 26, 0, 26, size.height));
    canvas.drawRect(Rect.fromLTWH(size.width - 26, 0, 26, size.height), shadow);

    final linePaint = Paint()..color = AppColors.lineBlue..strokeWidth = 1.4;
    for (double y = 100; y < size.height; y += 44) {
      canvas.drawLine(Offset(66, y), Offset(size.width, y), linePaint);
    }
    canvas.drawLine(Offset(66, 0), Offset(66, size.height), Paint()..color = AppColors.marginRed..strokeWidth = 2);

    final ringPaint = Paint()..color = Colors.grey.shade400..style = PaintingStyle.stroke..strokeWidth = 2.5;
    final ringShadow = Paint()..color = Colors.black12;
    for (double y = 28; y < size.height; y += 38) {
      canvas.drawCircle(Offset(20, y), 9, ringShadow);
      canvas.drawCircle(Offset(19, y - 1), 9, ringPaint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
