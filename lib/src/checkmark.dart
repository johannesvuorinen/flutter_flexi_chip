import 'package:flutter/widgets.dart';

class FlexiCheckmark extends StatelessWidget {
  const FlexiCheckmark({
    Key? key,
    required this.progress,
    required this.color,
    required this.width,
    required this.size,
  }) : super(key: key);

  final double progress;
  final Color color;
  final double width;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: FlexiCheckmarkPainter(
        progress: progress,
        color: color,
        width: width,
      ),
    );
  }
}

class FlexiCheckmarkPainter extends CustomPainter {
  FlexiCheckmarkPainter({
    required this.progress,
    required this.color,
    required this.width,
  });

  final double progress;
  final Color color;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = width;

    const origin = Offset(0, 0);

    // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
    // short side to the long side.
    final Path path = Path();
    final Offset start = Offset(size.width * 0.15, size.height * 0.45);
    final Offset mid = Offset(size.width * 0.4, size.height * 0.7);
    final Offset end = Offset(size.width * 0.85, size.height * 0.25);
    if (progress < 0.5) {
      final double strokeT = progress * 2.0;
      final Offset drawMid = Offset.lerp(start, mid, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
    } else {
      final double strokeT = (progress - 0.5) * 2.0;
      final Offset drawEnd = Offset.lerp(mid, end, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
      path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FlexiCheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.width != width;
  }
}
