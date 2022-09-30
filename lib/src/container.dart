import 'package:flutter/widgets.dart';
import './style.dart';

class ChipContainer extends StatelessWidget {
  const ChipContainer({
    Key? key,
    required this.color,
    required this.shadowColor,
    required this.shape,
    required this.clipBehavior,
    required this.elevation,
    required this.decoration,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Color shadowColor;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final double elevation;
  final Decoration decoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: color,
      shadowColor: shadowColor,
      elevation: elevation,
      clipBehavior: clipBehavior,
      clipper: ShapeBorderClipper(
        textDirection: Directionality.maybeOf(context),
        shape: shape,
      ),
      child: _ShapeBorderPaint(
        borderOnForeground: true,
        shape: shape,
        child: SizedBox(
          height: FlexiChipStyle.defaultHeight,
          child: DecoratedBox(
            decoration: decoration,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _ShapeBorderPaint extends StatelessWidget {
  const _ShapeBorderPaint({
    required this.child,
    required this.shape,
    this.borderOnForeground = true,
  });

  final Widget child;
  final ShapeBorder shape;
  final bool borderOnForeground;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: borderOnForeground
          ? null
          : _ShapeBorderPainter(shape, Directionality.maybeOf(context)),
      foregroundPainter: borderOnForeground
          ? _ShapeBorderPainter(shape, Directionality.maybeOf(context))
          : null,
      child: child,
    );
  }
}

class _ShapeBorderPainter extends CustomPainter {
  _ShapeBorderPainter(this.border, this.textDirection);

  final ShapeBorder border;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    border.paint(canvas, Offset.zero & size, textDirection: textDirection);
  }

  @override
  bool shouldRepaint(_ShapeBorderPainter oldDelegate) {
    return oldDelegate.border != border;
  }
}
