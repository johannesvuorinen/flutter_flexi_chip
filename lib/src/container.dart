import 'package:flutter/widgets.dart';

class ChipContainer extends StatelessWidget {
  const ChipContainer({
    Key? key,
    required this.child,
    required this.height,
    this.color,
    this.shape,
    this.shadowColor = const Color(0xFF000000),
    this.clipBehavior = Clip.antiAlias,
    this.elevation = 0.0,
  }) : super(key: key);

  final Widget child;
  final double height;
  final Color? color;
  final Color shadowColor;
  final double elevation;
  final ShapeBorder? shape;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.maybeOf(context);
    final borderClipper = shape == null
        ? null
        : ShapeBorderClipper(
            textDirection: textDirection,
            shape: shape!,
          );

    Widget contents = SizedBox(
      height: height,
      child: child,
    );

    if (shape != null) {
      contents = ShapeBorderPaint(
        shape: shape!,
        textDirection: textDirection,
        child: contents,
      );
    }

    if (color == null) {
      return ClipPath(
        clipper: borderClipper,
        clipBehavior: clipBehavior,
        child: contents,
      );
    }

    if (shape == null) {
      return PhysicalModel(
        color: color!,
        elevation: elevation,
        shadowColor: shadowColor,
        clipBehavior: clipBehavior,
        child: contents,
      );
    }

    return PhysicalShape(
      color: color!,
      elevation: elevation,
      shadowColor: shadowColor,
      clipBehavior: clipBehavior,
      clipper: borderClipper!,
      child: contents,
    );
  }
}

class ShapeBorderPaint extends StatelessWidget {
  const ShapeBorderPaint({
    Key? key,
    required this.child,
    required this.shape,
    this.textDirection,
    this.isForeground = true,
  }) : super(key: key);

  final Widget child;
  final ShapeBorder shape;
  final TextDirection? textDirection;
  final bool isForeground;

  @override
  Widget build(BuildContext context) {
    final painter = ShapeBorderPainter(shape, textDirection);
    return CustomPaint(
      painter: isForeground ? null : painter,
      foregroundPainter: isForeground ? painter : null,
      child: child,
    );
  }
}

class ShapeBorderPainter extends CustomPainter {
  ShapeBorderPainter(this.shape, this.textDirection);
  final ShapeBorder shape;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    shape.paint(canvas, Offset.zero & size, textDirection: textDirection);
  }

  @override
  bool shouldRepaint(ShapeBorderPainter oldDelegate) {
    return oldDelegate.shape != shape;
  }
}
