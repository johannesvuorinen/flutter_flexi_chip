import 'package:flutter/widgets.dart';

class ChipContainer extends StatelessWidget {
  const ChipContainer({
    Key? key,
    required this.child,
    required this.height,
    required this.decoration,
    required this.shadowColor,
    required this.color,
    required this.shape,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.elevation = 0.0,
  }) : super(key: key);

  final Widget child;
  final double height;
  final Decoration decoration;
  final Color shadowColor;
  final Color color;
  final ShapeBorder shape;
  final BorderRadiusGeometry? borderRadius;
  final Clip clipBehavior;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: color,
      clipBehavior: clipBehavior,
      shadowColor: shadowColor,
      elevation: elevation,
      clipper: ShapeBorderClipper(
        textDirection: Directionality.maybeOf(context),
        shape: shape,
      ),
      child: ShapeBorderPaint(
        shape: shape,
        child: SizedBox(
          height: height,
          child: child,
        ),
      ),
    );
  }
}

class ShapeBorderPaint extends StatelessWidget {
  const ShapeBorderPaint({
    Key? key,
    required this.child,
    required this.shape,
    this.isForeground = true,
  }) : super(key: key);

  final Widget child;
  final ShapeBorder shape;
  final bool isForeground;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: isForeground
          ? null
          : ShapeBorderPainter(shape, Directionality.maybeOf(context)),
      foregroundPainter: isForeground
          ? ShapeBorderPainter(shape, Directionality.maybeOf(context))
          : null,
      child: child,
    );
  }
}

class ShapeBorderPainter extends CustomPainter {
  ShapeBorderPainter(this.border, this.textDirection);
  final ShapeBorder border;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    border.paint(canvas, Offset.zero & size, textDirection: textDirection);
  }

  @override
  bool shouldRepaint(ShapeBorderPainter oldDelegate) {
    return oldDelegate.border != border;
  }
}
